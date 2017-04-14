//
//  EJStringPicker.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJStringPicker.h"

@interface EJStringPicker () < UIPickerViewDataSource,
                               UIPickerViewDelegate >

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSArray<NSString *> *dataSource;
@property (nonatomic, assign) NSInteger component1Row;
@property (nonatomic, assign) NSInteger component2Row;

@end

@implementation EJStringPicker

- (instancetype)initWithDataSource:(NSArray<NSString *> *)dataSource doneBlock:(EJPickerDoneBlock)doneBlock {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        self.clickDoneBlock = doneBlock;
    }
    return self;
}

- (void)configPiker {
    
    [self addSubview:self.titleView];
    [self addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_pickerType == EJStringPickerTypeSingle) {
        return 1;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataSource.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return _rowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = _font;
    titleLabel.textColor = _color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _dataSource[row];
    
    return titleLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickerType == EJStringPickerTypeSingle) {
        self.selectedValue = @{
                               @"row" : @(row),
                               @"value" : _dataSource[row],
                               };
    } else {
        if (component == 0) {
            _component1Row = row;
            if (_component1Row > _component2Row) {
                _component2Row = _component1Row;
                [pickerView selectRow:_component2Row inComponent:1 animated:YES];
            }
        } else {
            _component2Row = row;
            if (_component2Row < _component1Row) {
                _component1Row = _component2Row;
                [pickerView selectRow:_component1Row inComponent:0 animated:YES];
            }
        }
        self.selectedValue = @{
                               @"row1" : @(_component1Row),
                               @"value1" : _dataSource[_component1Row],
                               @"row2" : @(_component2Row),
                               @"value2" : _dataSource[_component2Row],
                               };
    }
}

#pragma mark - setter getter

- (UIView *)pickerView {
    _component1Row = 0;
    _component2Row = 0;
    if (!_pickerType) {
        _pickerType = EJStringPickerTypeSingle;
        self.selectedValue = @{
                               @"row" : @(0),
                               @"value" : _dataSource[0],
                               };
    } else {
        self.selectedValue = @{
                               @"row1" : @(_component1Row),
                               @"value1" : _dataSource[_component1Row],
                               @"row2" : @(_component2Row),
                               @"value2" : _dataSource[_component2Row],
                               };
    }
    
    _rowHeight = self.pickerRowHeight? self.pickerRowHeight: 45.f;
    _font = self.pickerFont? FONT(self.pickerFont): FONT(16.f);
    _color = self.pickerColor? self.pickerColor: HEX(0x3333333);
    
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
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, titleHeight, SCREEN_WIDTH, pickerHeight)];
    pickerView.delegate = self;
    pickerView.backgroundColor = self.pikerViewBackgroundColor? self.pikerViewBackgroundColor: HEX(0xf6f6f6);
    
    _pickerView = pickerView;
    
    return pickerView;
}

@end
