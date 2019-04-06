//
//  EJAPPConfig.m
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import "EJAPPConfig.h"

#pragma mark - constant

EJStringType * const EJStringType0 = @"0";
EJStringType * const EJStringType1 = @"1";

NSString * const EJRouterURLPop = @"EJ://pop";
NSString * const EJRouterURLLogin = @"EJ://login";
NSString * const EJRouterURLHome = @"EJ://home";

#pragma mark - system

CGFloat const kStatusBarHight = 20.f;
CGFloat const kNavigationBarHight = 44.f;
CGFloat const kTabBarHeight = 49.f;
CGFloat const kTableViewCellHeight = 44.f;

#pragma mark - custom

//(network)
NSString * const kPageCountKey = @"PageCount";
NSString * const kPageIndexKey = @"PageIndex";
NSString * const kPageDataKey = @"PageData";
NSString * const kReturnIDKey = @"Return_ID";
NSString * const kReturnMessKey = @"Return_Mess";
NSString * const kReturnDataKey = @"Return_Data";

//(info)
NSString * const kMembersID = @"MembersID";

#pragma mark - value

NSString * const kNilValue = @"";
NSTimeInterval const kAgainGetVerCodeTime = 120.0;

#pragma mark - Notification

NSString * const EJLogoutNotification = @"EJLogoutNotification";
