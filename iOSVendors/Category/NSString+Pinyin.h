//
//  NSString+Pinyin.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Pinyin)

/// 汉字转拼音
- (instancetype)pinyin;

/// 首字母大写（如果为数字或者特殊字符转为 #）
- (instancetype)capitalize_A;

@end

NS_ASSUME_NONNULL_END
