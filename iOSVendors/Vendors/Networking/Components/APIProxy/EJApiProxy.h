//
//  EJApiProxy.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EJURLResponse;
typedef void(^ApiProxyProgress)(double progress);
typedef void(^ApiProxyCallback)(EJURLResponse *response);
@interface EJApiProxy : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, copy) NSString *baseUrl;

- (NSInteger)callGETWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callPOSTWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callPUTWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callDELETEWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;

// 上传
- (NSInteger)uploadWithMethod:(NSString *)method params:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(ApiProxyProgress)progress success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;

- (NSInteger)callGETWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callPOSTWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callPUTWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (NSInteger)callDELETEWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;


- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end

