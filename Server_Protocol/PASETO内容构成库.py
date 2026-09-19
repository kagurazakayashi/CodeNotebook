"""
Yashi PASETO 令牌解析库
===============

提供 PASETO（Platform-Agnostic SEcurity TOkens）令牌的结构解析功能，
对 public 令牌解码其载荷声明，对 local 令牌支持可选密钥解密。

用法
----
::

    from PASETO内容构成库 import parse_paseto

    result = parse_paseto("v2.public.eyJleHAiOi...")
    print(result["version_info"])   # 访问版本详情
    print(result["algorithm"])      # 访问算法信息
    print(result["payload"])        # 访问载荷内容

    # 对 local 令牌传入密钥以解密：
    result = parse_paseto("v2.local.xxx", key=bytes.fromhex("7071...8f"))

返回结构
--------

``parse_paseto()`` 返回一个字典，包含以下顶层键：:

    {
        "valid": bool,           # 令牌是否通过基础校验
        "raw": {                 # 原始段信息
            "version": str,      # 版本字符串，如 "v2"
            "purpose": str,      # 用途字符串，如 "public" / "local"
            "payload_raw": str,  # payload 段的原始 Base64url 字符串
            "footer_raw": str|None,  # footer 段的原始 Base64url 字符串
            "segment_count": int,    # 段数（3 或 4）
        },
        "version_info": {        # 版本详情
            "version": str,
            "supports_implicit_assertions": bool,   # v3/v4 支持隐性断言
            "note": str,
        },
        "algorithm": {           # 算法信息
            "style": str,        # "NIST 兼容" 或 "现代"
            "name": str,         # 算法名称
            "version": str,
            "purpose": str,
        },
        "payload": {             # 载荷解析结果
            "decodable": bool,   # 是否可解码（public=True, local=有密钥）
            "note": str|None,    # 补充说明
            "claims": dict|None,      # 全部原始声明
            "standard_claims": dict,  # 标准声明（始终 7 项）
            "custom_claims": dict|None,   # 自定义声明
        },
        "footer": {              # Footer 解析结果
            "present": bool,
            "raw": str|None,
            "parsed": dict|str|None,
            "note": str|None,
        },
        "warnings": list[str],   # 异常提示列表
    }

注意事项
--------

- 密钥须为 32 字节（256 位）的对称密钥，所有版本共用同一密钥。
- v3/v4 的隐性断言（implicit_assertion）须在调用时通过参数传入。
- 本库不执行 public 令牌的签名验证（需要非对称公钥，不在 scope 内）。

依赖安装
--------

仅做结构解析（public 令牌 + local 元数据）**无需**安装任何额外包。
如需解密 local 令牌，按需安装以下可选库：:

    pip install cryptography   # v1 / v3 local 解密（AES-256-CTR + HMAC-SHA384 + HKDF）
    pip install pynacl         # v2 / v4 local 解密（XChaCha20-Poly1305）
"""

import base64
import hashlib
import hmac
import json
import struct
from datetime import datetime, timezone
from typing import Any

# ──────────────────────────────────────────────────────────────────
# 可选密码学依赖
# ──────────────────────────────────────────────────────────────────

try:
    from nacl.bindings import crypto_aead_xchacha20poly1305_ietf_decrypt
    from nacl.exceptions import CryptoError as _NaclCryptoError
    _NACL_AVAILABLE = True
except ImportError:
    _NACL_AVAILABLE = False
    _NaclCryptoError = Exception

try:
    from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.kdf.hkdf import HKDF
    _CRYPTOGRAPHY_AVAILABLE = True
except ImportError:
    _CRYPTOGRAPHY_AVAILABLE = False

# ──────────────────────────────────────────────────────────────────
# 模块级常量
# ──────────────────────────────────────────────────────────────────

_VALID_VERSIONS = frozenset({"v1", "v2", "v3", "v4"})
_VALID_PURPOSES = frozenset({"local", "public"})

_ALGORITHMS = {
    "v1": {
        "local":  {"style": "NIST 兼容", "name": "AES-256-CTR + HMAC-SHA384"},
        "public": {"style": "NIST 兼容", "name": "RSASSA-PSS 2048 + SHA384"},
    },
    "v2": {
        "local":  {"style": "现代",      "name": "XChaCha20-Poly1305"},
        "public": {"style": "现代",      "name": "Ed25519"},
    },
    "v3": {
        "local":  {"style": "NIST 兼容", "name": "AES-256-CTR + HMAC-SHA384"},
        "public": {"style": "NIST 兼容", "name": "ECDSA NIST P-384 + SHA384"},
    },
    "v4": {
        "local":  {"style": "现代",      "name": "XChaCha20-Poly1305"},
        "public": {"style": "现代",      "name": "Ed25519"},
    },
}

