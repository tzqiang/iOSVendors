//
//  EJGuideViewController.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJGuideViewController.h"

#import "EJTabBarController.h"

#import "UIView+Position.h"

@interface EJGuideViewController () < UIScrollViewDelegate >

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *guideImageView;

@property (nonatomic, strong) NSArray *backgroundImages;
@property (nonatomic, strong) NSArray *guideImages;

@end

@implementation EJGuideViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self layoutPageSubviews];
}

#pragma mark - event response

- (void)clickSkipButton {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.3f;
        self.view.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        WINDOW.rootViewController = [[EJTabBarController alloc] init];
    }];
}

#pragma mark - private method

- (void)layoutPageSubviews {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_backImageView addSubview:self.skipButton];
    
    [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backImageView);
        make.bottom.equalTo(_backImageView).offset(-40.f);
        make.size.mas_equalTo(CGSizeMake(125.f, 30.f));
    }];

}

#pragma mark - setter getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = SCREEN_HEIGHT;
        NSInteger count = self.backgroundImages.count;
        for (int i = 0; i < count; ++i) {
            _backImageView = [[UIImageView alloc] init];
            _backImageView.frame = CGRectMake(i * width, 0.f, width, height);
            _backImageView.image = [UIImage imageNamed:self.backgroundImages[i]];
            [self.scrollView addSubview:_backImageView];
            
            _guideImageView = [[UIImageView alloc] init];
            _guideImageView.frame = _backImageView.bounds;
            _guideImageView.contentMode = UIViewContentModeScaleAspectFit;
            _guideImageView.image = [UIImage imageNamed:self.guideImages[i]];
            [_backImageView addSubview:_guideImageView];
        }
        _backImageView.userInteractionEnabled = YES;
        
        _scrollView.contentSize = CGSizeMake(width * count, height);
    }
    return _scrollView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.bounds = CGRectMake(0.f, 0.f, 125.f, 35.f);
        _skipButton.EJ_centerX = self.view.EJ_centerX;
        _skipButton.EJ_bottom = self.view.EJ_bottom - 40.f;
        [_skipButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _skipButton.backgroundColor =  [UIColor redColor];
        
        [_skipButton addTarget:self action:@selector(clickSkipButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (NSArray *)backgroundImages {
    if (!_backgroundImages) {
        _backgroundImages = @[ @"guide_background1",
                               @"guide_background2",
                               @"guide_background3",
                               @"guide_background4"
                               ];
    }
    return _backgroundImages;
}

- (NSArray *)guideImages {
    if (!_guideImages) {
        _guideImages = @[ @"guide_1",
                          @"guide_2",
                          @"guide_3",
                          @"guide_4"
                          ];
    }
    return _guideImages;
}

@end
