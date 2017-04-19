//
//  EJCache.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJCacheObject.h"

@interface EJCache : NSObject

@property (nonatomic, assign) NSTimeInterval cacheOutdateInterval;//default is 300
@property (nonatomic, assign) NSUInteger cacheCountLimit;//default is 1000

+ (instancetype)sharedInstance;

- (NSString *)keyWithMethodName:(NSString *)methodName
                  requestParams:(NSDictionary *)requestParams;



- (NSDictionary *)fetchCachedObjectWithMethodName:(NSString *)methodName
                                    requestParams:(NSDictionary *)requestParams;

- (void)saveCacheWithObject:(NSDictionary *)cachedObject
                 methodName:(NSString *)methodName
              requestParams:(NSDictionary *)requestParams;

- (void)deleteCacheWithMethodName:(NSString *)methodName
                    requestParams:(NSDictionary *)requestParams;



- (NSDictionary *)fetchCachedObjectWithKey:(NSString *)key;
- (void)saveCacheWithObject:(NSDictionary *)cacheObject key:(NSString *)key;
- (void)deleteCacheWithKey:(NSString *)key;
- (void)clean;

@end