_STANDARD_CLAIMS = frozenset({"iss", "sub", "aud", "exp", "nbf", "iat", "jti"})

_CLAIM_LABELS = {
    "iss": "签发者 (Issuer)",
    "sub": "主体 (Subject)",
    "aud": "接收方 (Audience)",
    "exp": "过期时间 (Expiration)",
    "nbf": "生效时间 (Not Before)",
    "iat": "签发时间 (Issued At)",
    "jti": "令牌唯一 ID (JWT ID)",
}

# ──────────────────────────────────────────────────────────────────
# 内部工具函数
# ──────────────────────────────────────────────────────────────────


def _b64url_decode(data: str) -> bytes:
    """Base64url 解码，自动补齐填充符。"""
    padding = 4 - len(data) % 4
    if padding != 4:
        data += "=" * padding
    return base64.urlsafe_b64decode(data)


def _try_parse_json(raw: bytes) -> Any | None:
    """尝试将字节串解析为 JSON 对象，失败返回 None。"""
    try:
        return json.loads(raw)
    except (json.JSONDecodeError, UnicodeDecodeError):
        return None


def _try_deep_parse_value(value: Any) -> Any:
    """若值为 JSON 格式字符串，尝试解析为 Python 对象；否则原样返回。"""
    if isinstance(value, str):
        stripped = value.strip()
        if (stripped.startswith("{") and stripped.endswith("}")) or \
           (stripped.startswith("[") and stripped.endswith("]")):
            try:
                return json.loads(stripped)
            except (json.JSONDecodeError, ValueError):
                pass
    return value


def _try_format_datetime(claims: dict, key: str) -> str | None:
    """尝试将声明中的 ISO 8601 时间字符串转换为本地时间格式。"""
    value = claims.get(key)
    if not isinstance(value, str):
        return None
    try:
        dt = datetime.fromisoformat(value)
        if dt.tzinfo is None:
            dt = dt.replace(tzinfo=timezone.utc)
        local_dt = dt.astimezone()
        return local_dt.strftime("%Y-%m-%d %H:%M:%S %Z")
    except (ValueError, OverflowError):
        return value


# ──────────────────────────────────────────────────────────────────
# PAE（Pre-Authentication Encoding）
# ──────────────────────────────────────────────────────────────────


def _pae(pieces: list[bytes]) -> bytes:
    """PASETO 规范的预认证编码（Pre-Authentication Encoding）。

    将多个字节数组按 LE64(长度) + 数据的格式串联，防止标准攻击。

    Args:
        pieces: 待编码的字节数组列表

    Returns:
        编码后的连接字节串
    """
    output = struct.pack("<Q", len(pieces))
    for piece in pieces:
        output += struct.pack("<Q", len(piece))
        output += piece
    return output


# ──────────────────────────────────────────────────────────────────
# 各版本 local 令牌解密实现
# ──────────────────────────────────────────────────────────────────


def _decrypt_v1_local(key: bytes, n: bytes, c: bytes, t: bytes,
                      footer: bytes) -> bytes:
    """v1.local 解密：AES-256-CTR + HMAC-SHA384，密钥通过 HKDF 派生。

    Args:
        key: 原始 32 字节对称密钥
        n: 从令牌中提取的 32 字节 nonce
        c: 密文
        t: 48 字节 HMAC-SHA384 认证标签
        footer: footer 原始字节（可能为空）

    Returns:
        解密后的明文载荷字节

    Raises:
        ValueError: HMAC 验证失败
    """
    if not _CRYPTOGRAPHY_AVAILABLE:
        raise ImportError("v1 解密需要 cryptography 库: pip install cryptography")

    ek = HKDF(
        algorithm=hashes.SHA384(), length=32,
        salt=n[:16], info=b"paseto-encryption-key",
    ).derive(key)
    ak = HKDF(
        algorithm=hashes.SHA384(), length=32,
        salt=n[:16], info=b"paseto-auth-key-for-aead",
    ).derive(key)

    h = b"v1.local."
    pre_auth = _pae([h, n, c, footer])
    expected_t = hmac.new(ak, pre_auth, hashlib.sha384).digest()
    if not hmac.compare_digest(t, expected_t):
        raise ValueError("v1.local HMAC 验证失败，密钥或令牌不匹配")

    decryptor = Cipher(algorithms.AES(ek), modes.CTR(n[16:])).decryptor()
    return decryptor.update(c) + decryptor.finalize()


