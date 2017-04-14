//
//  UIImage+Extension.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (instancetype)EJ_splashImage; //获得闪屏页的图片
+ (instancetype)EJ_originalImageNamed:(NSString *)name; //无渲染模式的原图
+ (instancetype)EJ_imageWithColor:(UIColor *)color; //color生成image

@end
