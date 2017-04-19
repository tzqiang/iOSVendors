//
//  NSURLRequest+EJNetworkingMethods.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "NSURLRequest+EJNetworkingMethods.h"
#import <objc/runtime.h>

static void *SLNetworkingRequestParams;

@implementation NSURLRequest (EJNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, &SLNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &SLNetworkingRequestParams);
}

@end
