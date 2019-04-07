//
//  NSTimer+Block.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Block)

/// 计时器 block 调用
+ (NSTimer *_Nullable)EJ_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^_Nullable)(NSTimer * _Nonnull))block;

@end

NS_ASSUME_NONNULL_END
