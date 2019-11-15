//
//  MBProgressHUD+FSConvenience.m
//  FSZX
//
//  Created by jason on 2017/9/21.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MBProgressHUD+FSConvenience.h"
#import "AppDelegate.h"
@implementation MBProgressHUD (FSConvenience)
#pragma mark - Public
#pragma mark Message
+ (void)fs_showMessage:(NSString *)message {
    [self fs_showDetailMessage:message inView:[AppDelegate sharedInstance].window];
    
}

+ (void)fs_showMessage:(NSString *)message inView:(UIView *)view {
    if (!view) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self fs_hudInView:view];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.5];
    });
}

#pragma mark DetailMessage
+ (void)fs_showDetailMessage:(NSString *)message {
    [self fs_showDetailMessage:message inView:[AppDelegate sharedInstance].window];
}

+ (void)fs_showDetailMessage:(NSString *)message inView:(UIView *)view {
    if (!view) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self fs_hudInView:view];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = message;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.5];
    });
}

+ (void)fs_showDetailMessage:(NSString *)message inView:(UIView *)view hideAfterDelay:(NSNumber *)delay {
    if (!view) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self fs_hudInView:view];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = message;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:delay.floatValue];
    });
}

#pragma mark Loading
+ (void)fs_showLoading {
    [self fs_showLoading:@"加载中..."];
}

+ (void)fs_showLoading:(NSString *)message {
    [self fs_showLoading:message inView:[AppDelegate sharedInstance].window];
}

+ (void)fs_showLoading:(NSString *)message inView:(UIView *)view {
    if (!view) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self fs_hudInView:view];
        hud.label.text = message;
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud showAnimated:YES];
    });
}

#pragma Hide
+ (void)fs_hideHUD {
    [self fs_hideHUDInView:[AppDelegate sharedInstance].window];
}

+ (void)fs_hideHUDInView:(UIView *)view {
    if (!view) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hideAnimated:YES];
}

#pragma mark - Private
+ (MBProgressHUD *)fs_hudInView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        [hud removeFromSuperview];
    }
    hud = [[MBProgressHUD alloc] initWithView:view];
    [hud commonSetup];
    [view addSubview:hud];
    return hud;
}

- (void)commonSetup {
    self.removeFromSuperViewOnHide = YES;
//    self.margin = 12.f;
    self.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
}
@end


