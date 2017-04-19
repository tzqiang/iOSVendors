//
//  EJCache.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJCache.h"

#import "NSDictionary+EJNetworkingMethods.h"

@interface EJCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation EJCache
#pragma mark - getters and setters
- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = _cacheCountLimit;
    }
    return _cache;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static EJCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EJCache alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cacheOutdateInterval = 300;
        _cacheCountLimit = 1000;
    }
    return self;
}

#pragma mark - public method
- (NSDictionary *)fetchCachedObjectWithMethodName:(NSString *)methodName
                                    requestParams:(NSDictionary *)requestParams {
    return [self fetchCachedObjectWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (void)saveCacheWithObject:(NSDictionary *)cachedObject
                 methodName:(NSString *)methodName
              requestParams:(NSDictionary *)requestParams {
    [self saveCacheWithObject:cachedObject key:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (void)deleteCacheWithMethodName:(NSString *)methodName
                    requestParams:(NSDictionary *)requestParams {
    [self deleteCacheWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (NSDictionary *)fetchCachedObjectWithKey:(NSString *)key {
    EJCacheObject *cachedObject = [self.cache objectForKey:key];
    if ([cachedObject isOutdated:_cacheOutdateInterval] || cachedObject.isEmpty) {
        return nil;
    }
    else {
        return cachedObject.content;
    }
}

- (void)saveCacheWithObject:(NSDictionary *)cacheData key:(NSString *)key {
    EJCacheObject *cacheObject = [self.cache objectForKey:key];
    if (cacheObject == nil) {
        cacheObject = [[EJCacheObject alloc] init];
    }
    [cacheObject updateContent:cacheData];
    [self.cache setObject:cacheObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
}

- (void)clean {
    [self.cache removeAllObjects];
}

- (NSString *)keyWithMethodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    return [NSString stringWithFormat:@"%@%@", methodName, [requestParams EJ_urlParamsStringSignature:NO]];
}

#pragma mark - private method

@end
