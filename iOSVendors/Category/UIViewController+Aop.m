//
//  UIViewController+Aop.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "UIViewController+Aop.h"

#import <objc/runtime.h>

@implementation UIViewController (Aop)

/// 工具方法
+ (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class class = self;
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// UIViewController+AOP 类中：
+ (void)load {
    [super load];
    
    [UIViewController swizzleMethod:@selector(viewDidLoad) withMethod:@selector(aop_viewDidLoad)];
    
    [UIViewController swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(aop_viewWillAppear:)];
}

- (void)aop_viewDidLoad {
    [self aop_viewDidLoad];
    // 添加自定义的代码
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)aop_viewWillAppear:(BOOL)animated {
    [self aop_viewWillAppear:animated];
    
    // 修改 TZPhotoPickerController 的标题
//    if ([self isKindOfClass:[TZPhotoPickerController class]]) {
//        self.navigationItem.title = @"请选择";
//    }
}

@end
