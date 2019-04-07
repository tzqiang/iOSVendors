//
//  UIView+Corner.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

/// 圆角为空
- (void)EJ_cornerNone;
/// 设置圆角：top left bottom right 
- (void)EJ_corner:(UIRectCorner)corners radii:(CGFloat)radii;

@end
