//
//  UIView+Gradient.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

- (void)EJ_gradientColors:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    gradientLayer.colors = colors;
    
    if (start.x > 1) {
        start.x = 1;
    } else if (start.x < 0) {
        start.x = 0;
    }
    
    if (start.y > 1) {
        start.y = 1;
    } else if (start.y < 0) {
        start.y = 0;
    }
    
    if (end.x > 1) {
        end.x = 1;
    } else if (end.x < 0) {
        end.x = 0;
    }
    
    if (end.y > 1) {
        end.y = 1;
    } else if (end.y < 0) {
        end.y = 0;
    }
    
    gradientLayer.startPoint = start;
    gradientLayer.endPoint = end;
    
    [self.layer addSublayer:gradientLayer];
}

@end
