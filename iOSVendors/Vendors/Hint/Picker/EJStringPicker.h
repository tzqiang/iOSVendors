//
//  EJStringPicker.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJPicker.h"

typedef NS_ENUM(NSInteger, EJStringPickerType) {
    EJStringPickerTypeSingle,
    EJStringPickerTypeRange,
};

@interface EJStringPicker : EJPicker

- (instancetype)initWithDataSource:(NSArray <NSString *>*)dataSource
                         doneBlock:(EJPickerDoneBlock)doneBlock;

@property (nonatomic, assign) EJStringPickerType pickerType;

@end
