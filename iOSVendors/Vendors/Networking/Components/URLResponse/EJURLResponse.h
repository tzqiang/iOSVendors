//
//  EJURLResponse.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, EJURLResponseStatus) {
    EJURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层来决定。
    EJURLResponseStatusErrorTimeout,
    EJURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

@interface EJURLResponse : NSObject

@property (nonatomic, assign, readonly) EJURLResponseStatus status;
@property (nonatomic, assign, readonly) NSInteger requestID;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSDictionary *responseObject;
@property (nonatomic, copy) NSDictionary *requestParams;

@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithRequestID:(NSNumber *)requestID request:(NSURLRequest *)request responseObject:(NSDictionary *)responseObject status:(EJURLResponseStatus)status;
- (instancetype)initWithRequestID:(NSNumber *)requestId request:(NSURLRequest *)request responseObject:(NSDictionary *)responseObject error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithResponseObject:(NSDictionary *)ResponseObject;

@end
