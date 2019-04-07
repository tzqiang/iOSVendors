//
//  UIImage+Gradient.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,EJGradientType) {
    /// 由上到下渐变
    EJGradientTypeTopToBottom,
    /// 由左到右渐变
    EJGradientTypeLeftToRight
};

@interface UIImage (Gradient)

/// 图片渐变：颜色数组 渐变方向类型 图片的大小
+ (instancetype)EJ_gradientColors:(NSArray*)colors type:(EJGradientType)type imageSize:(CGSize)imageSize;

/// 图片的透明度
- (instancetype)EJ_imageAlpha:(CGFloat)alpha;

/// 设置图片圆角
- (instancetype)EJ_imageCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
