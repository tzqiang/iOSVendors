//
//  UIImage+Extension.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 获得闪屏页的图片
+ (instancetype)EJ_splashImage;

/// 无渲染模式的原图
+ (instancetype)EJ_originalImageNamed:(NSString *)name;

/// color生成image
+ (instancetype)EJ_imageWithColor:(UIColor *)color;

/// color生成指定size的image
+ (instancetype)EJ_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 二分法来优化。循环来逐渐减小图片质量，直到图片稍小于指定大小(maxLength)。
+ (instancetype)EJ_compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
/// 两种图片压缩方法结合 如果要保证图片清晰度，建议选择压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。
- (NSData *)EJ_compressImageQualityToByte:(NSInteger)maxLength;

/// 生成虚线的 image 竖线
+ (instancetype)EJ_lineOfDashImageVerticalWithSize:(CGSize)size;
/// 虚线 横线
+ (instancetype)EJ_lineOfDashImageHorizontalWithSize:(CGSize)size;

/// 纠正图片的方向 比如，相机拍摄的图片带有方向，有时候你会发现通过 CGImageGetWidth,CGImageGetHeight获取宽高相反，或者上传的图片，在安卓上方向不对，这时候就需要纠正图片的方向。
- (instancetype)EJ_fixOrientation;

/// 保存图片到相册中 显示消息的视图view
- (void)EJ_saveImageToPhotoShowView:(UIView *)view;

@end
