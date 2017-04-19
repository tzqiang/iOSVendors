//
//  EJBaseApiManager.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJBaseApiManager.h"
#import "EJBaseApiManager.h"
#import "EJApiProxy.h"
#import "EJURLResponse.h"
#import "EJCache.h"
#import "EJAppContext.h"

NSString * const kEJAPIBaseManagerRequestID = @"kEJAPIBaseManagerRequestID";

#define EJCallAPI(REQUEST_METHOD, REQUEST_ID, SIGNATURE)                                            \
{                                                                                                   \
__weak typeof(self) weakSelf = self;                                                            \
REQUEST_ID = [[EJApiProxy sharedInstance] call##REQUEST_METHOD##WithMethod:self.child.methodName params:apiParams signature:SIGNATURE success:^(EJURLResponse *response) { \
__strong typeof(weakSelf) strongSelf = weakSelf;                                            \
if ([response.responseObject[@"Return_ID"] isEqualToNumber:@0]) {                         \
[strongSelf successedOnCallingAPI:response];                                            \
}                                                                                           \
else {                                                                                      \
[strongSelf failedOnCallingAPI:response withErrorType:EJAPIManagerErrorTypeNoContent];  \
}                                                                                           \
} failure:^(EJURLResponse *response) {                                                          \
__strong typeof(weakSelf) strongSelf = weakSelf;                                            \
[strongSelf failedOnCallingAPI:response withErrorType:EJAPIManagerErrorTypeDefault];        \
}];                                                                                             \
[self.requestIDList addObject:@(REQUEST_ID)];                                                   \
}

@interface EJBaseApiManager ()

@property (nonatomic, assign, readwrite) BOOL iEJoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) EJAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIDList;
@property (nonatomic, strong) EJCache *cache;

@end

@implementation EJBaseApiManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _paramSource = nil;
        
        _errorMessage = nil;
        _errorType = EJAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(EJAPIManager)]) {
            self.child = (id <EJAPIManager>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIDList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests {
    [[EJApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIDList];
    [self.requestIDList removeAllObjects];
}

- (void)cancelRequestWithRequestID:(NSInteger)requestID {
    [self removeRequestIDWithRequestID:requestID];
    [[EJApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

#pragma mark - calling api
- (NSInteger)loadData {
    _errorMessage = nil;
    _errorType = EJAPIManagerErrorTypeDefault;
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
    NSDictionary *apiParams = [self reformParams:params];
    
    if (![self shouldCallAPIWithParams:apiParams]) {
        return 0;
    }
    
    if ([self.child shouldLoadFromNative]) {
        [self loadDataFromNative];
    }
    
    // 先检查一下是否有缓存
    if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
        return 0;
    }
    
    // 实际的网络请求
    if ([self isReachable]) {
        self.iEJoading = YES;
        BOOL signature = [self.child respondsToSelector:@selector(signature)] ? [self.child signature] : NO;
        switch (self.child.requestType) {
            case EJAPIManagerRequestTypeGet:
                EJCallAPI(GET, requestID, signature);
                break;
            case EJAPIManagerRequestTypePost:
                EJCallAPI(POST, requestID, signature);
                break;
            case EJAPIManagerRequestTypePut:
                EJCallAPI(PUT, requestID, signature);
                break;
            case EJAPIManagerRequestTypeDelete:
                EJCallAPI(DELETE, requestID, signature);
                break;
            default:
                break;
        }
        
        NSMutableDictionary *params = [apiParams mutableCopy];
        params[kEJAPIBaseManagerRequestID] = @(requestID);
        [self afterCallingAPIWithParams:apiParams];
        return requestID;
    }
    else {
        [self failedOnCallingAPI:nil withErrorType:EJAPIManagerErrorTypeNoNetWork];
        return requestID;
    }
}

- (NSInteger)uploadData {
    _errorMessage = nil;
    _errorType = EJAPIManagerErrorTypeDefault;
    NSDictionary *params = [self.paramSource paramsForApi:self];
    if (![self.paramSource respondsToSelector:@selector(uploadDataForApi:)]) {
        NSException *exception = [[NSException alloc] init];
        @throw exception;
    }
    NSDictionary *uploadParams = [self.paramSource uploadDataForApi:self];
    NSData *fileData = uploadParams[@"FileData"];
    NSString *fileName = uploadParams[@"FileName"];
    NSString *mimeType = uploadParams[@"MimeType"];
    NSInteger requestId = [self uploadDataWithParams:params fileData:fileData fileName:fileName mimeType:mimeType];
    return requestId;
}

- (NSInteger)uploadDataWithParams:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
    NSInteger requestID = 0;
    NSDictionary *apiParams = [self reformParams:params];
    
    if (![self shouldCallAPIWithParams:apiParams]) {
        return 0;
    }
    
    if ([self isReachable]) {
        self.iEJoading = YES;
        
        __weak typeof(self) weakSelf = self;
        requestID = [[EJApiProxy sharedInstance] uploadWithMethod:self.child.methodName params:apiParams fileData:fileData fileName:fileName mimeType:mimeType progress:^(double progress) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf progressForCallingAPI:progress];
        } success:^(EJURLResponse *response) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([response.responseObject[@"Return_ID"] isEqualToNumber:@0]) {
                [strongSelf successedOnCallingAPI:response];
            }
            else {
                [strongSelf failedOnCallingAPI:response withErrorType:EJAPIManagerErrorTypeNoContent];
            }
        } failure:^(EJURLResponse *response) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf failedOnCallingAPI:response withErrorType:EJAPIManagerErrorTypeDefault];
        }];
        
        [self.requestIDList addObject:@(requestID)];
        NSMutableDictionary *params = [apiParams mutableCopy];
        params[kEJAPIBaseManagerRequestID] = @(requestID);
        [self afterCallingAPIWithParams:apiParams];
        return requestID;
    }
    else {
        [self failedOnCallingAPI:nil withErrorType:EJAPIManagerErrorTypeNoNetWork];
        return requestID;
    }
}

