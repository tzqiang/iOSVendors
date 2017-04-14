//
//  EJMacro.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#ifndef EJMacro_h
#define EJMacro_h

//debug模式下附带有函数名和行号的NSLog
#ifdef DEBUG
#define DLog(fmt, ...) NSLog("%s:%d\n\t%@\n", __FUNCTION__, __LINE__, [NSString stringWithFormat:fmt, ##__VA_ARGS__])
#else
#define DLog(...)
#endif

//颜色相关
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.f)
#define HEXA(hex, a) RGBA((hex & 0xff0000) >> 16, (hex & 0xff00) >> 8, hex & 0xff, a)
#define HEX(hex) HEXA(hex, 1.f)

//NSUserDefaults
#define DEFAULTS [NSUserDefaults standardUserDefaults]

//NSNotificationCenter
#define NOTIFY [NSNotificationCenter defaultCenter]

//mainWindow
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

//屏幕尺寸
#define SCREEN_SCALE ([UIScreen mainScreen].scale)
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH CGRectGetWidth(SCREEN_BOUNDS)
#define SCREEN_HEIGHT CGRectGetHeight(SCREEN_BOUNDS)

//字体
#define FONT(s) [UIFont systemFontOfSize:s]

//获取系统版本号，double类型
#define _SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] doubleValue]
#define iOS8 (_SYSTEM_VERSION >= 8.f)
#define iOS10 (_SYSTEM_VERSION >= 10.f)

//Nib
#define NIB(n) [UINib nibWithNibName:NSStringFromClass([n class]) bundle:nil]

//
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//weakify
#ifndef weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#endif /* EJMacro_h */
