//
//  UIImage+Extension.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "UIImage+Extension.h"

#import <Photos/Photos.h>

@implementation UIImage (Extension)

+ (instancetype)EJ_splashImage {
    CGSize viewSize = [[UIScreen mainScreen] bounds].size;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    CGSize imageSize;
    for (NSDictionary* dict in imagesDict) {
        imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize))
            return [UIImage imageNamed:dict[@"UILaunchImageName"]];
    }
    return nil;
}

+ (instancetype)EJ_originalImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)EJ_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)EJ_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)EJ_compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    
    if (data.length < maxLength) return resultImage;
    
    // 如果要保证图片清晰度，建议选择压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return resultImage;
}

- (NSData *)EJ_compressImageQualityToByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    
    if (data.length < maxLength) return data;
    
    // 如果要保证图片清晰度，建议选择压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}

+ (instancetype)EJ_lineOfDashImageVerticalWithSize:(CGSize)size {
    CGFloat height = size.height;
    /// 竖线
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGFloat lengths[] = {2,1};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, height);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)EJ_lineOfDashImageHorizontalWithSize:(CGSize)size {
    /// 横线
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度和间距
    CGFloat lengths[] = {5,5};
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, height);
    CGContextMoveToPoint(line, 0, height);
    CGContextAddLineToPoint(line, width, height);
    CGContextStrokePath(line);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)EJ_fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

- (void)EJ_saveImageToPhotoShowView:(UIView *)view {
    if (!self) {
        [view showHUDWithMessage:@"图片保存失败！"];
        return;
    }
    
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    if (author == PHAuthorizationStatusRestricted || author ==PHAuthorizationStatusDenied) {
        [view showHUDWithMessage:@"请在设置中开启APP的相册访问权限！"];
        return;
    }
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:self];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [view showHUDWithMessage:@"保存成功！"];
        } else {
            [view showHUDWithMessage:@"保存失败！"];
        }
    }];
}


@end
