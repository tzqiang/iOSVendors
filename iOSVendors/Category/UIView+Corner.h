//
//  UIView+Corner.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

- (void)EJ_cornerNone;
- (void)EJ_corner:(UIRectCorner)corners radii:(CGFloat)radii;

@end
