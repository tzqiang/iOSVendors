//
//  UIButton+ImageTitle.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EJButtonImageTitlePosition) {
    /// 按钮图标文字左右排列
    EJButtonImageTitlePositionLeftRight,
    /// 按钮图标文字右左排列
    EJButtonImageTitlePositionRightLeft,
    /// 按钮图标文字上下排列
    EJButtonImageTitlePositionTopBottom,
    /// 按钮图标文字下上排列
    EJButtonImageTitlePositionBottomTop
};

@interface UIButton (ImageTitle)

/// 调整 button 的 image 和 title 的位置，使用间距 space（调用之前按钮前先预设一个 size 大小）
- (void)EJ_imageTitlePosition:(EJButtonImageTitlePosition)position space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
