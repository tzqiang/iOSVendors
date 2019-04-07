//
//  NSString+Security.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "NSString+Security.h"

#import <CommonCrypto/CommonCrypto.h>

#define FileHashDefaultChunkSizeForReadingData 4096

@implementation NSString (Security)

#pragma mark - base64

- (instancetype)EJ_base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (instancetype)EJ_base64Decode {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - MD5

- (instancetype)EJ_MD5_32BitLower {
    const char *input = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

- (instancetype)EJ_MD5_32BitUpper {
    const char *input = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

- (instancetype)EJ_MD5_16BitLower {
    NSString *MD5 = [self EJ_MD5_32BitLower];
    
    if (MD5.length < 24) {
        return nil;
    }
    return [MD5 substringWithRange:NSMakeRange(8, 16)];
}

- (instancetype)EJ_MD5_16BitUpper {
    NSString *MD5 = [self EJ_MD5_32BitUpper];
    
    if (MD5.length < 24) {
        return nil;
    }
    return [MD5 substringWithRange:NSMakeRange(8, 16)];
}

- (instancetype)EJ_SHA1 {
    const char *input = self.UTF8String;
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input, (CC_LONG)strlen(input), result);
    
    return [self stringFromBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (instancetype)EJ_SHA256 {
    const char *input = self.UTF8String;
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    return [self stringFromBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (instancetype)EJ_SHA512 {
    const char *input = self.UTF8String;
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    return [self stringFromBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

- (instancetype)EJ_MD5_HMACWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (instancetype)EJ_SHA1_HMACWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (instancetype)EJ_MD5_filePatch {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (!fp) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (instancetype)EJ_SHA1_filePatch {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (!fp) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *digest = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [digest appendFormat:@"%02x", bytes[i]];
    }
    
    return [digest copy];
}

- (instancetype)EJ_AESEncryptWithKey:(NSString *)key iv:(NSData *)iv {
    return [self encrypt:key iv:iv aes:YES];
}

- (instancetype)EJ_AESDecryptWithKey:(NSString *)key iv:(NSData *)iv {
    return [self decrypt:key iv:iv aes:YES];
}

- (instancetype)EJ_DESEncryptWithKey:(NSString *)key iv:(NSData *)iv {
    return [self encrypt:key iv:iv aes:NO];
}

- (instancetype)EJ_DESDecryptWithKey:(NSString *)key iv:(NSData *)iv {
    return [self decrypt:key iv:iv aes:NO];
}

- (instancetype)encrypt:(NSString *)key iv:(NSData *)iv aes:(BOOL)isAES {
    NSInteger kCCKeySize;
    NSInteger kCCBlockSize;
    uint32_t kCCAlgorithm;
    if (isAES) {
        kCCKeySize = kCCKeySizeAES128;
        kCCBlockSize = kCCBlockSizeAES128;
        kCCAlgorithm = kCCAlgorithmAES128;
    } else {
        kCCKeySize = kCCKeySizeDES;
        kCCBlockSize = kCCBlockSizeDES;
        kCCAlgorithm = kCCAlgorithmDES;
    }
    // 设置秘钥
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[kCCKeySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:kCCKeySize];
    
    // 设置iv
    uint8_t cIv[kCCBlockSize];
    bzero(cIv, kCCBlockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:kCCBlockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 设置输出缓冲区
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + kCCBlockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始加密
    size_t encryptedSize = 0;
    
    /*
     CCCrypt 对称加密算法的核心函数(加密/解密)
     第一个参数：kCCEncrypt 加密/ kCCDecrypt 解密
     第二个参数：加密算法，默认使用的是 AES/DES
     第三个参数：加密选项 ECB/CBC
     kCCOptionPKCS7Padding                      CBC 的加密
     kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密
     第四个参数：加密密钥
     第五个参数：密钥的长度
     第六个参数：初始向量
     第七个参数：加密的数据
     第八个参数：加密的数据长度
     第九个参数：密文的内存地址
     第十个参数：密文缓冲区的大小
     第十一个参数：加密结果的大小
     */
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm,
                                          option,
                                          cKey,
                                          kCCKeySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
    }
    
    return [result base64EncodedStringWithOptions:0];
}

- (instancetype)decrypt:(NSString *)key iv:(NSData *)iv aes:(BOOL)isAES {
    NSInteger kCCKeySize;
    NSInteger kCCBlockSize;
    uint32_t kCCAlgorithm;
    if (isAES) {
        kCCKeySize = kCCKeySizeAES128;
        kCCBlockSize = kCCBlockSizeAES128;
        kCCAlgorithm = kCCAlgorithmAES128;
    } else {
        kCCKeySize = kCCKeySizeDES;
        kCCBlockSize = kCCBlockSizeDES;
        kCCAlgorithm = kCCAlgorithmDES;
    }
    
    // 设置秘钥
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[kCCKeySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:kCCKeySize];
    
    // 设置iv
    uint8_t cIv[kCCBlockSize];
    bzero(cIv, kCCBlockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:kCCBlockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 设置输出缓冲区，options参数很多地方是直接写0，但是在实际过程中可能出现回车的字符串导致解不出来
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    size_t bufferSize = [data length] + kCCBlockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始解密
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithm,
                                          option,
                                          cKey,
                                          kCCKeySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
    }
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

#pragma mark - URL encode

- (instancetype)EJ_URLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (instancetype)EJ_URLDecode {
    return [self stringByRemovingPercentEncoding];
}

@end
