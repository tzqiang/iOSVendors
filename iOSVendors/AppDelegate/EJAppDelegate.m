//
//  EJAppDelegate.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJAppDelegate.h"

#import "EJLoadingViewController.h"

#import "EJAppDelegate+APNs.h"
#import "EJAppDelegate+ShortcutItems.h"
#import "EJAppDelegate+SDK.h"

@interface EJAppDelegate ()

@end

@implementation EJAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[EJLoadingViewController alloc] init];
    [_window makeKeyAndVisible];
    
    // 注册 APNs 推送服务
    [self registerPushService];
    
    // 设置 3DTouch按钮
    [self set3DTouchShortcutItems];
    
    // 注册 SDK
    [self setupSDK];
    
    return YES;
}

#pragma mark - ApplicationDelegate

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self setBadgeNumber];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
