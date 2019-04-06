//
//  EJPicker.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^EJPickerDoneBlock)(id selectedValue);
typedef void(^EJPickerCancelBlock)(void);

@interface EJPicker : MMPopupView

@property (nonatomic, copy) NSAttributedString *titleString;
@property (nonatomic, copy) NSAttributedString *cancelString;
@property (nonatomic, copy) NSAttributedString *doneString;

@property (nonatomic, strong) UIColor *titleViewBackgroundColor;
@property (nonatomic, strong) UIColor *pikerViewBackgroundColor;

@property (nonatomic, assign) CGFloat titleViewHeight;
@property (nonatomic, assign) CGFloat pickerViewHeight;

@property (nonatomic, assign) CGFloat pickerRowHeight;
@property (nonatomic, assign) CGFloat pickerFont;
@property (nonatomic, strong) UIColor *pickerColor;

@property (nonatomic, copy) EJPickerDoneBlock clickDoneBlock;
@property (nonatomic, copy) EJPickerCancelBlock clickCancelBlock;

@property (nonatomic, strong) id selectedValue;
@property (nonatomic, strong) UIView *titleView;

- (UIView *)pickerView;

- (void)configPiker;

@end
