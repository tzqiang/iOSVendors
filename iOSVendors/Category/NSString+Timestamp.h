//
//  NSString+Timestamp.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Timestamp)

/// 刚刚 1小时前
+ (instancetype)compareCurrentTime:(NSTimeInterval)timestamp;
/// 天
+ (instancetype)dayOfCurrentTime:(NSTimeInterval)timestamp;
/// 月
+ (instancetype)monthOfCurrentTime:(NSTimeInterval)timestamp;
/// 年
+ (instancetype)yearOfCurrentTime:(NSTimeInterval)timestamp;

/// 判断是否是今天
- (BOOL)isToday;

@end

NS_ASSUME_NONNULL_END
