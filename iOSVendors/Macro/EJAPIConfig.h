//
//  EJAPIConfig.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#ifndef EJAPIConfig_h
#define EJAPIConfig_h

#import <Foundation/Foundation.h>

#pragma mark - 接口基础信息

// 接口基础
/// 统一前缀
extern NSString * const api_base;
/// 图片地址拼接
extern NSString * const api_picture;

/// 数据
extern NSString * const kData;
/// 消息
extern NSString * const kMsg;
/// 请求反馈编码
extern NSString * const kCode;
/// 请求状态码
extern NSString * const kState;
/// token
extern NSString * const kToken;

/// 分页大小
extern NSInteger const kPageSize;

#pragma mark - 登录注册模块
/// 登录
extern NSString * const api_login;
/// 注册
extern NSString * const api_im_imRegister;

#endif /* EJAPIConfig_h */
