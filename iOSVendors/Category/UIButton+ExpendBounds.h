//
//  UIButton+ExpendBounds.h
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ExpendBounds)

/// 增加扩大按钮点击响应区域
- (void)EJ_setExpendEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
