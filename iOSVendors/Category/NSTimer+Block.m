//
//  NSTimer+Block.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (NSTimer *_Nullable)EJ_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer * _Nonnull))block {
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(EJ_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)EJ_blockInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
