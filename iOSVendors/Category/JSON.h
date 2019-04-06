//
//  JSON.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

/// string 转 array || dictonary
- (id)EJ_JSONObject;

@end

@interface NSArray (JSON)

/// array 转 string
- (NSString *)EJ_JSONString;

@end

@interface NSDictionary (JSON)

/// dictonary 转 string
- (NSString *)EJ_JSONString;

@end
