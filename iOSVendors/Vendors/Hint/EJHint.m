//
//  EJHint.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJHint.h"

#import "MBProgressHUD.h"

#import "MBProgressHUD.h"
#import "MMAlertView.h"
#import "MMSheetView.h"

#import "EJDatePicker.h"
#import "EJStringPicker.h"
#import "EJCityPicker.h"

#pragma mark - Alert

@implementation EJAlert

+ (void)title:(NSString *)title
       detail:(NSString *)detail
        items:(NSArray *)items
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

+ (void)title:(NSString *)title
       detail:(NSString *)detail
  placeholder:(NSString *)placeholder
        click:(MMPopupInputHandler)click {
    MMAlertView *alert = [[MMAlertView alloc] initWithInputTitle:title
                                                          detail:detail
                                                     placeholder:placeholder handler:click];
    [alert show];
}

@end

#pragma mark - ActionSheet

@implementation EJActionSheet

+ (void)title:(NSString *)title
        items:(NSArray *)items
        click:(MMPopupItemHandler)click {
    NSMutableArray *buttonItem = [NSMutableArray array];
    for (NSString *title in items) {
        [buttonItem addObject:MMItemMake(title, MMItemTypeHighlight, click)];
    }
    MMSheetView *sheet = [[MMSheetView alloc] initWithTitle:title
                                                      items:buttonItem];
    
    sheet.hideAnimation = ^(MMPopupView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    };
    
    [sheet show];
}

+ (void)stringPikerTitle:(NSString *)title
                   items:(NSArray *)items
                isSingle:(BOOL)single
               clickDone:(void (^)(id selectedValue))click {
    EJStringPicker *picker = [[EJStringPicker alloc] initWithDataSource:items doneBlock:click];
    picker.titleString = [[NSAttributedString alloc] initWithString:title attributes:@{ NSFontAttributeName : FONT(16.f), NSForegroundColorAttributeName: HEX(0x333333)}];
    if (!single) {
        picker.pickerType = EJStringPickerTypeRange;
    }
    [picker configPiker];
    [picker show];
}

+ (void)datePikerClickDone:(void (^)(id selectedValue))click {
    EJDatePicker *picker = [[EJDatePicker alloc] initWithDoneBlock:click];
    [picker configPiker];
    [picker show];
}

+ (void)countySelectClick:(void (^)(id selectedValue))click {
    EJCityPicker *picker = [[EJCityPicker alloc] initWithDoneBlock:click];
    [picker configPiker];
    [picker show];
}

@end

#pragma mark - HUD

@implementation UIView (HUD)

- (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud) {
        [hud hide:NO];
        hud = nil;
    }
    hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)hideHUD {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    [hud hide:YES];
}

- (void)showHUDLoadingMask:(BOOL)mask {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud) {
        [hud hide:NO];
        hud = nil;
    }
    hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSMutableArray *images = [NSMutableArray array];
    UIImage *image;
    for (int i = 0; i < 8; ++i) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i]];
        [images addObject:image];
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = CGRectMake(0.f, 0.f, 37.f, 37.f);
    imageView.animationImages = images;
    imageView.animationDuration = 1.8f;
    hud.customView = imageView;
    [imageView startAnimating];
    hud.dimBackground = mask;
}

- (void)hideHUDLoading {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    [(UIImageView *)hud.customView stopAnimating];
    [hud hide:YES];
}

- (void)showHUDWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud) {
        [hud hide:NO];
        hud = nil;
    }
    hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:2.f];
}

@end
