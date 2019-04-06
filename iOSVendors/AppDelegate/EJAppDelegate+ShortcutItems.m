//
//  EJAppDelegate+ShortcutItems.m
//  iOSVendors
//
//  Created by Awro on 2019/4/6.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "EJAppDelegate+ShortcutItems.h"

@implementation EJAppDelegate (ShortcutItems)

- (void)set3DTouchShortcutItems {
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"scan" localizedTitle:@"扫一扫" localizedSubtitle:@"扫描二维码" icon:icon1 userInfo:nil];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"add" localizedTitle:@"加一加" localizedSubtitle:@"添加好友位" icon:icon2 userInfo:nil];
    
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"搜一搜" localizedSubtitle:@"搜索新内容" icon:icon3 userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[ item1, item2, item3 ];
}

- (void)performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    if ([shortcutItem.type isEqualToString:@"scan"]) {
        [WINDOW showHUDWithMessage:@"扫一扫"];
    } else if ([shortcutItem.type isEqualToString:@"add"]) {
        [WINDOW showHUDWithMessage:@"添加好友"];
    } else if ([shortcutItem.type isEqualToString:@"search"]) {
        [WINDOW showHUDWithMessage:@"搜索"];
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [self performActionForShortcutItem:shortcutItem];
}

@end
