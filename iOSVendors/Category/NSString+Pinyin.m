//
//  NSString+Pinyin.m
//  iOSVendors
//
//  Created by Awro on 2019/4/7.
//  Copyright © 2019 tzqiang. All rights reserved.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

- (instancetype)pinyin {
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (instancetype)capitalize_A {
    if (!self.length) {
        return nil;
    }
    
    NSString *pinyin = [self pinyin];
    NSString *capitalize = [pinyin substringToIndex:1].uppercaseString;
    
    unichar character = [capitalize characterAtIndex:0];
    if (character >= 'A' && character <= 'Z') {
        return capitalize;
    }
    return @"#";
}

@end
