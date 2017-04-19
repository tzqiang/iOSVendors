//
//  EJCacheObject.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJCacheObject.h"

@interface EJCacheObject ()

@property (nonatomic, copy, readwrite) NSDictionary *content;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation EJCacheObject

#pragma mark - getters and setters
- (BOOL)isEmpty {
    return self.content == nil;
}

- (BOOL)isOutdated:(NSTimeInterval)maxInterval {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > maxInterval;
}

- (void)setContent:(NSDictionary *)content {
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSDictionary *)content {
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

#pragma mark - public method
- (void)updateContent:(NSDictionary *)content {
    self.content = content;
}

@end

