//
//  UIView+Corner.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)EJ_cornerNone {
    if (self.layer.mask) {
        [self.layer.mask removeFromSuperlayer];
        self.layer.mask = nil;
    }
}

- (void)EJ_corner:(UIRectCorner)corners radii:(CGFloat)radii {
    CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
        self.layer.mask = maskLayer;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radii, radii)];
    maskLayer.path = path.CGPath;
}

@end
