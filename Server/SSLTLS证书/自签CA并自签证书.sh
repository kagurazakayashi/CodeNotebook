#!/bin/bash

# ==================================================
# 自签名 CA & HTTPS 证书生成脚本
# 生成 RSA, ECC, Ed25519 证书
# 生成 Fullchain 及 PFX 格式
# 不设置任何密码
# 避免覆盖已存在证书
# ==================================================

echo "-------------------------------------------"
echo "| 开始执行 HTTPS 证书批量生成脚本...      |"
echo "-------------------------------------------"

# ==============================
# 配置区（可修改）
# ==============================

# 证书有效期（天）
CA_DAYS=3650   # CA 证书有效期（10 年）
CERT_DAYS=1095 # 域名证书有效期（3 年）

# RSA 密钥长度（可选：2048, 3072, 4096）
RSA_KEY_SIZE=4096

# ECC 曲线（可选：prime256v1, secp384r1, secp521r1）
ECC_CURVE="secp521r1"

# 哈希算法（可选：sha256, sha384, sha512）
HASH_ALGO="sha512"

# CA 名称（CA 证书 CN）
CA_NAME="uuu.moe"

# 需要生成证书的域名列表
DOMAINS=("a.uuu.moe" "b.uuu.moe")

# 证书信息（可自定义）
COUNTRY="CN"
STATE="某省"
CITY="某市"
ORGANIZATION="uuu.moe"
ORG_UNIT="Web"

# ==============================
# 开始生成证书
# ==============================

# 创建目录存放证书
mkdir -p certs
cd certs || exit 1

# ==============================
# 生成 RSA CA 证书（如果不存在）
# ==============================
if [[ ! -f "${CA_NAME}-ca-rsa.crt" || ! -f "${CA_NAME}-ca-rsa.key" ]]; then
    echo "[生成] 生成 RSA CA 证书..."
    openssl genpkey -algorithm RSA -out "${CA_NAME}-ca-rsa.key" -pkeyopt rsa_keygen_bits:$RSA_KEY_SIZE
    openssl req -x509 -new -nodes -key "${CA_NAME}-ca-rsa.key" -$HASH_ALGO -days "$CA_DAYS" \
        -out "${CA_NAME}-ca-rsa.crt" \
        -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=CA/CN=$CA_NAME"
    echo "[完成] RSA CA 证书已生成：${CA_NAME}-ca-rsa.crt"
else
    echo "[跳过] RSA CA 证书已存在，跳过生成。"
fi

# ==============================
# 生成 ECC CA 证书（如果不存在）
# ==============================
if [[ ! -f "${CA_NAME}-ca-ecc.crt" || ! -f "${CA_NAME}-ca-ecc.key" ]]; then
    echo "[生成] 生成 ECC CA 证书..."
    openssl ecparam -genkey -name "$ECC_CURVE" | openssl ec -out "${CA_NAME}-ca-ecc.key" -outform PEM
    openssl req -x509 -new -nodes -key "${CA_NAME}-ca-ecc.key" -$HASH_ALGO -days "$CA_DAYS" \
        -out "${CA_NAME}-ca-ecc.crt" \
        -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=CA/CN=$CA_NAME"
    echo "[完成] ECC CA 证书已生成：${CA_NAME}-ca-ecc.crt"
else
    echo "[跳过] ECC CA 证书已存在，跳过生成。"
fi

# ==============================
# 生成 Ed25519 CA 证书（如果不存在）
# ==============================
if [[ ! -f "${CA_NAME}-ca-ed25519.crt" || ! -f "${CA_NAME}-ca-ed25519.key" ]]; then
    echo "[生成] 生成 Ed25519 CA 证书..."
    openssl genpkey -algorithm Ed25519 -out "${CA_NAME}-ca-ed25519.key"
    openssl req -x509 -new -nodes -key "${CA_NAME}-ca-ed25519.key" -days "$CA_DAYS" \
        -out "${CA_NAME}-ca-ed25519.crt" \
        -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=CA/CN=$CA_NAME"
    echo "[完成] Ed25519 CA 证书已生成：${CA_NAME}-ca-ed25519.crt"
else
    echo "[跳过] Ed25519 CA 证书已存在，跳过生成。"
fi

# ==============================
# 遍历所有域名，生成 RSA, ECC, Ed25519 证书
# ==============================
for DOMAIN in "${DOMAINS[@]}"; do
    echo "-------------------------------------------"
    echo "[处理中] 域名：$DOMAIN"
    
    # 生成 Ed25519 证书（如果不存在）
    if [[ ! -f "${DOMAIN}-ed25519.crt" || ! -f "${DOMAIN}-ed25519.key" ]]; then
        echo "  - 生成 Ed25519 证书..."
        openssl genpkey -algorithm Ed25519 -out "${DOMAIN}-ed25519.key"
        openssl req -new -key "${DOMAIN}-ed25519.key" -out "${DOMAIN}-ed25519.csr" \
            -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$DOMAIN"
        openssl x509 -req -in "${DOMAIN}-ed25519.csr" -CA "${CA_NAME}-ca-ed25519.crt" -CAkey "${CA_NAME}-ca-ed25519.key" \
            -CAcreateserial -out "${DOMAIN}-ed25519.crt" -days "$CERT_DAYS"

        # 生成 Fullchain 证书
        cat "${DOMAIN}-ed25519.crt" "${CA_NAME}-ca-ed25519.crt" > "${DOMAIN}-ed25519.fullchain.crt"

        # 生成 PFX 文件（无密码）
        openssl pkcs12 -export -out "${DOMAIN}-ed25519.pfx" \
            -inkey "${DOMAIN}-ed25519.key" -in "${DOMAIN}-ed25519.crt" -certfile "${CA_NAME}-ca-ed25519.crt" \
            -nodes

        echo "  -> Ed25519 证书生成完成！"
    else
        echo "  -> Ed25519 证书已存在，跳过。"
    fi

    echo "[完成] 域名 $DOMAIN 处理完成！"
done

echo "-------------------------------------------"
echo "| 所有证书已生成完成！                     |"
echo "-------------------------------------------"
