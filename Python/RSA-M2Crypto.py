# -*- coding: UTF-8 -*-
import M2Crypto

pkcs1_public='''-----BEGIN RSA PUBLIC KEY ... END RSA PUBLIC KEY-----'''

pkcs1_private='''-----BEGIN RSA PRIVATE KEY ... END RSA PRIVATE KEY-----'''

pkcs8_public='''-----BEGIN PUBLIC KEY ... END PUBLIC KEY-----'''

pkcs8_private='''-----BEGIN PRIVATE KEY ... END PRIVATE KEY-----'''


def private_encrypt(data,private_key):
	bio = M2Crypto.BIO.MemoryBuffer(private_key)
	rsa_pri = M2Crypto.RSA.load_key_bio(bio)
	ctxt_pri = rsa_pri.private_encrypt(data, M2Crypto.RSA.pkcs1_padding) 
	ctxt64_pri = ctxt_pri.encode('base64')
	return ctxt64_pri

def public_decrypt(msg,public_key):
	bio = M2Crypto.BIO.MemoryBuffer(public_key)
	rsa_pub = M2Crypto.RSA.load_pub_key_bio(bio)
	ctxt_pri = msg.decode("base64")
	output = rsa_pub.public_decrypt(ctxt_pri, M2Crypto.RSA.pkcs1_padding)
	return output

def public_encrypt(data,public_key):
	bio = M2Crypto.BIO.MemoryBuffer(public_key)
	rsa_pub = M2Crypto.RSA.load_pub_key_bio(bio)
	ctxt_pri = rsa_pub.public_encrypt(data, M2Crypto.RSA.pkcs1_padding) 
	ctxt64_pri = ctxt_pri.encode('base64')
	return ctxt64_pri

def private_decrypt(msg,private_key):
	bio = M2Crypto.BIO.MemoryBuffer(private_key)
	rsa_pri = M2Crypto.RSA.load_key_bio(bio)
	ctxt_pri = msg.decode("base64")
	output = rsa_pri.private_decrypt(ctxt_pri, M2Crypto.RSA.pkcs1_padding)
	return output

print private_decrypt(public_encrypt("PKCS#8公钥加密，PKCS#8私钥解密",pkcs8_public),pkcs8_private)
print private_decrypt(public_encrypt("PKCS#8公钥加密，PKCS#1私钥解密",pkcs8_public),pkcs1_private)
print public_decrypt(private_encrypt("PKCS#8私钥加密，PKCS#8公钥解密",pkcs8_private),pkcs8_public)
print public_decrypt(private_encrypt("PKCS#1私钥加密，PKCS#8公钥解密",pkcs1_private),pkcs8_public)


#print private_decrypt(public_encrypt("PKCS#1公钥加密，PKCS#8私钥解密",pkcs1_public),pkcs8_private)
#print private_decrypt(public_encrypt("PKCS#1公钥加密，PKCS#1私钥解密",pkcs1_public),pkcs1_private)
#print public_decrypt(private_encrypt("PKCS#8私钥加密，PKCS#1公钥解密",pkcs8_private),pkcs1_public)
#print public_decrypt(private_encrypt("PKCS#1私钥加密，PKCS#1公钥解密",pkcs1_private),pkcs1_public)


# https://xuanxuanblingbling.github.io/ctf/web/2019/05/10/rsa/


# 创建
rsakeys = RSA.gen_key(4096, 65537)
bio=BIO.MemoryBuffer()
rsakeys.save_key_bio(bio, None)
privatekey=bio.read_all()
rsakeys.save_pub_key_bio(bio)
publickey=bio.read_all()