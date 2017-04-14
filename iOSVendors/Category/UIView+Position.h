//
//  UIView+Position.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

@property (nonatomic, assign) CGFloat EJ_top;
@property (nonatomic, assign) CGFloat EJ_left;
@property (nonatomic, assign) CGFloat EJ_bottom;
@property (nonatomic, assign) CGFloat EJ_right;
@property (nonatomic, assign) CGFloat EJ_width;
@property (nonatomic, assign) CGFloat EJ_height;

@property (nonatomic, assign) CGPoint EJ_origin;
@property (nonatomic, assign) CGSize EJ_size;
@property (nonatomic, assign) CGFloat EJ_centerX;
@property (nonatomic, assign) CGFloat EJ_centerY;

@end
