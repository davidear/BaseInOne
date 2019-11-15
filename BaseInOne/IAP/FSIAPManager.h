//
//  FSIAPManager.h
//  FSZX
//
//  Created by jason on 2017/10/26.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol FSIAPManagerDelegate <NSObject>
// 购买未完成
- (void)didFailedIAP:(NSString *)errorInfo;
// 开始验证流程
- (void)didStartValidation;
// 上传回执失败
- (void)didFailedUploadReceipt:(NSString *)errorInfo;
// 上传回执成功后，验证回执失败
- (void)didFailedValidation:(NSString *)errorInfo;
// 上传回执成功后，验证回执成功
- (void)didPassValidation:(CGFloat)coins;

@end
@interface FSIAPManager : NSObject
+ (FSIAPManager *)sharedInstance;
@property (weak, nonatomic) id<FSIAPManagerDelegate> delegate;
- (void)startIAP:(NSString *)productIdentifier order:(NSNumber *)orderID;

//- (void)retryReceiptValidation;

@end
