//
//  EJEnum.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#import <CoreGraphics/CGBase.h>
#import <Foundation/Foundation.h>

#ifndef EJEnum_h
#define EJEnum_h

typedef NS_ENUM(NSInteger, EJType) {
    EJType1,
    EJType2,
    EJType3
};

typedef NSString EJShareType;
extern EJShareType * const EJShareTypeWechat;
extern EJShareType * const EJShareTypeQQ;
extern EJShareType * const EJShareTypeWeibo;

#endif /* EJEnum_h */