def _decrypt_v2_local(key: bytes, n: bytes, c: bytes,
                      footer: bytes) -> bytes:
    """v2.local 解密：XChaCha20-Poly1305。

    Args:
        key: 原始 32 字节对称密钥
        n: 从令牌中提取的 24 字节 nonce
        c: 密文 + Poly1305 标签（16 字节）
        footer: footer 原始字节（可能为空）

    Returns:
        解密后的明文载荷字节

    Raises:
        ImportError: PyNaCl 不可用
        ValueError: 认证失败
    """
    if not _NACL_AVAILABLE:
        raise ImportError("v2 解密需要 PyNaCl 库: pip install pynacl")

    h = b"v2.local."
    aad = _pae([h, n, footer])
    return crypto_aead_xchacha20poly1305_ietf_decrypt(c, aad, n, key)


def _decrypt_v3_local(key: bytes, n: bytes, c: bytes, t: bytes,
                      footer: bytes, implicit: bytes) -> bytes:
    """v3.local 解密：AES-256-CTR + HMAC-SHA384 + HKDF（含隐性断言）。

    Args:
        key: 原始 32 字节对称密钥
        n: 从令牌中提取的 32 字节 nonce
        c: 密文
        t: 48 字节 HMAC-SHA384 认证标签
        footer: footer 原始字节（可能为空）
        implicit: 隐性断言原始字节

    Returns:
        解密后的明文载荷字节

    Raises:
        ValueError: HMAC 验证失败
    """
    if not _CRYPTOGRAPHY_AVAILABLE:
        raise ImportError("v3 解密需要 cryptography 库: pip install cryptography")

    e = HKDF(
        algorithm=hashes.SHA384(), length=48, salt=None,
        info=b"paseto-encryption-key" + n,
    )
    a = HKDF(
        algorithm=hashes.SHA384(), length=48, salt=None,
        info=b"paseto-auth-key-for-aead" + n,
    )
    tmp = e.derive(key)
    ek = tmp[:32]
    n2 = tmp[32:]
    ak = a.derive(key)

    h = b"v3.local."
    pre_auth = _pae([h, n, c, footer, implicit])
    expected_t = hmac.new(ak, pre_auth, hashlib.sha384).digest()
    if not hmac.compare_digest(t, expected_t):
        raise ValueError("v3.local HMAC 验证失败，密钥、令牌或隐性断言不匹配")

    decryptor = Cipher(algorithms.AES(ek), modes.CTR(n2)).decryptor()
    return decryptor.update(c) + decryptor.finalize()


def _decrypt_v4_local(key: bytes, n: bytes, c: bytes,
                      footer: bytes, implicit: bytes) -> bytes:
    """v4.local 解密：XChaCha20-Poly1305（含隐性断言）。

    Args:
        key: 原始 32 字节对称密钥
        n: 从令牌中提取的 24 字节 nonce
        c: 密文 + Poly1305 标签（16 字节）
        footer: footer 原始字节（可能为空）
        implicit: 隐性断言原始字节

    Returns:
        解密后的明文载荷字节

    Raises:
        ImportError: PyNaCl 不可用
        ValueError: 认证失败
    """
    if not _NACL_AVAILABLE:
        raise ImportError("v4 解密需要 PyNaCl 库: pip install pynacl")

    h = b"v4.local."
    aad = _pae([h, n, footer, implicit])
    return crypto_aead_xchacha20poly1305_ietf_decrypt(c, aad, n, key)


