keytool -genkeypair -v -keystore key.jks -alias upload -keyalg RSA -keysize 4096 -validity 29200 -storetype PKCS12
# 密钥长度 -keysize 4096
# 有效期天 -validity 29200
# 存储类型 -storetype PKCS12

pwgen 4096 1

# 如果你讨厌一个一个回答问题
keytool -genkeypair -v -keystore key.jks -alias upload -keyalg RSA -keysize 4096 -validity 29200 -storetype PKCS12 -dname "CN=KagurazakaMiyashi, OU=KagurazakaYashi, O=uuu.moe, L=Shinjuku, ST=Tokyo, C=JP"

# 将 key.jks 转换为 Base64 (编码)
# macOS / Linux
base64 -i key.jks >key.txt
# Windows
certutil -encode key.jks key.txt

# 将 Base64 还原为 key.jks (解码)
echo "你的BASE64字符串" | base64 -d > key.jks
# 如果是在 macOS 上，有时需要大写的 -D
echo "你的BASE64字符串" | base64 -D > key.jks

# 在 GitHub Actions 中自动化处理
# - name: Decode Keystore
#   run: |
#     echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/key.jks
