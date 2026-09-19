# PASETO 令牌内容构成

PASETO（Platform-Agnostic SEcurity TOkens）令牌由 **`.`** 分隔的若干段组成。

```
version.purpose.payload[.footer]
```

v3/v4 额外支持隐性断言（implicit assertions），不包含在令牌字符串中，由通信双方预先约定。

---

## 令牌格式总览

| 段      | 是否必需 | 说明                                                          |
| ------- | -------- | ------------------------------------------------------------- |
| version | 必需     | 协议版本，取值为 `v1` / `v2` / `v3` / `v4`                    |
| purpose | 必需     | 用途，`local`（对称加密）或 `public`（非对称签名）            |
| payload | 必需     | Base64url 编码的载荷，local 下加密，public 下仅签名不加密     |
| footer  | 可选     | Base64url 编码的附加数据，local 下不加密，public 下被签名覆盖 |

---

## 版本与算法对照

| 版本 | 风格      | local（对称加密）         | public（非对称签名）      |
| ---- | --------- | ------------------------- | ------------------------- |
| v1   | NIST 兼容 | AES-256-CTR + HMAC-SHA384 | RSASSA-PSS 2048 + SHA384  |
| v2   | 现代      | XChaCha20-Poly1305        | Ed25519                   |
| v3   | NIST 兼容 | AES-256-CTR + HMAC-SHA384 | ECDSA NIST P-384 + SHA384 |
| v4   | 现代      | XChaCha20-Poly1305        | Ed25519                   |

> v3/v4 相对于 v1/v2 的主要改进：支持隐性断言（implicit assertions），防止令牌在不同上下文间被重放。

---

## local 类型 Payload 构成

`local` 令牌的 payload 在解密前是密文，解密后得到以下 JSON：

| 字段     | 类型 | 必需 | 说明                                        |
| -------- | ---- | ---- | ------------------------------------------- |
| 任意声明 | any  | 否   | 用户自定义键值对，与 JWT 的 Claims 相同语义 |

> local 令牌**没有预定义的标准注册声明**，所有键均由用户自行定义。常见的习惯用名与 public 一致。

---

## public 类型 Payload 构成

`public` 令牌的 payload 解密/解码后为 JSON，常见声明如下：

| 字段 | 全称       | 类型     | 说明                      | 示例                         |
| ---- | ---------- | -------- | ------------------------- | ---------------------------- |
| iss  | Issuer     | string   | 签发者标识                | `"https://auth.example.com"` |
| sub  | Subject    | string   | 令牌主体（通常是用户 ID） | `"user_12345"`               |
| aud  | Audience   | string   | 接收方标识                | `"api.example.com"`          |
| exp  | Expiration | datetime | 过期时间（ISO 8601）      | `"2026-01-01T00:00:00Z"`     |
| nbf  | Not Before | datetime | 生效时间（ISO 8601）      | `"2026-01-01T00:00:00Z"`     |
| iat  | Issued At  | datetime | 签发时间（ISO 8601）      | `"2026-01-01T00:00:00Z"`     |
| jti  | JWT ID     | string   | 令牌唯一 ID，防重放       | `"tok_abc123"`               |

> public 令牌也允许自定义额外声明，以上为 PASETO 规范推荐的保留声明名。

---

## Footer 构成

| 属性   | 说明                                              |
| ------ | ------------------------------------------------- |
| 编解码 | Base64url 编码                                    |
| 用途   | 存放不敏感的元数据（如 child key ID、算法提示等） |
| local  | 明文存放，不加密                                  |
| public | 明文存放，但被签名覆盖（不可篡改）                |

**常见 Footer 示例（kid）：**

```json
{
  "kid": "key-2026-01"
}
```

---

## 完整示例

### local (v2)

```
v2.local.xEH1Fk...payload-base64url...DkZ
```

### public (v2)

```
v2.public.eyJleHAiOiAiMjAyNi0wMS0wMVQwMDowMDowMFoifQ...signature
```

### 带 Footer

```
v2.public.eyJleHAiOiAiMjAyNi0wMS0wMVQwMDowMDowMFoifQ...signature.eyJraWQiOiJrZXktMjAyNi0wMSJ9
```

---

## JWT 与 PASETO 声明映射

| JWT 注册声明 | PASETO 对应 | 语义完全一致 |
| ------------ | ----------- | ------------ |
| `iss`        | `iss`       | 是           |
| `sub`        | `sub`       | 是           |
| `aud`        | `aud`       | 是           |
| `exp`        | `exp`       | 是           |
| `nbf`        | `nbf`       | 是           |
| `iat`        | `iat`       | 是           |
| `jti`        | `jti`       | 是           |

> 参考：[PASETO RFC (draft)](https://paseto.io/)、[PASETO 规范仓库](https://github.com/paseto-standard/paseto-spec)
