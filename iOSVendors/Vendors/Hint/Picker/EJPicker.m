//
//  EJPicker.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJPicker.h"

@implementation EJPicker

#pragma mark - instance

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        self.hideAnimation = ^(MMPopupView *view) {
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        };
    }
    return self;
}

- (void)dealloc {
    _clickCancelBlock = nil;
    _clickDoneBlock = nil;
}

#pragma mark - event response

- (void)clickCancelButton {
    [self hide];
    if (_clickCancelBlock) {
        _clickCancelBlock();
    }
}

- (void)clickDoneButton {
    [self hide];
    if (_clickDoneBlock) {
        _clickDoneBlock(_selectedValue);
    }
}

#pragma mark - method

- (void)configPiker {
    
}

#pragma mark - setter and getter

- (UIView *)titleView {
    if (!_titleView) {
        CGFloat titleHeight = _titleViewHeight? _titleViewHeight : 50.f;
        
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
        _titleView.backgroundColor = _titleViewBackgroundColor? _titleViewBackgroundColor : HEX(0xffffff);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(60.f, 0, SCREEN_WIDTH - 120.f, titleHeight);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                                      NSForegroundColorAttributeName: [UIColor darkGrayColor]
                                      };
        NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
        titleLabel.attributedText = _titleString? _titleString : titleString;
        [_titleView addSubview:titleLabel];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, 0, 60, titleHeight);
        [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        NSAttributedString *cancelString = [[NSAttributedString alloc] initWithString:@"取消" attributes:attributes];
        [cancelButton setAttributedTitle:_cancelString? _cancelString : cancelString forState:UIControlStateNormal];
        [_titleView addSubview:cancelButton];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, titleHeight);
        [doneButton addTarget:self action:@selector(clickDoneButton) forControlEvents:UIControlEventTouchUpInside];
        NSAttributedString *doneString = [[NSAttributedString alloc] initWithString:@"确定" attributes:attributes];
        [doneButton setAttributedTitle:_doneString? _doneString : doneString forState:UIControlStateNormal];
        [_titleView addSubview:doneButton];
    }
    return _titleView;
}

- (UIView *)pickerView {
    NSAssert(NO, @"子类实现(例如EJDatePicker)");
    return nil;
}

@end
