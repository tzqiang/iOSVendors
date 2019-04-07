//
//  NSDate+Formatter.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Formatter)

- (NSString *)EJ_formatter;
- (NSString *)EJ_yyyyMMdd_HHmmss;
- (NSString *)EJ_yyyy_MM_dd_HH_mm_ss;

- (NSString *)EJ_MM_dd_HH_mm;
- (NSString *)EJ_yyyy_MM_dd_HH_mm;

- (BOOL)EJ_isThisYear;

+ (instancetype)EJ_timestampData:(NSTimeInterval)timestamp;

@end

NS_ASSUME_NONNULL_END
