//
//  NSString+Security.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Security)

/*
 描述：Base64可以成为密码学的基石，非常重要。
 特点：可以将任意的二进制数据进行Base64编码
 结果：所有的数据都能被编码为并只用65个字符就能表示的文本文件。
 65字符：A~Z a~z 0~9 + / =
 对文件进行base64编码后文件数据的变化：编码后的数据~=编码前数据的4/3，会大1/3左右。
 */
// base64 编码
/// 编码
- (instancetype)EJ_base64Encode;
/// 解码
- (instancetype)EJ_base64Decode;

/*
 ①加密后密文的长度是定长的
 ②如果明文不一样，那么散列后的结果一定不一样
 ③如果明文一样，那么加密后的密文一定一样（对相同数据加密，加密后的密文一样）
 ④所有的加密算法是公开的
 ⑤不可以逆推反算(最重要的特点)
 ⑥速度非常快
 ⑦可以使用文件管理--辨别是否一致
 */
// 哈希 散列函数
/// 32小写
- (instancetype)EJ_MD5_32BitLower;
/// 32大写
- (instancetype)EJ_MD5_32BitUpper;
/// 16小写
- (instancetype)EJ_MD5_16BitLower;
/// 16大写
- (instancetype)EJ_MD5_16BitUpper;

- (instancetype)EJ_SHA1;
- (instancetype)EJ_SHA256;
- (instancetype)EJ_SHA512;

/*
 1) 原理
 ①消息的发送者和接收者有一个共享密钥
 ②发送者使用共享密钥对消息加密计算得到MAC值（消息认证码）
 ③消息接收者使用共享密钥对消息加密计算得到MAC值
 ④比较两个MAC值是否一致
 2）使用
 ①客户端需要在发送的时候把（消息）+（消息·HMAC）一起发送给服务器
 ②服务器接收到数据后，对拿到的消息用共享的KEY进行HMAC，比较是否一致，如果一致则信任
 */
/// 消息认证机制（HMAC）
- (instancetype)EJ_MD5_HMACWithKey:(NSString *)key;
/// 消息认证机制（HMAC）
- (instancetype)EJ_SHA1_HMACWithKey:(NSString *)key;

/// 文件加密
- (instancetype)EJ_MD5_filePatch;
/// 文件加密
- (instancetype)EJ_SHA1_filePatch;

/*
 对称加密算法：指加密和解密使用相同密钥的加密算法（包括DES算法，3DES算法，RC5算法，AES算法等）。AES和DES都包含两种加密算法的加密方式分别为ECB和CBC。
 
 AES：高级加密标准，是美国联邦政府采用的一种区块加密标准。
 DES：数据加密标准，(现在用的比较少，因为它的加密强度不够，能够暴力破解)。
 ECB：电子密码本，就是每个块都是独立加密的。
 CBC：密码块链，使用一个密钥和一个初始化向量(IV)对数据执行加密转换。
 使用ECB iv向量 传nil
 */
// 对称加密（AES|DES）
/// AES 加密 key 向量
- (instancetype)EJ_AESEncryptWithKey:(NSString *)key iv:(NSData *)iv;
/// AES 加密 key 向量
- (instancetype)EJ_AESDecryptWithKey:(NSString *)key iv:(NSData *)iv;
/// DES 解密 key 向量
- (instancetype)EJ_DESEncryptWithKey:(NSString *)key iv:(NSData *)iv;
/// DES 解密 key 向量
- (instancetype)EJ_DESDecryptWithKey:(NSString *)key iv:(NSData *)iv;

/*
 访问 HTTP 资源时需要对 URL 进行 Encode，
 比如像拼出来的 http://unmi.cc?p1=%+&sd f&p2=中文，
 其中的中文、特殊符号&％和空格都必须进行转译才能正确访问。
 以“?!@#$^&%*+,:;='\”`<>()[]{}/\| "字符串
 */
// URL 编码
/// URL encode
- (instancetype)EJ_URLEncode;
/// URL decode
- (instancetype)EJ_URLDecode;

@end


NS_ASSUME_NONNULL_END
