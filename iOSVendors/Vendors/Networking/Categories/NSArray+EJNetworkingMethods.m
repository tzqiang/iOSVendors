//
//  NSArray+EJNetworkingMethods.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "NSArray+EJNetworkingMethods.h"

@implementation NSArray (EJNetworkingMethods)

- (NSString *)EJ_paramsString {
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        } else {
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

@end