def _decrypt_local(version: str, key: bytes, payload_bytes: bytes,
                   footer_bytes: bytes, implicit: bytes) -> bytes:
    """根据版本调度到对应的解密函数。

    Args:
        version: 版本字符串（v1/v2/v3/v4）
        key: 32 字节对称密钥
        payload_bytes: Base64url 解码后的 payload 字节
        footer_bytes: footer 原始字节
        implicit: 隐性断言原始字节

    Returns:
        解密后的明文载荷字节

    Raises:
        ValueError: 解密失败或库不可用
    """
    if version == "v1":
        n = payload_bytes[:32]
        c = payload_bytes[32:-48]
        t = payload_bytes[-48:]
        return _decrypt_v1_local(key, n, c, t, footer_bytes)
    elif version == "v2":
        n = payload_bytes[:24]
        c = payload_bytes[24:]
        return _decrypt_v2_local(key, n, c, footer_bytes)
    elif version == "v3":
        n = payload_bytes[:32]
        c = payload_bytes[32:-48]
        t = payload_bytes[-48:]
        return _decrypt_v3_local(key, n, c, t, footer_bytes, implicit)
    elif version == "v4":
        n = payload_bytes[:24]
        c = payload_bytes[24:]
        return _decrypt_v4_local(key, n, c, footer_bytes, implicit)
    else:
        raise ValueError(f"不支持的版本: {version}")


# ──────────────────────────────────────────────────────────────────
# Payload 声明解析（public 令牌及解密后的 local 令牌共用）
# ──────────────────────────────────────────────────────────────────


def _build_claims_from_json(payload_bytes: bytes) -> dict:
    """从 JSON 字节构建标准/自定义声明字典。

    Returns:
        与 parse_paseto 中 payload 字段格式一致的字典
    """
    claims = _try_parse_json(payload_bytes)
    if claims is None:
        return {
            "decodable": True,
            "note": "payload 已解码但非有效 JSON",
            "claims": None,
            "standard_claims": None,
            "custom_claims": None,
        }

    standard = {}
    custom = {}
    for k, v in claims.items():
        if k in _STANDARD_CLAIMS:
            standard[k] = v
        else:
            custom[k] = v

    standard_parsed = {}
    for claim_key in _STANDARD_CLAIMS:
        label = _CLAIM_LABELS.get(claim_key, claim_key)
        if claim_key in standard:
            raw_value = standard[claim_key]
            parsed_value = _try_deep_parse_value(raw_value)
            entry = {"label": label, "value": raw_value, "parsed": parsed_value}
            if claim_key in ("exp", "nbf", "iat"):
                formatted = _try_format_datetime(standard, claim_key)
                if formatted:
                    entry["formatted"] = formatted
        else:
            entry = {"label": label, "value": None, "parsed": None}
        standard_parsed[claim_key] = entry

    custom_parsed = {}
    for k, v in custom.items():
        custom_parsed[k] = _try_deep_parse_value(v)

    return {
        "decodable": True,
        "note": None,
        "claims": claims,
        "standard_claims": standard_parsed,
        "custom_claims": custom_parsed if custom_parsed else None,
    }


def _build_empty_claims() -> dict:
    """构建全 None 的标准声明字典（用于不可解码的场景）。"""
    standard_parsed = {}
    for claim_key in _STANDARD_CLAIMS:
        label = _CLAIM_LABELS.get(claim_key, claim_key)
        standard_parsed[claim_key] = {"label": label, "value": None, "parsed": None}
    return {
        "decodable": False,
        "note": None,
        "claims": None,
        "standard_claims": standard_parsed,
        "custom_claims": None,
    }


# ──────────────────────────────────────────────────────────────────
# 核心解析函数
# ──────────────────────────────────────────────────────────────────


