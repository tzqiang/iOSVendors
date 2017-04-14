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

- (BOOL)EJ_isBankNumbers {
    //简单的10~20数字
    NSString *regx = @"^[0-9]{10,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)EJ_isChinese {
    NSString *regex = @"(^[\u4e00-\u9fa5]{2,16}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

@end
