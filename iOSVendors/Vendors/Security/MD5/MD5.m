//
//  MD5.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5

+ (NSString *)EJ_MD5String:(NSString *)str {
    if (!str) {
        return @"";
    }
    const char *cStr = [str UTF8String];
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    CC_MD5_Update(&md5, cStr, (unsigned int)strlen(cStr));
    return [self _MD5:md5];
}

+ (NSString *)EJ_MD5File:(NSString *)filePath {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(!handle) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while (!done) {
        NSData *fileData = [handle readDataOfLength:256];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if([fileData length] == 0)
            done = YES;
    }
    return [self _MD5:md5];
}

+ (NSString *)_MD5:(CC_MD5_CTX)md5 {
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *result = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        digest[0], digest[1],
                        digest[2], digest[3],
                        digest[4], digest[5],
                        digest[6], digest[7],
                        digest[8], digest[9],
                        digest[10], digest[11],
                        digest[12], digest[13],
                        digest[14], digest[15]];
    return result;
}

@end
