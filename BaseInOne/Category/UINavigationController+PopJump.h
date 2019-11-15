//
//  UINavigationController+PopJump.h
//  qujiyi
//
//  Created by jason on 2019/7/12.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (PopJump)
- (BOOL)popToExist:(NSString *)classString;
- (BOOL)popToExistInArray:(NSArray *)ClassStringArray;

- (void)popToExistOrNil:(NSString *)classString;
- (void)popToExistOrNilInArray:(NSArray *)classStringArray;

@end

NS_ASSUME_NONNULL_END
