//
//  NSDictionary+EJNetworkingMethods.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "NSDictionary+EJNetworkingMethods.h"
#import "NSArray+EJNetworkingMethods.h"

@implementation NSDictionary (EJNetworkingMethods)

- (NSString *)EJ_urlParamsStringSignature:(BOOL)isForSignature {
    NSArray *sortedArray = [self EJ_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray EJ_paramsString];
}

/** 转义参数 */
- (NSArray *)EJ_transformedUrlParamsArraySignature:(BOOL)isForSignature {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj, NULL, (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

@end
