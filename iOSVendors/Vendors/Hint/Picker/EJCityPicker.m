//
//  EJCityPicker.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJCityPicker.h"

@interface EJCityPicker ()< UIPickerViewDataSource,
                            UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *countyArray;

@property (nonatomic, strong) NSDictionary *province;
@property (nonatomic, strong) NSDictionary *city;
@property (nonatomic, strong) NSDictionary *county;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, strong) UIColor *color;

@end

@implementation EJCityPicker

- (instancetype)initWithDoneBlock:(EJPickerDoneBlock)doneBlock {
    self = [super init];
    if (self) {
        self.clickDoneBlock = doneBlock;
        
        _cityArray = [NSMutableArray array];
        _countyArray = [NSMutableArray array];
        
        [self setInit];
    }
    return self;
}

- (void)setInit {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *province in self.dataSource) {
        [array addObject:province[@"County_Name"]];
    }
    _provinceArray = array;
    
    NSDictionary *province = _dataSource[0];
    for (NSDictionary *city in province[@"County_Child"]) {
        [_cityArray addObject:city[@"County_Name"]];
    }
    
    NSDictionary *city = _dataSource[0];
    for (NSDictionary *county in  city[@"County_Child"][0][@"County_Child"]) {
        [_countyArray addObject:county[@"County_Name"]];
    }
    
    _province = _dataSource[0];
    _city = _province[@"County_Child"][0];
    _county =  [_city[@"County_Child"] count]? _city[@"County_Child"][0]: @{};
    self.selectedValue = @[_province, _city, _county];
}

#pragma mark - method

- (void)configPiker {
    
    [self addSubview:self.titleView];
    [self addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArray.count;
    } else if (component == 1) {
        return _cityArray.count;
    }
    return _countyArray.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return _rowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.textColor = _color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.font = _font;
    
    if (component == 0) {
        titleLabel.text = _provinceArray[row];
    } else if (component == 1) {
        titleLabel.text = _cityArray[row];
    } else {
        titleLabel.text = _countyArray[row];
    }
    
    return titleLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _province = _dataSource[row];
        [_cityArray removeAllObjects];
        [_countyArray removeAllObjects];
        
        if (row > _dataSource.count - 4) {
            _city = nil;
            _county = nil;
        } else {
            for (NSDictionary *city in _province[@"County_Child"]) {
                [_cityArray addObject:city[@"County_Name"]];
            }
            
            _city = _province[@"County_Child"][0];
            _county =  [_city[@"County_Child"] count]? _city[@"County_Child"][0]: @{};
            for (NSDictionary *county in _city[@"County_Child"]) {
                [_countyArray addObject:county[@"County_Name"]];
            }
        }
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } else if (component == 1) {
        [_countyArray removeAllObjects];
        _city = _province[@"County_Child"][row];
        _county =  [_city[@"County_Child"] count]? _city[@"County_Child"][0]: @{};
        for (NSDictionary *county in _city[@"County_Child"]) {
            [_countyArray addObject:county[@"County_Name"]];
        }
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } else {
        _county = _city[@"County_Child"][row];
    }
    
    if (row < _dataSource.count - 3) {
        self.selectedValue = @[_province, _city, _county];
    } else {
        self.selectedValue = @[_province, _province, _province];
    }
    
}

#pragma mark - setter getter

- (UIView *)pickerView {
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
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, titleHeight, SCREEN_WIDTH, pickerHeight)];
    _pickerView.backgroundColor = self.pikerViewBackgroundColor? self.pikerViewBackgroundColor: HEX(0xf6f6f6);
    
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    return _pickerView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

@end
