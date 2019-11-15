//
//  MBProgressHUD+FSConvenience.h
//  FSZX
//
//  Created by jason on 2017/9/21.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FSConvenience)

#pragma mark - HUD
// 显示提示信息,并延迟自动关闭
+ (void)fs_showMessage:(NSString *)message;
+ (void)fs_showMessage:(NSString *)message inView:(UIView *)view;
+ (void)fs_showDetailMessage:(NSString *)message inView:(UIView *)view hideAfterDelay:(NSNumber *)delay;
//
+ (void)fs_showDetailMessage:(NSString *)message;
+ (void)fs_showDetailMessage:(NSString *)message inView:(UIView *)view;
// 显示菊花，文字-加载中...
+ (void)fs_showLoading;
// 显示菊花，文字-自定义
+ (void)fs_showLoading:(NSString *)message;
+ (void)fs_showLoading:(NSString *)message inView:(UIView *)view;
// 隐藏所有指示器
+ (void)fs_hideHUD;
+ (void)fs_hideHUDInView:(UIView *)view;


@end
