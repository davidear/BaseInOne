//
//  UIDevice+FSExtentsion.m
//  FSZX
//
//  Created by lt on 2017/11/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIDevice+FSExtentsion.h"
#import <sys/utsname.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import<CoreTelephony/CTCellularData.h>

@implementation UIDevice (FSExtentsion)
- (BOOL)isX {
    
    return [self hasNotch];
}

- (BOOL)hasNotch {
    
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets inset = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets;
        
        return inset.bottom > 0 ? YES : NO;
        
    } else {
        
        return NO;
    }
}

- (CGFloat)statusBarHeight {
    
    if ([self hasNotch]) {
        
        return 44;
    }
    
    return 20;
}
- (CGFloat)navgationBarHeight {
    
    if ([self hasNotch]) {
        
        return 88;
    }
    
    return 64;
}

- (CGFloat)bottomHeight {
    
    if ([self hasNotch]) {
        
        return 34;
    }
    
    return 0;
}

- (CGFloat)tableBarHeight {
    
    if ([self hasNotch]) {
        
        return 83;
    }
    
    return 49;
}

- (NSString *)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";          // US (Verizon), China, Japan
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";     // US (Verizon), China, Japan
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";          // US (Verizon), China, Japan
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";          // AT&T, Global
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";     // AT&T, Global
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";          // AT&T, Global
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"])  return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

// 判断相机和摄像头授权情况
- (BOOL)judgeVideoInputAvailable {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (!granted) {
                    [self openSystemAuthorizeSetting:@"FO学院相机权限被拒，请手动开启"];
                }
            }];
            return NO;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            [self openSystemAuthorizeSetting:@"FO学院相机权限被拒，请手动开启"];
            return NO;
        case AVAuthorizationStatusAuthorized:
            return YES;
        default:
            return YES;
    }
}

- (BOOL)judgeAudioInputAvailable {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined://没有询问是否开启麦克风
        {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (!granted) {
                    [self openSystemAuthorizeSetting:@"FO学院麦克风权限被拒，请手动开启"];
                }
            }];
            return NO;
        }
        case AVAuthorizationStatusRestricted://未授权，家长限制
        case AVAuthorizationStatusDenied://拒绝
            [self openSystemAuthorizeSetting:@"FO学院麦克风权限被拒，请手动开启"];
            return NO;
        case AVAuthorizationStatusAuthorized://授权
            return YES;
        default:
            return YES;
    }
}

// 针对ios10以上有新的方法判断，但该方法支持从ios8以上的判断，故这里不做区分了
-(BOOL)judgeNotificationAvailable {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone;
#pragma clang diagnostic pop
}

- (NSString *)getUUID {
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return advertisingId;
}

#pragma mark - private
- (void)openSystemAuthorizeSetting:(NSString *)showText {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:showText message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            }];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:set];
    [alertVC addAction:cancel];
    // todo
//    [[AppDelegate sharedInstance].currentViewControlelr presentViewController:alertVC animated:YES completion:nil];
}

- (BOOL)isNetworkRestricted {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
    static CTCellularData *cellularData = nil;
    if (!cellularData) {
        cellularData = [[CTCellularData alloc] init];
    }
    
//    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
//        KKLog(@"%ld", state);
//        /// 只会响应 一次
//        if (state == kCTCellularDataRestricted) {
//            restrictedBlock ? restrictedBlock() : NULL;
//        }
//    };
    
    /// 得 block 响应后才能得到正确的状态
    KKLog(@"%ld", cellularData.restrictedState);
    return (cellularData.restrictedState == kCTCellularDataRestricted);
#endif
    return false;
}

@end
