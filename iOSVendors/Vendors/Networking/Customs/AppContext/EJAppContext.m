//
//  EJAppContext.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/19.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJAppContext.h"

#import <AFNetworking/AFNetworkReachabilityManager.h>

@implementation EJAppContext

@synthesize userInfo = _userInfo;
@synthesize userID = _userID;

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static EJAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EJAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (void)cleanUserInfo {
    self.userID = nil;
    self.userInfo = nil;
}

#pragma mark - getters and setters
- (void)setUserID:(NSString *)userID {
    _userID = [userID copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID {
    if (_userID == nil) {
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    return _userID;
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    _userInfo = [userInfo copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)userInfo {
    if (_userInfo == nil) {
        _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    }
    return _userInfo;
}

- (BOOL)isReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)appVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (BOOL)iEJoggedIn {
    BOOL result = (self.userID.length != 0);
    return result;
}

- (NSString *)deviceToken {
    if (_deviceToken == nil) {
        _deviceToken = @"";
    }
    return _deviceToken;
}
@end

