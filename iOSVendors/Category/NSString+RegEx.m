//
//  NSString+RegEx.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "NSString+RegEx.h"

@implementation NSString (RegEx)

- (BOOL)EJ_isPhone {
    //手机号开头：13 14 15 17 18 @"^1+[34578]+\\d{9}"
    //手机号开头：1 + 10位 @"^1+\\d{10}"
    NSString *regex = @"1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isEmial {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isIDCard18 {
    if (self.length != 18) {
        return NO;
    }
    
    int weight[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
    char validate[] = {'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    int sum = 0;
    for (int i = 0; i < 17; ++i) {
        sum += [[self substringWithRange:NSMakeRange(i, 1)] intValue] * weight[i];
    }
    
    return validate[sum%11] == [self characterAtIndex:17];
}

- (BOOL)EJ_isAlnum {
    NSString *regx = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isAlnumMust {
    NSString *regx = @"^[a-zA-Z].*[0-9]|.*[0-9].*[a-zA-Z]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isAlpha {
    NSString *regx = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isDigit {
    NSString *regx = @"^[0-9]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isDecimal {
    NSString *regx = @"^[0-9]+(\\.[0-9]{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isMoney {
    NSString *regx = @"^[0-9]+(\\.[0-9]{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [pred evaluateWithObject:self];
    
}

- (BOOL)EJ_isBankNumbers {
    //简单的12~19数字
    NSString *regx = @"^[0-9]{12,19}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isChinese {
    NSString *regex = @"(^[\u4e00-\u9fa5]{2,16}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}


- (BOOL)EJ_containsEmoji {
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if (self.length > 0) {
                                  const unichar hs = [substring characterAtIndex:0];
                                  if (0x2194 <= hs && hs <= 0x2199) { returnValue = YES; }
                                  if (0x23e9 <= hs && hs <= 0x23fa) { returnValue = YES; }
                                  if (0x2600 <= hs && hs <= 0x2604) { returnValue = YES; }
                                  if (0x2648 <= hs && hs <= 0x2653) { returnValue = YES; }
                                  if (0x30 <= hs && hs <= 0x39)     { returnValue = YES; }
                                  if (0x26f0 <= hs && hs <= 0x26fd) { returnValue = YES; }
                                  if ( hs == 0x203c || hs == 0x2049 || hs == 0x2122 || hs == 0x2139 || hs == 0x21a9 || hs == 0x21aa || hs == 0x23 || hs == 0x231a || hs == 0x231b || hs == 0x2328 || hs == 0x23cf || hs == 0x24c2 || hs == 0x25b6 || hs == 0x25c0 || hs == 0x260e || hs == 0x2611 || hs == 0x2614 || hs == 0x2615 || hs == 0x2618 || hs == 0x261d || hs == 0x2620 || hs == 0x2622 || hs == 0x2623 || hs == 0x2626 || hs == 0x262a || hs == 0x262e || hs == 0x262f || hs == 0x2638 || hs == 0x2639 || hs == 0x263a || hs == 0x2668 || hs == 0x267b || hs == 0x267f || hs == 0x2692 || hs == 0x2693 || hs == 0x2694 || hs == 0x2696 || hs == 0x2697 || hs == 0x2699 || hs == 0x269b || hs == 0x269c || hs == 0x26a0 || hs == 0x26a1 || hs == 0x26b0 || hs == 0x26b1 || hs == 0x26bd || hs == 0x26be || hs == 0x26c4 || hs == 0x26c5 || hs == 0x26c8 || hs == 0x26ce || hs == 0x26cf || hs == 0x26d1 || hs == 0x26d3 || hs == 0x26d4 || hs == 0x26e9 || hs == 0x26ea || hs == 0x2702 || hs == 0x2705 || hs == 0x2708 || hs == 0x2709 || hs == 0x270a || hs == 0x270b || hs == 0x270c || hs == 0x270d || hs == 0x270f || hs == 0x2712 || hs == 0x2714 || hs == 0x2716 || hs == 0x271d || hs == 0x2721 || hs == 0x2728 || hs == 0x2733 || hs == 0x2734 || hs == 0x2744 || hs == 0x2747 || hs == 0x274c || hs == 0x274e || hs == 0x2753 || hs == 0x2754 || hs == 0x2755 || hs == 0x2757 || hs == 0x2763 || hs == 0x2764 || hs == 0x2795 || hs == 0x2796 || hs == 0x2797 || hs == 0x27a1 || hs == 0x27b0 || hs == 0x27bf || hs == 0x2934 || hs == 0x2935 || hs == 0x2b05 || hs == 0x2b06 || hs == 0x2b07 || hs == 0x2b50 || hs == 0x2b55 || hs == 0x3030 || hs == 0x303d || hs == 0x3297 || hs == 0x3299 || hs == 0x2a || hs == 0xa9 || hs == 0xae || hs == 0xd83c || hs == 0xd83d) { returnValue = YES; }
                              }
                          }];
    return returnValue;
}

- (BOOL)EJ_isMoneyInput:(UITextField *)textField {
    /// 金额输入
    // .
    if (textField.text.length == 0 && [self isEqualToString:@"."]) {
        return NO;
    }
    
    // 0
    if (textField.text.length == 0 && [self isEqualToString:@"0"]) {
        return YES;
    }
    
    // 0.
    if (textField.text.length == 1 && [textField.text isEqualToString:@"0"]) {
        if ([self isEqualToString:@"."] || [self isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    
    // 判断当前是否为金额
    return [[textField.text stringByAppendingString:self] EJ_isMoney];
}

@end
