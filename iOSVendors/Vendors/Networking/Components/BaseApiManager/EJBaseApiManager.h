//
//  EJBaseApiManager.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

OBJC_EXTERN NSString * const kEJAPIBaseManagerRequestID;

@class EJBaseApiManager, EJURLResponse;

@protocol EJAPIManagerCallBackDelegate <NSObject>

@required
- (void)managerCallAPIDidSuccess:(EJBaseApiManager *)manager;
- (void)managerCallAPIDidFailed:(EJBaseApiManager *)manager;
@optional
- (void)manager:(EJBaseApiManager *)manager callAPIProgress:(double)progress;

@end

@protocol EJAPIManagerParamSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(EJBaseApiManager *)manager;
@optional
- (NSDictionary *)uploadDataForApi:(EJBaseApiManager *)manager; //上传文件时使用 必须传入FileName, FileData, MimeType
@end

typedef NS_ENUM (NSUInteger, EJAPIManagerErrorType){
    EJAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    EJAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    EJAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    EJAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    EJAPIManagerErrorTypeTimeout,       //请求超时。CTAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看CTAPIProxy的相关代码。
    EJAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, EJAPIManagerRequestType){
    EJAPIManagerRequestTypeGet,
    EJAPIManagerRequestTypePost,
    EJAPIManagerRequestTypePut,
    EJAPIManagerRequestTypeDelete
};

@protocol EJAPIManager <NSObject>

@required
- (NSString *)methodName;
- (EJAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

@optional
- (BOOL)signature;
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;

@end

/*
 EJAPIBaseManager的派生类必须符合这些protocal
 */
@protocol EJAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(EJBaseApiManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(EJBaseApiManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end

@interface EJBaseApiManager : NSObject

@property (nonatomic, weak) id<EJAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<EJAPIManagerParamSource> paramSource;
@property (nonatomic, weak) NSObject<EJAPIManager> *child;
@property (nonatomic, weak) id<EJAPIManagerInterceptor> interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) EJAPIManagerErrorType errorType;
@property (nonatomic, strong) EJURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL iEJoading;

- (NSInteger)loadData;
- (NSInteger)uploadData;//上传专用

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestID:(NSInteger)requestID;

// 拦截器方法，继承之后需要调用一下super
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingAPI:(EJURLResponse *)response;
- (void)failedOnCallingAPI:(EJURLResponse *)response withErrorType:(EJAPIManagerErrorType)errorType;

@end

