//
//  MD5.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

+ (NSString *)EJ_MD5String:(NSString *)str;
+ (NSString *)EJ_MD5File:(NSString *)filePath;

@end
