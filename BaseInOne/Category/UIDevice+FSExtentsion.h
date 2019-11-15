//
//  UIDevice+FSExtentsion.h
//  FSZX
//
//  Created by lt on 2017/11/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface UIDevice (FSExtentsion)

- (BOOL)isX ;
- (CGFloat)statusBarHeight;
- (CGFloat)navgationBarHeight;
- (CGFloat)bottomHeight;
- (CGFloat)tableBarHeight;


- (NSString *)iphoneType;
// 判断相机和摄像头授权情况
- (BOOL)judgeVideoInputAvailable;
// 判断麦克风授权
- (BOOL)judgeAudioInputAvailable;
// 判断推送授权
-(BOOL)judgeNotificationAvailable;
/// 网络是否受限
- (BOOL)isNetworkRestricted;

- (NSString *)getUUID;
@end
