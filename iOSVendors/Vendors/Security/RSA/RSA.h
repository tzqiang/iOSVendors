/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
 */

#import <Foundation/Foundation.h>

@interface RSA : NSObject

// return base64 encoded string
+ (NSString *)EJ_RSAEncryptString:(NSString *)str;
// return raw data
+ (NSData *)EJ_RSAEncryptData:(NSData *)data;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)EJ_RSADecryptString:(NSString *)str;
+ (NSData *)EJ_RSADecryptData:(NSData *)data;

// return base64 encoded string
+ (NSString *)EJ_RSAEncryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)EJ_RSAEncryptData:(NSData *)data publicKey:(NSString *)pubKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)EJ_RSADecryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)EJ_RSADecryptData:(NSData *)data publicKey:(NSString *)pubKey;

@end

