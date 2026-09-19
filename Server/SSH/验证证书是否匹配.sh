# 验证证书是否匹配

# 1. 从私钥文件中提取公钥
ssh-keygen -y -f "id_rsa" > "extracted_public_key.pub"

# 2. 使用diff命令或任何文本比较工具来比较两个公钥文件
diff "id_rsa.pub" "extracted_public_key.pub"
