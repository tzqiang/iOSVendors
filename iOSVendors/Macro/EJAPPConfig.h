//
//  EJAPPConfig.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#ifndef EJAPPConfig_h
#define EJAPPConfig_h

#import <CoreGraphics/CGBase.h>
#import <Foundation/Foundation.h>

#pragma mark - color
//color 主色 辅色
#define color_000000_50 HEXA(0x000000, 0.5)
#define color_000000 HEX(0x000000)
#define color_03a64a HEX(0x03a64a)

#define color_333333_25 HEXA(0x333333, 0.25)
#define color_333333 HEX(0x333333) //用于重要级文字信息、内页标题信息（如导航名称、大板块标题、类目名称等）
#define color_3d96ce HEX(0x3d96ce)
#define color_444444 HEX(0x444444)
#define color_4f60ff HEX(0x4f60ff)
#define color_555555 HEX(0x555555) //
#define color_666666 HEX(0x666666) //用于普通段落信息 引导词（如一些主标题，商品名称）
#define color_999999 HEX(0x999999) //用于辅助、次要的文字信息、顶部和底部分割线、线性图标（如商品规格等）
#define color_c6c6c6 HEX(0xc6c6c6)
#define color_cccccc HEX(0xcccccc) //用于按钮禁用时颜色、表单内提示文字（如登录注册按钮框提示文字，购买按钮不能操作时等）
#define color_df4444 HEX(0xdf4444) //用于特别需要强调和突出的文字、按钮和icon（如购买提交按钮、于价格相关的文字信息等）
#define color_e8e8e8 HEX(0xe8e8e8) //分割线
#define color_eeeeee HEX(0xeeeeee)
#define color_f6f6f6 HEX(0xf6f6f6) //用于所有页面背景颜色
#define color_fcab43 HEX(0xfcab43)
#define color_ffffff_50 HEXA(0xffffff, 0.5)
#define color_ffffff HEX(0xffffff) //用于按钮字体颜色

//specific color 具体特定颜色
#define color_background color_f6f6f6 //用于所有页面背景颜色
#define color_line color_e8e8e8 //用于分割线
#define color_button color_df4444 //用于按钮正常背景颜色
#define color_button_disabled color_cccccc //用于按钮禁用背景颜色
//#define color_border_line color_e5d3c2 //用于边框颜色

#pragma mark - font
//font
#define font_22 FONT(22.f)
#define font_20 FONT(20.f)
#define font_19 FONT(19.f)
#define font_18 FONT(18.f)
#define font_17 FONT(17.f) //用于少数重要标题（如导航标题）
#define font_16 FONT(16.f) //用于输入框、表单文字（如登录框内文字、个人中心文字）
#define font_15 FONT(15.f)
#define font_14 FONT(14.f) //用于大多数文字（如标题、部分段落文字）
#define font_13 FONT(13.f)
#define font_12 FONT(12.f) //用于大多文字（特别适用于大段落文字、如商品详情、名称、规格）
#define font_11 FONT(11.f)
#define font_10 FONT(10.f)
#define font_9  FONT(9.f)
#define font_8  FONT(8.f)

#pragma mark - constant

typedef NSString EJStringType;
/// "0"
extern EJStringType * const EJStringType0;
/// "1"
extern EJStringType * const EJStringType1;

/// 回退到 root
extern NSString * const EJRouterURLPop;
/// 跳转到登录界面
extern NSString * const EJRouterURLLogin;
/// 跳转到首页
extern NSString * const EJRouterURLHome;

#pragma mark - system

extern CGFloat const kStatusBarHight;
extern CGFloat const kNavigationBarHight;
extern CGFloat const kTabBarHeight;
extern CGFloat const kTableViewCellHeight;

#pragma mark - custom

#pragma mark - key
//(network)
extern NSString * const kPageCountKey;
extern NSString * const kPageIndexKey;
extern NSString * const kPageDataKey;
extern NSString * const kReturnIDKey;
extern NSString * const kReturnMessKey;
extern NSString * const kReturnDataKey;

//(info)
extern NSString * const kMembersID;

#pragma mark - value

extern NSString * const kNilValue;
extern NSTimeInterval const kAgainGetVerCodeTime;

#pragma mark - Notification

/// 退出登录通知
extern NSString * const EJLogoutNotification;

#endif /* EJAPPConfig_h */
