//
//  EJDatePicker.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJDatePicker.h"

@interface EJDatePicker ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation EJDatePicker

#pragma mark - instance

- (instancetype)initWithDoneBlock:(EJPickerDoneBlock)doneBlock {
    self = [super init];
    if (self) {
        self.clickDoneBlock = doneBlock;
        
    }
    return self;
}

#pragma mark - method

- (void)configPiker {
    
    [self addSubview:self.titleView];
    [self addSubview:self.pickerView];
}

#pragma mark - setter getter

- (UIView *)pickerView {
    CGFloat titleHeight = self.titleViewHeight? self.titleViewHeight : 50.f;
    CGFloat pickerHeight = self.pickerViewHeight? self.pickerViewHeight : 200.f;
    
    MMWeakify(self);
    self.showAnimation = ^(MMPopupView *view) {
        MMStrongify(self);
        if (!self.superview) {
            [self.attachedView.mm_dimBackgroundView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, titleHeight + pickerHeight));
                make.centerX.equalTo(self.attachedView);
                make.bottom.equalTo(self.attachedView);
            }];
            [self layoutIfNeeded];
        }
        
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, titleHeight + pickerHeight );
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^ {
            view.frame = CGRectMake(0, SCREEN_HEIGHT - titleHeight - pickerHeight, SCREEN_WIDTH, titleHeight + pickerHeight );
        } completion:^(BOOL finished) {
            if (self.showCompletionBlock) {
                self.showCompletionBlock(self, finished);
            }
        }];
    };
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, titleHeight, SCREEN_WIDTH, pickerHeight)];
    datePicker.backgroundColor = self.pikerViewBackgroundColor? self.pikerViewBackgroundColor: HEX(0xf6f6f6);
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [NSDate date];
    [datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    self.selectedValue = datePicker.date;
    _datePicker = datePicker;
    
    return datePicker;
}

- (void)dateChange:(UIDatePicker *)sender {
    self.selectedValue = sender.date;
}

@end
