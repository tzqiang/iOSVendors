//
//  EJTabBarController.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJTabBarController.h"

#import "UIImage+Extension.h"

#import "EJVendorsViewController.h"

@interface EJTabBarController ()

@end

@implementation EJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *normalImage = nil;
    UIImage *highlightImage = nil;
    
    EJVendorsViewController *homeVC = [EJVendorsViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navi.navigationBar.translucent = YES;
    normalImage = [UIImage EJ_originalImageNamed:@"tab_home_normal"];
    highlightImage = [UIImage EJ_originalImageNamed:@"tab_home_highlight"];
    navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                    image:normalImage
                                            selectedImage:highlightImage];
    [self addChildViewController:navi];

}

@end
