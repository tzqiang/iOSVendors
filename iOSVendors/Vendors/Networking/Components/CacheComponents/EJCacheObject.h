//
//  EJCacheObject.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJCacheObject : NSObject

@property (nonatomic, copy, readonly) NSDictionary *content;
@property (nonatomic, copy, readonly) NSDate *lastUpdateTime;

@property (nonatomic, assign, readonly) BOOL isEmpty;
- (BOOL)isOutdated:(NSTimeInterval)maxInterval;

- (instancetype)initWithContent:(NSDictionary *)content;
- (void)updateContent:(NSDictionary *)content;

@end
