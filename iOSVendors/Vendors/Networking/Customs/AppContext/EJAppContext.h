//
//  EJAppContext.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJAppContext : NSObject

//凡是未声明成readonly的都是需要在初始化的时候由外面给的

// 运行环境相关
@property (nonatomic, assign, readonly) BOOL isReachable;

// 用户信息
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, readonly) BOOL isLoggedIn;

// app信息
@property (nonatomic, readonly) NSString *appVersion;

// 推送相关
@property (nonatomic, copy) NSString *deviceToken;

// 地理位置
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, assign, readonly) CGFloat longitude;

+ (instancetype)sharedInstance;

- (void)cleanUserInfo;

@end