def parse_paseto(token: str, key: bytes | str | None = None,
                 implicit_assertion: bytes | str | None = None) -> dict:
    """解析 PASETO 令牌字符串，返回结构化字典。

    这是本库唯一的公开接口。接收一个 PASETO 令牌，按 ``version.purpose.payload[.footer]``
    格式拆解后逐段解析。

    - public 令牌：自动 Base64url 解码 payload 中的 JSON 声明。
    - local 令牌：若提供 key，尝试解密后解析 JSON 声明。

    Args:
        token: PASETO 令牌字符串，如 ``"v2.public.eyJleHAiOi..."``
        key: 可选，32 字节对称密钥（用于 local 令牌解密）。
             可传入 bytes 或 hex 字符串。
        implicit_assertion: 可选，v3/v4 的隐性断言，
                            bytes 或 JSON 可序列化的对象。

    Returns:
        结构化字典，详见模块文档中的"返回结构"章节。

    Example:
        >>> result = parse_paseto("v2.public.eyJpc3MiOiAiaHR0cHM6Ly9hdXRoLmV4YW1wbGUuY29tIn0")
        >>> result["version_info"]["version"]
        'v2'
        >>> result["algorithm"]["name"]
        'Ed25519'

        >>> # 解密 local 令牌
        >>> key = bytes.fromhex("707172737475767778797a7b7c7d7e7f808182838485868788898a8b8c8d8e8f")
        >>> r = parse_paseto("v2.local.97TTO...", key=key)
        >>> r["payload"]["claims"]
        {'data': 'this is a signed message', 'exp': '2019-01-01T00:00:00+00:00'}
    """
    # ─── 参数标准化 ───
    if isinstance(key, str):
        key = bytes.fromhex(key)
    if isinstance(implicit_assertion, (dict, list)):
        implicit_assertion = json.dumps(
            implicit_assertion, ensure_ascii=False, separators=(",", ":")
        )
    if isinstance(implicit_assertion, str):
        implicit_assertion = implicit_assertion.encode("utf-8")
    if implicit_assertion is None:
        implicit_assertion = b""

    if key is not None and not isinstance(key, bytes):
        raise TypeError("key 必须为 bytes 或 hex 字符串")
    if key is not None and len(key) != 32:
        raise ValueError(f"密钥长度必须为 32 字节，当前 {len(key)} 字节")

    # ─── 初始化返回结构 ───
    result: dict = {
        "raw": {},
        "version_info": {},
        "algorithm": {},
        "payload": {},
        "footer": {},
        "warnings": [],
    }

    token = token.strip()

    # ─── 第 1 步：按 "." 拆分令牌段 ───
    parts = token.split(".")
    if len(parts) < 3 or len(parts) > 4:
        result["warnings"].append(
            f"段数异常（期望 3 或 4，实际 {len(parts)}），非标准 PASETO 令牌"
        )
        if len(parts) < 3:
            return result

    version = parts[0]
    purpose = parts[1]
    payload_raw = parts[2]
    footer_raw = parts[3] if len(parts) == 4 else None

    # ─── 第 2 步：记录原始段信息 ───
    result["raw"] = {
        "version": version,
        "purpose": purpose,
        "payload_raw": payload_raw,
        "footer_raw": footer_raw,
        "segment_count": len(parts),
    }

    # ─── 第 3 步：校验版本号 ───
    if version not in _VALID_VERSIONS:
        result["warnings"].append(
            f"未知版本 '{version}'，合法值为 {sorted(_VALID_VERSIONS)}"
        )

    # ─── 第 4 步：校验用途 ───
    if purpose not in _VALID_PURPOSES:
        result["warnings"].append(
            f"未知用途 '{purpose}'，合法值为 {sorted(_VALID_PURPOSES)}"
        )

    # ─── 第 5 步：构建版本信息 ───
    if version in _VALID_VERSIONS:
        result["version_info"] = {
            "version": version,
            "supports_implicit_assertions": version in ("v3", "v4"),
            "note": (
                "支持隐性断言（implicit assertions），不在令牌字符串中，由通信双方预先约定"
                if version in ("v3", "v4")
                else "不支持隐性断言"
            ),
        }

    # ─── 第 6 步：查表确定算法 ───
    if version in _VALID_VERSIONS and purpose in _VALID_PURPOSES:
        result["algorithm"] = dict(_ALGORITHMS[version][purpose])
        result["algorithm"]["version"] = version
        result["algorithm"]["purpose"] = purpose

    # ─── 第 7 步：解析 footer 原始字节 ───
    footer_bytes = b""
    if footer_raw:
        try:
            footer_bytes = _b64url_decode(footer_raw)
        except Exception as e:
            result["warnings"].append(f"footer Base64url 解码失败: {e}")

    # ─── 第 8 步：解析 payload ───
    if purpose == "local":
        if key is not None:
            # ─── 尝试解密 local 令牌 ───
            payload_bytes_raw = None
            try:
                payload_bytes_raw = _b64url_decode(payload_raw)
            except Exception as e:
                result["warnings"].append(f"payload Base64url 解码失败: {e}")

            if payload_bytes_raw is not None:
                try:
                    plaintext = _decrypt_local(
                        version, key, payload_bytes_raw,
                        footer_bytes, implicit_assertion,
                    )
                except ImportError as e:
                    result["warnings"].append(f"解密库不可用: {e}")
                    result["payload"] = _build_empty_claims()
                    result["payload"]["note"] = f"缺少密码学库: {e}"
                except (_NaclCryptoError, ValueError) as e:
                    result["warnings"].append(f"local 令牌解密失败: {e}")
                    result["payload"] = _build_empty_claims()
                    result["payload"]["note"] = "解密失败，密钥或令牌不匹配"
                else:
                    result["payload"] = _build_claims_from_json(plaintext)
                    result["payload"]["note"] = "已使用密钥解密"
        else:
            # ─── 无密钥，不可解码 ───
            result["payload"] = _build_empty_claims()
            result["payload"]["note"] = (
                "local 令牌的 payload 为密文，需提供 32 字节密钥解密后才能查看内容"
            )
    else:
        # ─── public 令牌：Base64url 解码 JSON ───
        payload_bytes = None
        try:
            payload_bytes = _b64url_decode(payload_raw)
        except Exception as e:
            result["warnings"].append(f"payload Base64url 解码失败: {e}")

        if payload_bytes is not None:
            result["payload"] = _build_claims_from_json(payload_bytes)
        else:
            result["payload"] = _build_empty_claims()
            result["payload"]["note"] = "payload 解码失败"

    # ─── 第 9 步：解析 footer（结构化展示） ───
    if footer_raw and footer_bytes:
        footer_parsed = _try_parse_json(footer_bytes)
        if footer_parsed is not None:
            result["footer"] = {
                "present": True,
                "raw": footer_raw,
                "parsed": footer_parsed,
                "note": (
                    "public 令牌的 footer 已被签名覆盖（不可篡改）"
                    if purpose == "public"
                    else "local 令牌的 footer 为明文，不加密"
                ),
            }
        else:
            result["footer"] = {
                "present": True,
                "raw": footer_raw,
                "parsed": footer_bytes.decode("utf-8", errors="replace"),
                "note": "footer 非 JSON 格式",
            }
    else:
        result["footer"] = {
            "present": False,
            "raw": None,
            "parsed": None,
        }

    # ─── 第 10 步：最终有效性判定 ───
    if result["warnings"]:
        result["valid"] = False
    elif version in _VALID_VERSIONS and purpose in _VALID_PURPOSES:
        result["valid"] = True
    else:
        result["valid"] = False

    return result