#pragma mark - api callbacks
- (void)successedOnCallingAPI:(EJURLResponse *)response {
    self.iEJoading = NO;
    self.response = response;
    
    if ([self.child shouldLoadFromNative]) {
        if (response.isCache == NO) {
            [[NSUserDefaults standardUserDefaults] setObject:response.responseObject forKey:[self.child methodName]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    [self removeRequestIDWithRequestID:response.requestID];
    
    if ([self shouldCache] && !response.isCache) {
        [self.cache saveCacheWithObject:response.responseObject methodName:self.child.methodName requestParams:response.requestParams];
    }
    
    if ([self.child shouldLoadFromNative]) {
        if (response.isCache == YES) {
            [self.delegate managerCallAPIDidSuccess:self];
        }
        if (self.isNativeDataEmpty) {
            [self.delegate managerCallAPIDidSuccess:self];
        }
    } else {
        [self.delegate managerCallAPIDidSuccess:self];
    }
}

- (void)failedOnCallingAPI:(EJURLResponse *)response withErrorType:(EJAPIManagerErrorType)errorType {
    self.iEJoading = NO;
    self.response = response;
    self.errorType = errorType;
    switch (errorType) {
        case EJAPIManagerErrorTypeDefault:
        case EJAPIManagerErrorTypeTimeout:
        case EJAPIManagerErrorTypeNoNetWork:
            self.errorMessage = @"网络错误";
            break;
            
        default:
            self.errorMessage = response.responseObject[@"Return_Mess"];
            break;
    }
    [self removeRequestIDWithRequestID:response.requestID];
    [self.delegate managerCallAPIDidFailed:self];
}

- (void)progressForCallingAPI:(double)progress {
    if (_delegate && [_delegate respondsToSelector:@selector(manager:callAPIProgress:)]) {
        [_delegate manager:self callAPIProgress:progress];
    }
}

//只有返回YES才会继续调用API
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData {
    [self.cache clean];
    self.errorMessage = nil;
    self.errorType = EJAPIManagerErrorTypeDefault;
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params {
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

- (BOOL)shouldCache {
    return NO;
}

#pragma mark - private methods
- (void)removeRequestIDWithRequestID:(NSInteger)requestID {
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestID in self.requestIDList) {
        if ([storedRequestID integerValue] == requestID) {
            requestIDToRemove = storedRequestID;
        }
    }
    
    if (requestIDToRemove) {
        [self.requestIDList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    NSString *methodName = self.child.methodName;
    NSDictionary *result = [self.cache fetchCachedObjectWithMethodName:methodName requestParams:params];
    
    if (result == nil) {
        return NO;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        EJURLResponse *response = [[EJURLResponse alloc] initWithResponseObject:result];
        response.requestParams = params;
        [strongSelf successedOnCallingAPI:response];
    });
    return YES;
}

- (void)loadDataFromNative
{
    NSString *methodName = self.child.methodName;
    NSDictionary *result = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:methodName];
    
    if (result) {
        self.isNativeDataEmpty = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            EJURLResponse *response = [[EJURLResponse alloc] initWithResponseObject:result];
            [strongSelf successedOnCallingAPI:response];
        });
    } else {
        self.isNativeDataEmpty = YES;
    }
}

#pragma mark - getters and setters
- (EJCache *)cache {
    if (_cache == nil) {
        _cache = [EJCache sharedInstance];
    }
    return _cache;
}

- (NSMutableArray *)requestIDList {
    if (_requestIDList == nil) {
        _requestIDList = [[NSMutableArray alloc] init];
    }
    return _requestIDList;
}

- (BOOL)isReachable {
    BOOL isReachability = [EJAppContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = EJAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)iEJoading
{
    if (self.requestIDList.count == 0) {
        _iEJoading = NO;
    }
    return _iEJoading;
}

- (BOOL)shouldLoadFromNative {
    return NO;
}

@end


