//
//  EJPopupViewController.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJPopupViewController.h"

NSString * const popupCell = @"popupCell";

@interface EJPopupViewController () < UITableViewDataSource,
                                      UITableViewDelegate >

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation EJPopupViewController

#pragma mark - life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Popup";
    self.view.backgroundColor = color_background;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    
}

#pragma mark - private method

- (void)hideHUD {
    [self.view hideHUD];
}

- (void)layoutPageSubviews {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:popupCell];
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [EJActionSheet datePikerClickDone:^(id selectedValue) {
            NSDate *date = selectedValue;
            [self.view showHUDWithMessage:date.description];
        }];
    } else if (indexPath.row == 1) {
        [EJActionSheet stringPikerTitle:@"体重" items:@[@"50kg", @"60kg", @"70kg", @"80kg"] isSingle:YES clickDone:^(id selectedValue) {
            NSString *value = [NSString stringWithFormat:@"value = %@",selectedValue[@"value"]];
            [self.view showHUDWithMessage:value];
        }];
    } else if (indexPath.row == 2) {
        [EJActionSheet stringPikerTitle:@"身高" items:@[@"150cm", @"160cm", @"170cm", @"180cm"] isSingle:NO clickDone:^(id selectedValue) {
            NSString *value = [NSString stringWithFormat:@"row1 = %@, row2 = %@",selectedValue[@"value1"],selectedValue[@"value2"]];
            [self.view showHUDWithMessage:value];
        }];
    } else if (indexPath.row == 3) {
//        [EJActionSheet  countySelectClick:^(id selectedValue) {
//            
//        }];
    }
}

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:popupCell];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[ @"DatePicker",
                         @"SingleStringPicker",
                         @"RangeStringPicker",
                         @"CountyPicker"
                         ];
    }
    return _dataSource;
}

@end
