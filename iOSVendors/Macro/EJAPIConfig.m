//
//  EJAPIConfig.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJAPIConfig.h"

#pragma mark - 接口基础信息

NSString * const kData = @"data";
NSString * const kMsg = @"msg";
NSString * const kCode = @"code";
NSString * const kState = @"state";
NSString * const kToken = @"token";

NSInteger const kPageSize = 10;

/// 本地
//NSString * const api_base = @"http://192.168.1.193:8086";
/// 服务器
NSString * const api_base = @"http://travel.cqtsp.cn";

#pragma mark - 登录注册模块
/// 登录
NSString * const api_login = @"login";
/// 注册
NSString * const api_im_imRegister = @"register";
