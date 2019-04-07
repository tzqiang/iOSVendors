//
//  UIView+Position.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

/// view 的 frame.origin.y
@property (nonatomic, assign) CGFloat EJ_top;
/// view 的 frame.origin.x
@property (nonatomic, assign) CGFloat EJ_left;
/// view 的 frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat EJ_bottom;
/// view 的 frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat EJ_right;
/// view 的 frame.size.width
@property (nonatomic, assign) CGFloat EJ_width;
/// view 的 frame.size.height
@property (nonatomic, assign) CGFloat EJ_height;

/// view 的 frame.origin
@property (nonatomic, assign) CGPoint EJ_origin;
/// view 的 frame.size
@property (nonatomic, assign) CGSize EJ_size;
/// view 的 center.x
@property (nonatomic, assign) CGFloat EJ_centerX;
/// view 的 center.y
@property (nonatomic, assign) CGFloat EJ_centerY;
/// view 的 self.EJ_left
@property (nonatomic, assign) CGFloat EJ_minX;
/// view 的 self.EJ_left + self.EJ_width
@property (nonatomic, assign) CGFloat EJ_maxX;
/// view 的 self.EJ_top
@property (nonatomic, assign) CGFloat EJ_minY;
/// view 的 self.EJ_top + self.EJ_height
@property (nonatomic, assign) CGFloat EJ_maxY;

@end
