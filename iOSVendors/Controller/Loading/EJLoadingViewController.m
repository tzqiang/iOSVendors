//
//  EJLoadingViewController.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJLoadingViewController.h"

#import "UIImage+Extension.h"

#import "EJGuideViewController.h"
#import "EJTabBarController.h"

@interface EJLoadingViewController ()

@property (nonatomic, strong) UIImageView *splashImageView;
@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger skipInterval;

@end

@implementation EJLoadingViewController

#pragma makr - life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _skipInterval = 3;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    || ![localVersion isEqualToString:APP_VERSION]
    NSString *localVersion = @"11";
    if (!localVersion ) {
        [[[UIApplication sharedApplication] delegate] window].rootViewController = [[EJGuideViewController alloc] init];
    } else {
        [self.view addSubview:self.splashImageView];
        [self.view addSubview:self.skipButton];
        
        [self layoutPageSubviews];
    }
    
    [self appSetting];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.timer fire];
}

- (void)dealloc {
    [self stopTimer];
}

#pragma mark - event response

- (void)clickSkipButton {
    [self loadingCompletion];
}

- (void)updateTime {
    _skipInterval --;
    [_skipButton setTitle:[NSString stringWithFormat:@"跳过%lds",_skipInterval] forState:UIControlStateNormal];
    
    if (_skipInterval == 0) {
        [self stopTimer];
        [self loadingCompletion];
    }
}

#pragma mark - private method

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)loadingCompletion {
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication] delegate] window].rootViewController = [[EJTabBarController alloc] init];
    }];
}

- (void)layoutPageSubviews {
    [_splashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.f, 50.f));
        make.top.equalTo(self.view).offset(15.f);
        make.right.equalTo(self.view).offset(-10.f);
    }];
}

- (void)appSetting {
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : font_10,
                                   NSForegroundColorAttributeName : HEX(0x94949c)
                                   }
                        forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : color_df4444
                                   }
                        forState:UIControlStateSelected];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setShadowImage:[[UIImage alloc] init]];
    [bar setTranslucent:NO];
    [bar setTitleTextAttributes:@{
                                  NSFontAttributeName : font_17,
                                  NSForegroundColorAttributeName : color_333333
                                  }];
    //    [bar setBackIndicatorImage:[UIImage imageNamed:@"icon_large_leftarrow"]];
    //    [bar setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];
    //    [bar setTintColor:color_666666];
    //
    //    UIBarButtonItem *backBarItem = [UIBarButtonItem appearance];
    //    [backBarItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, -SCREEN_HEIGHT) forBarMetrics:UIBarMetricsDefault];
    
    [bar setBackIndicatorImage:[[UIImage alloc] init]];
    [bar setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(-20.f, -20.f, -20.f, -20.f);
    
    UIBarButtonItem *backBarItem = [UIBarButtonItem appearance];
    UIImage* image = [[[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
    [backBarItem setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backBarItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, 0) forBarMetrics:UIBarMetricsDefault];
    
    [[UICollectionView appearance] setBackgroundColor:color_ffffff];
    [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - setter getter 

- (UIImageView *)splashImageView {
    if (!_splashImageView) {
        _splashImageView = [[UIImageView alloc] init];
        _splashImageView.image = [UIImage EJ_splashImage];
    }
    return _splashImageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.backgroundColor = HEXA(0xffffff, 0.54);
        [_skipButton setTitleColor:HEX(0x333333) forState:UIControlStateNormal];
        _skipButton.titleLabel.font = FONT(13.f);
        _skipButton.titleLabel.numberOfLines = 0;
        _skipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_skipButton setTitle:[NSString stringWithFormat:@"跳过%lds",_skipInterval] forState:UIControlStateNormal];
        
        _skipButton.layer.cornerRadius = 25.f;
        _skipButton.layer.masksToBounds = YES;
        
        [_skipButton addTarget:self action:@selector(clickSkipButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

@end
