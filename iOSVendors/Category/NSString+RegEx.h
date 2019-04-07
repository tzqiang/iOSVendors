//
//  NSString+RegEx.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegEx)

/// 手机号
- (BOOL)EJ_isPhone;

/// 邮箱
- (BOOL)EJ_isEmial;

/// 身份证号
- (BOOL)EJ_isIDCard18;

/// 字母和数字
- (BOOL)EJ_isAlnum;

/// 同时包含数字和字母
- (BOOL)EJ_isAlnumMust;

/// 字母
- (BOOL)EJ_isAlpha;

/// 数字
- (BOOL)EJ_isDigit;

/// 小数点
- (BOOL)EJ_isDecimal;

/// 是否位2位金额
- (BOOL)EJ_isMoney;

/// 银行卡号
- (BOOL)EJ_isBankNumbers;

/// 汉字
- (BOOL)EJ_isChinese;

/// 包含 emoji 表情
- (BOOL)EJ_containsEmoji;

/// 2 位小数金额输入 (- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string)
- (BOOL)EJ_isMoneyInput:(UITextField *)textField;

@end
