//
//  EJHint.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJHint.h"

#import "MBProgressHUD.h"
#import "MMAlertView.h"
#import "MMSheetView.h"

#import "EJDatePicker.h"
#import "EJStringPicker.h"
#import "EJCityPicker.h"

#pragma mark - Alert

@implementation EJAlert

+ (void)updateTitle:(NSString *)title
             detail:(NSString *)detail
              items:(NSArray<NSString *> *)items
              click:(void (^)(NSInteger index))click {
    NSMutableArray *buttonItem = [NSMutableArray array];
    for (NSString *title in items) {
        [buttonItem addObject:MMItemMake(title, MMItemTypeHighlight, click)];
    }
    
    MMAlertView *alert = [[MMAlertView alloc] initWithTitle:title
                                                     detail:detail
                                                      items:buttonItem];
    alert.showCompletionBlock = ^(MMPopupView *popupView, BOOL show) {
        [MMPopupWindow sharedWindow].touchWildToHide = NO;
    };
    
    alert.hideCompletionBlock = ^(MMPopupView *popupView, BOOL show) {
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
    };
    
    [alert show];
}

+ (void)title:(NSString *)title
       detail:(NSString *)detail
        items:(NSArray<NSString *> *)items
        click:(MMPopupItemHandler)click {
    NSMutableArray *buttonItem = [NSMutableArray array];
    for (NSString *title in items) {
        [buttonItem addObject:MMItemMake(title, MMItemTypeHighlight, click)];
    }
    
    MMAlertView *alert = [[MMAlertView alloc] initWithTitle:title
                                                     detail:detail
                                                      items:buttonItem];
    [alert show];
}

@end

@implementation EJActionSheet

+ (void)title:(NSString *)title
        items:(NSArray<NSString *> *)items
        click:(MMPopupItemHandler)click {
    NSMutableArray *buttonItem = [NSMutableArray array];
    for (NSString *title in items) {
        [buttonItem addObject:MMItemMake(title, MMItemTypeNormal, click)];
    }
    MMSheetView *sheet = [[MMSheetView alloc] initWithTitle:title
                                                      items:buttonItem];
    
    sheet.showCompletionBlock = ^(MMPopupView *popupView, BOOL show) {
        //        [MMPopupWindow sharedWindow].touchWildToHide = NO;
    };
    
    sheet.hideCompletionBlock = ^(MMPopupView *popupView, BOOL show) {
        //        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        click(-1); //点击取消按钮的回调 inde = -1
    };
    
    [sheet show];
}

@end

#pragma mark - HUD

@implementation UIView (HUD)

- (void)showHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
        if (hud) {
            [hud hideAnimated:NO];
            hud = nil;
        }
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.bezelView.backgroundColor = color_999999;
    });
}

- (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
        hud.bezelView.backgroundColor = color_999999;
        
        [hud hideAnimated:YES];
    });
}

- (void)showHUDWithMessage:(NSString *)message {
    [self showHUDWithMessage:message afterDelay:1.5f];
}

- (void)showHUDWithMessage:(NSString *)message afterDelay:(NSTimeInterval)delay{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
        if (hud) {
            [hud hideAnimated:NO];
            hud = nil;
        }
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.backgroundColor = color_000000;
        hud.bezelView.opaque = 1;
        hud.label.font = font_16;
        hud.label.textColor = color_ffffff;
        hud.label.text = message;
        hud.label.numberOfLines = 0;
        [hud hideAnimated:YES afterDelay:delay];
    });
}

@end
