//
//  NSString+RegEx.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegEx)

- (BOOL)EJ_isPhone; //手机号
- (BOOL)EJ_isEmial; //邮箱
- (BOOL)EJ_isIDCard18; //身份证号

- (BOOL)EJ_isAlnum; //字母和数字
- (BOOL)EJ_isAlpha; //字母
- (BOOL)EJ_isDigit; //数字
- (BOOL)EJ_isDecimal; //小数点

- (BOOL)EJ_isBankNumbers; //银行卡号
- (BOOL)EJ_isChinese; //汉字

@end
