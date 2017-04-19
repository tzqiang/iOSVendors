//
//  EJApiProxy.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJApiProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "EJURLResponse.h"

#import "RSA.h"
#import "MD5.h"
#import "NSDictionary+EJNetworkingMethods.h"

@interface EJApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation EJApiProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static EJApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EJApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    return [self callGETWithMethod:method params:params signature:NO success:success failure:failure];
}

- (NSInteger)callPOSTWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    return [self callPOSTWithMethod:method params:params signature:NO success:success failure:failure];
}

- (NSInteger)callPUTWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    return [self callPUTWithMethod:method params:params signature:NO success:success failure:failure];
}

- (NSInteger)callDELETEWithMethod:(NSString *)method params:(NSDictionary *)params success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    return [self callDELETEWithMethod:method params:params signature:NO success:success failure:failure];
}

- (NSInteger)callGETWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    NSString *urlStr = [self.baseUrl stringByAppendingPathComponent:method];
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:@"GET" URLString:urlStr parameters:params error:nil];
    
    if (signature) {
        [request setValue:[RSA EJ_RSAEncryptString:[MD5 EJ_MD5String:[params EJ_urlParamsStringSignature:YES]]] forHTTPHeaderField:@"xxxxxx"];
    }
    
    NSNumber *requestID = [self callApiWithRequest:request success:success failure:failure];
    return [requestID integerValue];
}

- (NSInteger)callPOSTWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    NSString *urlStr = [self.baseUrl stringByAppendingPathComponent:method];
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    
    if (signature) {
        [request setValue:[RSA EJ_RSAEncryptString:[MD5 EJ_MD5String:[params EJ_urlParamsStringSignature:YES]]] forHTTPHeaderField:@"xxxxxx"];
    }
    
    NSNumber *requestID = [self callApiWithRequest:request success:success failure:failure];
    return [requestID integerValue];
}

- (NSInteger)callPUTWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:@"PUT" URLString:method parameters:params error:nil];
    
    if (signature) {
        [request setValue:[RSA EJ_RSAEncryptString:[MD5 EJ_MD5String:[params EJ_urlParamsStringSignature:YES]]] forHTTPHeaderField:@"xxxxxx"];
    }
    
    NSNumber *requestID = [self callApiWithRequest:request success:success failure:failure];
    return [requestID integerValue];
}

- (NSInteger)callDELETEWithMethod:(NSString *)method params:(NSDictionary *)params signature:(BOOL)signature success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:@"DELETE" URLString:method parameters:params error:nil];
    
    if (signature) {
        [request setValue:[RSA EJ_RSAEncryptString:[MD5 EJ_MD5String:[params EJ_urlParamsStringSignature:YES]]] forHTTPHeaderField:@"xxxxxx"];
    }
    
    NSNumber *requestID = [self callApiWithRequest:request success:success failure:failure];
    return [requestID integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestID in requestIDList) {
        [self cancelRequestWithRequestID:requestID];
    }
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(ApiProxyCallback)success failure:(ApiProxyCallback)failure {
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        if (error && failure) {
            EJURLResponse *response = [[EJURLResponse alloc] initWithRequestID:requestID request:request responseObject:responseObject error:error];
            failure(response);
            return;
        }
        
        if (!error && success) {
            EJURLResponse *response = [[EJURLResponse alloc] initWithRequestID:requestID request:request responseObject:responseObject status:EJURLResponseStatusSuccess];
            success(response);
        }
    }];
    
    NSNumber *requestID = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestID] = dataTask;
    [dataTask resume];
    
    return requestID;
}

// 上传
- (NSInteger)uploadWithMethod:(NSString *)method
                       params:(NSDictionary *)params
                     fileData:(NSData *)fileData
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                     progress:(ApiProxyProgress)progress
                      success:(ApiProxyCallback)success
                      failure:(ApiProxyCallback)failure {
    NSString *urlStr = [self.baseUrl stringByAppendingString:method];
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:mimeType];
    } error:nil];
    __block NSURLSessionUploadTask *uploadTask = nil;
    uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([uploadTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        if (error && failure) {
            EJURLResponse *response = [[EJURLResponse alloc] initWithRequestID:requestID request:request responseObject:responseObject error:error];
            failure(response);
            return;
        }
        
        if (!error && success) {
            EJURLResponse *response = [[EJURLResponse alloc] initWithRequestID:requestID request:request responseObject:responseObject status:EJURLResponseStatusSuccess];
            success(response);
        }
    }];
    
    NSNumber *requestID = @([uploadTask taskIdentifier]);
    
    self.dispatchTable[requestID] = uploadTask;
    [uploadTask resume];
    
    return [requestID integerValue];
}

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable {
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 15.f;
        ((AFJSONResponseSerializer *)_sessionManager.responseSerializer).removesKeysWithNullValues = YES;
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

@end
