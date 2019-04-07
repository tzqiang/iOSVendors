//
//  NSString+Timestamp.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "NSString+Timestamp.h"

#import "NSDate+Formatter.h"

@implementation NSString (Moment)

+ (instancetype)compareCurrentTime:(NSTimeInterval)timestamp {
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    
    if (timeInterval / 60 < 1) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    } else if((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else {
        temp = temp / 24;
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    return  result;
}

+ (instancetype)dayOfCurrentTime:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate EJ_timestampData:timestamp];
    NSString *time = [date EJ_formatter];
    
    NSString *day = [time componentsSeparatedByString:@"-"].lastObject;
    
    return day;
}

+ (instancetype)monthOfCurrentTime:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate EJ_timestampData:timestamp];
    NSString *time = [date EJ_formatter];
    
    NSString *month = [time componentsSeparatedByString:@"-"][1];
    if (month.length > 1) {
        if ([[month substringToIndex:1] isEqualToString:@"0"]) {
            month = [month substringFromIndex:1];
        }
    }
    
    return month;
}

+ (instancetype)yearOfCurrentTime:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate EJ_timestampData:timestamp];
    NSString *time = [date EJ_formatter];
    
    NSString *year = [time componentsSeparatedByString:@"-"].firstObject;
    
    return year;
}

- (BOOL)isToday {
    BOOL today = NO;
    NSTimeInterval timestamp = [self doubleValue];
    
    NSString *day = [NSString dayOfCurrentTime:timestamp];
    NSString *month = [NSString monthOfCurrentTime:timestamp];
    NSString *year= [NSString yearOfCurrentTime:timestamp];
    
    timestamp = [NSDate date].timeIntervalSince1970;
    NSString *day1 = [NSString dayOfCurrentTime:timestamp];
    NSString *month1 = [NSString monthOfCurrentTime:timestamp];
    NSString *year1= [NSString yearOfCurrentTime:timestamp];
    
    if ([year1 isEqualToString:year]) {
        if ([month1 isEqualToString:month]) {
            if ([day1 isEqualToString:day]) {
                today = YES;
            }
        }
    }
    
    return today;
}

@end
