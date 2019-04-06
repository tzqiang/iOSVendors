//
//  EJHint.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EJAlert : NSObject

/// 更新提示框
+ (void)updateTitle:(NSString *)title
             detail:(NSString *)detail
              items:(NSArray<NSString *> *)items
              click:(void (^)(NSInteger index))click;

/// 提示框
+ (void)title:(NSString *)title
       detail:(NSString *)detail
        items:(NSArray<NSString *> *)items
        click:(void (^)(NSInteger index))click;

@end

@interface EJActionSheet : NSObject

/// 底部弹出框
+ (void)title:(NSString *)title
        items:(NSArray<NSString *> *)items
        click:(void (^)(NSInteger index))click;

@end

@interface UIView (HUD)

/// 显示loading
- (void)showHUD;

/// 隐藏loading
- (void)hideHUD;

/// 显示消息 2s后自动隐藏
- (void)showHUDWithMessage:(NSString *)message;

/// 显示消息 delays后自动隐藏
- (void)showHUDWithMessage:(NSString *)message afterDelay:(NSTimeInterval)delay;

@end
