//
//  UIImage+Gradient.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

+ (instancetype)EJ_gradientColors:(NSArray*)colors type:(EJGradientType)type imageSize:(CGSize)imageSize {
    
    CGPoint start;
    CGPoint end;
    switch (type) {
        case EJGradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imageSize.height);
            break;
        case EJGradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        default:
            break;
    }
    
    // 颜色渐变
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorRef cgColor = (__bridge CGColorRef)[colors lastObject];
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(cgColor);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, NULL);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)EJ_imageAlpha:(CGFloat)alpha {
    // 透明度
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)EJ_imageCornerRadius:(CGFloat)cornerRadius {
    // 圆角
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