# ──────────────────────────────────────────────────────────────────
# 模块自测
# ──────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    import pprint

    key_hex = "707172737475767778797a7b7c7d7e7f808182838485868788898a8b8c8d8e8f"

    print("=== public 令牌解析 ===")
    demo_public = (
        "v2.public.eyJpc3MiOiAiaHR0cHM6Ly9hdXRoLmV4YW1wbGUuY29tIiwgInN1YiI6IC"
        "J1c2VyXzEyMzQ1IiwgImF1ZCI6ICJhcGkuZXhhbXBsZS5jb20iLCAiZXhwIjogIjIwM"
        "jctMDEtMDFUMDA6MDA6MDBaIiwgIm5iZiI6ICIyMDI2LTAxLTAxVDAwOjAwOjAwWiIs"
        "ICJpYXQiOiAiMjAyNi0wMS0wMVQwMDowMDowMFoiLCAianRpIjogInRva19hYmMxMjM"
        "ifQ"  # noqa
    )
    pprint.pprint(parse_paseto(demo_public))

    print("\n=== local 令牌（无密钥） ===")
    pprint.pprint(parse_paseto("v2.local.97TTOvgwIxNGvV80XKiGZg_kD3tsXM_-qB4dZGHOeN1cTkgQ4PnW8888l802W8d9AvEGnoNBY3BnqHORy8a5cC8aKpbA0En8XELw2yDk2f1sVODyfnDbi6rEGMY3pSfCbLWMM2oHJxvlEl2XbQ"))

    print("\n=== local 令牌（带密钥解密） ===")
    r = parse_paseto(
        "v2.local.97TTOvgwIxNGvV80XKiGZg_kD3tsXM_-qB4dZGHOeN1cTkgQ4PnW8888l802W8d9AvEGnoNBY3BnqHORy8a5cC8aKpbA0En8XELw2yDk2f1sVODyfnDbi6rEGMY3pSfCbLWMM2oHJxvlEl2XbQ",
        key=key_hex,
    )
    pprint.pprint(r["payload"]["claims"])
