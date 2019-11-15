//
//  UINavigationController+PopJump.m
//  qujiyi
//
//  Created by jason on 2019/7/12.
//  Copyright © 2019 jason. All rights reserved.
//

#import "UINavigationController+PopJump.h"
#import "NSObject+YYAdd.h"
@implementation UINavigationController (PopJump)
- (BOOL)popToExist:(NSString *)classString {
    NSArray *vcs = self.viewControllers;
    __block UIViewController *target = nil;
    [vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj className] isEqualToString:classString]) {
            target = obj;
            *stop = YES;
        }
    }];
    if (target != nil) {
        [self popToViewController:target animated:YES];
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)popToExistInArray:(NSArray *)ClassStringArray {
    NSArray *vcs = self.viewControllers;
    __block UIViewController *target = nil;
    for (NSString *classString in ClassStringArray) {
        [vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj className] isEqualToString:classString]) {
                target = obj;
                *stop = YES;
            }
        }];
    }
    if (target != nil) {
        [self popToViewController:target animated:YES];
        return YES;
    }else {
        return NO;
    }
}

- (void)popToExistOrNil:(NSString *)classString {
    if (![self popToExist:classString]) {
        [self popViewControllerAnimated:YES];
    }
}

- (void)popToExistOrNilInArray:(NSArray *)classStringArray {
    if (![self popToExistInArray:classStringArray]) {
        [self popViewControllerAnimated:YES];
    }
}
@end
