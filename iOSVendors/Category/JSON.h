//
//  JSON.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

- (id)EJ_JSONObject;

@end

@interface NSArray (JSON)

- (NSString *)EJ_JSONString;

@end

@interface NSDictionary (JSON)

- (NSString *)EJ_JSONString;

@end
