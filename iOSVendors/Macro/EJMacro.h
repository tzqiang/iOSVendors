//
//  EJMacro.h
//  iOSVendors
//
//  Created by tzqiang on 2017/4/14.
//  Copyright © 2017年 tzq. All rights reserved.
//

#ifndef EJMacro_h
#define EJMacro_h

// debug模式下附带有函数名和行号的NSLog
#ifdef DEBUG

/// debug 模式日志打印
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

# define DLog(...);

#endif

/// RGBA 颜色设置（alpha）
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
/// RGB 颜色设置
#define RGB(r, g, b) RGBA(r, g, b, 1.f)
/// HEXA 16 进制颜色设置（alpha）
#define HEXA(hex, a) RGBA((hex & 0xff0000) >> 16, (hex & 0xff00) >> 8, hex & 0xff, a)
/// HEX 16 进制颜色设置
#define HEX(hex) HEXA(hex, 1.f)

/// NSUserDefaults
#define DEFAULTS [NSUserDefaults standardUserDefaults]

/// NSNotificationCenter
#define NOTIFYCENTER [NSNotificationCenter defaultCenter]

/// mainWindow
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

/// 屏幕尺寸 scale
#define SCREEN_SCALE ([UIScreen mainScreen].scale)
/// 屏幕尺寸 bounds
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
/// 屏幕尺寸 width
#define SCREEN_WIDTH CGRectGetWidth(SCREEN_BOUNDS)
/// 屏幕尺寸 height
#define SCREEN_HEIGHT CGRectGetHeight(SCREEN_BOUNDS)

/// 字体设置
#define FONT(s) [UIFont systemFontOfSize:s]

/// 获取系统版本号，double类型
#define _SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] doubleValue]
/// iOS8 系统版本以上
#define iOS8 (_SYSTEM_VERSION >= 8.f)
/// iOS10 系统版本以上
#define iOS10 @available(iOS 10, *)
/// iOS11 系统版本以上
#define iOS11 @available(iOS 11, *)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
// iOS11以上的系统
//#define iOS11 @available(iOS 11, *)

#endif

// iPhone 机型
/// 4 寸小屏手机
#define iPhone5 (SCREEN_HEIGHT < 667.f)
/// 4.7 寸中屏手机
#define iPhone6 (SCREEN_HEIGHT == 667.f)
/// 5.5 寸大屏手机
#define iPhonePlus (SCREEN_HEIGHT > 667.f)
/// 5.8 || 6.1 || 6.5 寸刘海屏手机
#define iPhoneX (SCREEN_HEIGHT == 812.f || SCREEN_HEIGHT == 896.f)

/// iPhoneX 的状态栏安全区域距离
#define iPhoneXStatusBarSafeMargin [[NSNumber numberWithDouble:44.f] doubleValue]
/// iPhoneX 的底部条安全区域距离
#define iPhoneXTabBarSafeMargin [[NSNumber numberWithDouble:34.f] doubleValue]

/// 导航栏高度
#define naviBarHeight iPhoneX? iPhoneXStatusBarSafeMargin + 44.f: 20.f + 44.f
/// TabBar 高度
#define tabBarHeight iPhoneX? iPhoneXTabBarSafeMargin + 49.f: 49.f

/// Nib
#define NIB(n) [UINib nibWithNibName:NSStringFromClass([n class]) bundle:nil]

/// app 版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/// app 构建版本
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/// app 唯一标识
#define APP_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

/// 单例 .h 文件
#define SingletonH(name) + (instancetype)shared##name;
/// 单例 .m 文件
#define SingletonM(name) \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return _instance; \
}

#ifndef weakify
#if __has_feature(objc_arc)

/// block 弱引用
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

/// block 强引用
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

/// 消除可能会造成内存泄漏的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* EJMacro_h */
