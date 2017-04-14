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

+ (void)title:(NSString *)title
       detail:(NSString *)detail
        items:(NSArray *)items
        click:(void (^)(NSInteger index))click;

+ (void)title:(NSString *)title
       detail:(NSString *)detail
  placeholder:(NSString *)placeholder
        click:(void (^)(NSString *input))click;

@end

@interface EJActionSheet : NSObject

+ (void)title:(NSString *)title
        items:(NSArray *)items
        click:(void (^)(NSInteger index))click;

+ (void)stringPikerTitle:(NSString *)title
                   items:(NSArray *)items
                isSingle:(BOOL)single
               clickDone:(void (^)(id selectedValue))click;

+ (void)datePikerClickDone:(void (^)(id selectedValue))click;

+ (void)countySelectClick:(void (^)(id selectedValue))click;

@end

@interface UIView (HUD)

- (void)showHUD;
- (void)hideHUD;
- (void)showHUDLoadingMask:(BOOL)mask;
- (void)hideHUDLoading;

- (void)showHUDWithMessage:(NSString *)message;

@end
