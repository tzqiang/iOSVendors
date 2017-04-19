//
//  EJURLResponse.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJURLResponse.h"
#import "NSURLRequest+EJNetworkingMethods.h"

@interface EJURLResponse ()

@property (nonatomic, assign, readwrite) EJURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestID;
@property (nonatomic, copy, readwrite) NSDictionary *responseObject;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end

@implementation EJURLResponse

#pragma mark - life cycle
- (instancetype)initWithRequestID:(NSNumber *)requestID request:(NSURLRequest *)request responseObject:(NSDictionary *)responseObject status:(EJURLResponseStatus)status {
    self = [super init];
    if (self) {
        self.status = status;
        self.requestID = [requestID integerValue];
        self.request = request;
        self.responseObject = responseObject;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithRequestID:(NSNumber *)requestID request:(NSURLRequest *)request responseObject:(NSDictionary *)responseObject error:(NSError *)error {
    self = [super init];
    if (self) {
        self.status = [self responseStatusWithError:error];
        self.requestID = [requestID integerValue];
        self.request = request;
        self.responseObject = responseObject;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
    self = [super init];
    if (self) {
        self.status = [self responseStatusWithError:nil];
        self.requestID = 0;
        self.request = nil;
        self.responseObject = responseObject;
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods
- (EJURLResponseStatus)responseStatusWithError:(NSError *)error {
    if (error) {
        EJURLResponseStatus result = EJURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = EJURLResponseStatusErrorTimeout;
        }
        return result;
    } else {
        return EJURLResponseStatusSuccess;
    }
}

@end
