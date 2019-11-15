//
//  AFNetworkReachabilityManager+FSNetType.m
//  FSZX
//
//  Created by tangwei on 2018/5/9.
//  Copyright © 2018年 FO Software Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

#import "AFNetworkReachabilityManager+FSNetType.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation AFNetworkReachabilityManager (FSNetType)
- (NSString *)fs_netType {
    //  用户网络环境：1 wifi，2 2G，3 3G，4 4G
    switch (self.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            return @"0";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"1";
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            NSArray *g2 = @[@"CTRadioAccessTechnologyGPRS", @"CTRadioAccessTechnologyEdge",@"CTRadioAccessTechnologyCDMA1x"];
            NSArray *g3 = @[@"CTRadioAccessTechnologyWCDMA", @"CTRadioAccessTechnologyHSDPA", @"CTRadioAccessTechnologyHSUPA",@"CTRadioAccessTechnologyCDMAEVDORev0",
                            @"CTRadioAccessTechnologyCDMAEVDORevA",@"CTRadioAccessTechnologyCDMAEVDORevB",@"CTRadioAccessTechnologyeHRPD"];
            if ([g2 containsObject:currentStatus]) {
                return @"2";
            }
            else if ([g3 containsObject:currentStatus]) {
                return @"3";
            }
            else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]) {
                return @"4";
            }
        }
        case AFNetworkReachabilityStatusUnknown:
            return @"99";
        default:
            break;
    }
    return @"99";
}
@end
