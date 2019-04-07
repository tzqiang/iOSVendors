//
//  UIView+Gradient.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gradient)

/**
 添加渐变颜色 start和end属性，决定了渐变的方向。以单位坐标系，左上角坐标是{0, 0}，右下角坐标是{1, 1}
 @param colors 渐变颜色数组 CGColorRef
 @param start 开始点
 @param end 结束点
 */
- (void)EJ_gradientColors:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end;

@end

NS_ASSUME_NONNULL_END
