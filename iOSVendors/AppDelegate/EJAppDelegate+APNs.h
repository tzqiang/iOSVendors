//
//  EJAppDelegate+APNs.h
//  iOSVendors
//
//  Created by Awro on 2019/4/6.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "EJAppDelegate.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface EJAppDelegate (APNs)
<
UNUserNotificationCenterDelegate
>

/// 注册 APNs 推送服务
- (void)registerPushService;

/// 设置 BadgeNumber 消息个数
- (void)setBadgeNumber;

@end

NS_ASSUME_NONNULL_END
