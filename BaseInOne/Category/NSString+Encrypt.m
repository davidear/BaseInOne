//
//  NSString+Encrypt.m
//  ZLProject
//
//  Created by 智联技术 on 2019/1/15.
//  Copyright © 2019 智联技术. All rights reserved.
//

#import "NSString+Encrypt.h"

@implementation NSString (Encrypt)
///
- (NSString *)formatePrivacyPhone {

    if (self.length > 6) {
        NSMutableString * mutlPhone = [NSMutableString stringWithString:self];
        [mutlPhone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        NSNumber *num = @(1);
        return [mutlPhone copy];
    }
    return self;
}

- (NSString *)formatePrivacyNickName {
    
    NSMutableString * mutlPhone = [NSMutableString stringWithString:self];
    if (mutlPhone.length == 2) {
        [mutlPhone replaceCharactersInRange:NSMakeRange(1, mutlPhone.length-1) withString:@"*"];
    } else if (mutlPhone.length > 2) {
        NSMutableString *tmp = [NSMutableString stringWithString:[mutlPhone substringToIndex:1]];
        for (int i=0; i < mutlPhone.length-2; i++) {
            [tmp appendString:@"*"];
        }
        [tmp appendString:[mutlPhone substringFromIndex:mutlPhone.length-1]];
        return tmp;
    }
    return mutlPhone;
}

#pragma mark - 去空格 和 去掉粘贴来的电话号首位会有隐藏字符
- (NSString *)phoneNumberFormat {
    NSMutableString *multString = [[NSMutableString alloc] init];
    for (int i = 0; i < self.length; i++) {
        char c = [self characterAtIndex:i];
        [multString appendFormat:@"%c",c];
    }
    
    NSString *tmp = [multString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"-,+()"];
    tmp = [[tmp componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    return tmp;
}

- (BOOL)isPunctuation {
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:self];
    return !result;
}

@end
