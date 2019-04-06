//
//  EJAppDelegate+SDK.m
//  iOSVendors
//
//  Created by Awro on 2019/4/6.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "EJAppDelegate+SDK.h"

#import "IQKeyboardManager.h"

@implementation EJAppDelegate (SDK)

#pragma mark - private method

/// 键盘管理
- (void)setupKeyboard {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].overrideKeyboardAppearance = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
}

#pragma mark - public response

- (void)setupSDK {
    // 键盘管理
    [self setupKeyboard];
}


@end
