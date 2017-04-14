//
//  UIView+Position.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView (Position)

- (CGFloat)EJ_top {
    return self.frame.origin.y;
}

- (void)setEJ_top:(CGFloat)EJ_top {
    CGRect frame = self.frame;
    frame.origin.y = EJ_top;
    self.frame= frame;
}

- (CGFloat)EJ_left {
    return self.frame.origin.x;
}

- (void)setEJ_left:(CGFloat)EJ_left {
    CGRect frame = self.frame;
    frame.origin.x = EJ_left;
    self.frame = frame;
}

- (CGFloat)EJ_bottom {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (void)setEJ_bottom:(CGFloat)EJ_bottom {
    CGRect frame = self.frame;
    frame.origin.y = EJ_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)EJ_right {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

- (void)setEJ_right:(CGFloat)EJ_right {
    CGRect frame = self.frame;
    frame.origin.x = EJ_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)EJ_width {
    return self.frame.size.width;
}

- (void)setEJ_width:(CGFloat)EJ_width {
    CGRect frame = self.frame;
    frame.size.width = EJ_width;
    self.frame = frame;
}

- (CGFloat)EJ_height {
    return self.frame.size.height;
}

- (void)setEJ_height:(CGFloat)EJ_height {
    CGRect frame = self.frame;
    frame.size.height = EJ_height;
    self.frame = frame;
}

- (CGPoint)EJ_origin {
    return self.frame.origin;
}

- (void)setEJ_origin:(CGPoint)EJ_origin {
    CGRect frame = self.frame;
    frame.origin = EJ_origin;
    self.frame = frame;
}

- (CGSize)EJ_size {
    return self.frame.size;
}

- (void)setEJ_size:(CGSize)EJ_size {
    CGRect frame = self.frame;
    frame.size = EJ_size;
    self.frame = frame;
}

- (CGFloat)EJ_centerX {
    return self.center.x;
}

- (void)setEJ_centerX:(CGFloat)EJ_centerX {
    CGPoint center = self.center;
    center.x = EJ_centerX;
    self.center = center;
}


- (CGFloat)EJ_centerY {
    return self.center.y;
}

- (void)setEJ_centerY:(CGFloat)EJ_centerY {
    CGPoint center = self.center;
    center.y = EJ_centerY;
    self.center = center;
}

@end
