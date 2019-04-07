//
//  NSDate+Formatter.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

- (NSString *)EJ_formatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:self];
    
    return date;
}

- (NSString *)EJ_yyyyMMdd_HHmmss {
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //    [formatter setDateFormat: @"yyyyMMdd_HHmmss"];
    //    NSString *date = [formatter stringFromDate:self];
    NSString *date = @"";
    /// 添加一个随机数 UUID
    int x = arc4random() % 100;
    date = [date stringByAppendingFormat:@"_%@_%@",@(x), [NSUUID UUID].UUIDString];
    
    return date;
}

- (NSString *)EJ_yyyy_MM_dd_HH_mm_ss {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:self];
    
    return date;
}

- (NSString *)EJ_MM_dd_HH_mm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat: @"MM-dd HH:mm"];
    NSString *date = [formatter stringFromDate:self];
    
    return date;
}

- (NSString *)EJ_yyyy_MM_dd_HH_mm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSString *date = [formatter stringFromDate:self];
    
    return date;
}

+ (instancetype)EJ_timestampData:(NSTimeInterval)timestamp {
    NSString *time = @(timestamp).stringValue;
    if (time.length < 10) {
        return nil;
    }
    timestamp = [[time substringToIndex:10] doubleValue];
    
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

- (BOOL)EJ_isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

@end
