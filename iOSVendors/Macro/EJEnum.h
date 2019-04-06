//
//  EJEnum.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <CoreGraphics/CGBase.h>
#import <Foundation/Foundation.h>

#ifndef EJEnum_h
#define EJEnum_h

/// ENUM 枚举
typedef NS_ENUM(NSInteger, EJType) {
    /// 类型1
    EJType1,
    /// 类型2
    EJType2,
    /// 类型3
    EJType3
};

/// 字符串类型枚举
typedef NSString EJShareType;
/// 分享微信字符串
extern EJShareType * const EJShareTypeWechat;
/// 分享 QQ 字符串
extern EJShareType * const EJShareTypeQQ;
/// 分享微博字符串
extern EJShareType * const EJShareTypeWeibo;

#endif /* EJEnum_h */
