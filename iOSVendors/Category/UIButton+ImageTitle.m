//
//  UIButton+ImageTitle.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "UIButton+ImageTitle.h"

@implementation UIButton (ImageTitle)

- (void)EJ_imageTitlePosition:(EJButtonImageTitlePosition)position space:(CGFloat)space {
    [self layoutIfNeeded];
    
    space = space / 2;
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    CGFloat imageTop = 0.f;
    CGFloat imageLeft = 0.f;
    CGFloat imageBottom = 0.f;
    CGFloat imageRight = 0.f;
    
    CGFloat titleTop = 0.f;
    CGFloat titleLeft = 0.f;
    CGFloat titleBottom = 0.f;
    CGFloat titleRight = 0.f;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageFrame.size.height + space, -(imageFrame.size.width), 0, 0)];
    
    switch (position) {
        case EJButtonImageTitlePositionLeftRight: {
            imageLeft = - space;
            imageRight = - imageLeft;
            
            titleLeft = space;
            titleRight = - titleLeft;
        }
            break;
        case EJButtonImageTitlePositionRightLeft: {
            imageLeft = titleFrame.size.width + space;
            imageRight = - imageLeft;
            
            titleRight = imageFrame.size.width + space;
            titleLeft = - titleRight;
        }
            break;
        case EJButtonImageTitlePositionTopBottom: {
            imageBottom = titleFrame.size.height + space;
            imageRight = - titleFrame.size.width;
            
            titleTop = imageFrame.size.height + space;
            titleLeft = - imageFrame.size.width;
        }
            break;
        case EJButtonImageTitlePositionBottomTop: {
            imageTop = titleFrame.size.height + space;
            imageLeft = titleFrame.size.width;
            
            titleBottom = imageFrame.size.height + space;
            titleRight = imageFrame.size.width;
        }
            break;
            
        default:
            break;
    }
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTop, titleLeft, titleBottom, titleRight)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageTop, imageLeft, imageBottom, imageRight)];
}

@end
