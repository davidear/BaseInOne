//
//  FSIAPManager.m
//  FSZX
//
//  Created by jason on 2017/10/26.
//  Copyright © 2017年 ZSGY. All rights reserved.
//  1. 全局监听的问题，当用户在app开启时触发updatedTransactions，必须跟踪到并做处理
//  2. 验证处理有两种方法，方法一是拿到回执后关闭transaction，自己处理上传以及重试机制等等；方法二是等服务器返回再关闭transaction，相当于把重试机制交给苹果，但苹果这里只在app启动时触发该回调

#import "FSIAPManager.h"
#import "StoreKit/StoreKit.h"
//#import <SAMKeychain/SAMKeychain.h>
#import "NSString+YYAdd.h"
//#import "FSAPIHelper.h"
@interface FSIAPManager()<SKProductsRequestDelegate, SKPaymentTransactionObserver>
@property(nonatomic, strong) NSString *pid;
@property(nonatomic, strong) NSNumber *orderID;
@end
@implementation FSIAPManager
+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] initPrivate];
    });
    return instance;
}
- (instancetype) init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Singleton should not be init again" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        if ([SKPaymentQueue defaultQueue]) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        }
    }
    return self;
}

- (void)dealloc {
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    }
}

#pragma mark - Public
- (void)startIAP:(NSString *)productIdentifier order:(NSNumber *)orderID {
//    if (self.orderID) {
//        [MBProgressHUD fs_showMessage:@"当前正在购买，请稍后"];
//        return;
//    }
    self.pid = productIdentifier;
    self.orderID = orderID;
    [self startRequestProductInfoFromApple:[NSSet setWithObject:productIdentifier]];
}
#pragma mark - 1. 从apple获取产品信息
- (void)startRequestProductInfoFromApple:(NSSet *)identifiers {
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:identifiers];
    request.delegate = self;
    [request start];
}

#pragma mark  SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if ([product count] == 0) {
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu", (unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️\n %s 第%d行 \n", __func__,
              __LINE__);
        if ([pro.productIdentifier isEqualToString:self.pid]) {
            p = pro;
        }
    }
    if (p) {
        [self buyProduct:p];
    }else {
        [MBProgressHUD fs_showMessage:@"没有找到对应商品"];
        self.orderID = nil;
    }
}
#pragma mark - 2. 开始购买
- (void)buyProduct:(SKProduct *)productIdentifier {
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:productIdentifier];
//    if (![FSLoginTool isLogin]) {
    if (YES) {
        [MBProgressHUD fs_showMessage:@"您暂未登录，请登录"];
        return;
    }
    if (self.orderID == nil) {
        [MBProgressHUD fs_showMessage:@"订单号为空"];
        return;
    }
    
//    NSString *aun = [@[[NSString stringWithFormat:@"%ld",(long)[FSUserInfoManager sharedInstance].user.userId], self.orderID] componentsJoinedByString:@","];
    NSString *aun = @"TODO";
    payment.applicationUsername = aun;
    self.orderID = nil;
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

#pragma mark - 
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSDictionary *zgDic = @{@"方式" : @"苹果"};
    if (self.orderID) {
        zgDic = @{@"订单号" : self.orderID, @"方式" : @"苹果"};
    }
    // 存储上传信息
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    if ([receiptString length] > 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (transaction.payment.applicationUsername) {
            NSArray *array = [transaction.payment.applicationUsername componentsSeparatedByString:@","];
            dic[@"member_id"] = @([array[0] integerValue]);
            dic[@"code"] = array[1];
        }else {
            dic[@"member_id"] = @"TODO";
//            dic[@"member_id"] = @([FSUserInfoManager sharedInstance].user.userId);
        }
        dic[@"transaction_id"] = transaction.transactionIdentifier;
        dic[@"product_id"] = transaction.payment.productIdentifier;
        dic[@"receipt"] = [receiptString stringByURLEncode];
//        [self storeValidationInfo:dic];
        NSLog(@"%@",dic);
        NSLog(@"分割线");
        // 上传回执
        if ([self.delegate respondsToSelector:@selector(didStartValidation)]) {
            [self.delegate didStartValidation];
        }

        [self postReceiptInfo:dic transaction:transaction];
        //本地测试
        //        [self verifyPurchaseWithPaymentTransaction];
    }else {
    }
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Transaction error: %@ %ld", transaction.error.localizedDescription,(long)transaction.error.code);
    }
    
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    }
    if ([self.delegate respondsToSelector:@selector(didFailedIAP:)]) {
        [self.delegate didFailedIAP:transaction.error.localizedDescription];
    }
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    //目前没有针对restore的操作，因此直接关闭
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    }
}

#pragma mark - 3. 验证回执
- (void)postReceiptInfo:(NSDictionary *)dic transaction:(SKPaymentTransaction *)transaction {
//    if (![FSLoginTool isLogin]) {
//        return;
//    }
//    [FSAPIHelper varify:dic success:^(id  _Nonnull responseObject) {
//        NSMutableDictionary *zgDic = [NSMutableDictionary dictionaryWithDictionary:@{@"方式" : @"苹果"}];
//        if (dic[@"code"]) {
//            [zgDic setObject:dic[@"code"] forKey:@"订单号"];
//        }
//        // ////[[Zhuge sharedInstance] track:@"支付-发送回执成功" properties:zgDic];
//        if ([responseObject[@"code"] integerValue] == FSServerResponseCodeSuccess) {
//            // ////[[Zhuge sharedInstance] track:@"支付-验证回执成功" properties:zgDic];
//            // 放在这里处理是因为如果被代理出去，有可能代理是空，此时无法执行更新金额的操作
//            if ([FSLoginTool isLogin]) {
//                FSUserInfoModel *userInfo = [FSUserInfoManager sharedInstance].user;
//                userInfo.coins = [responseObject[@"data"][@"coins"] floatValue];
//                [[FSUserInfoManager sharedInstance] saveUserInfo:userInfo.mj_keyValues];
//            }
//            if ([self.delegate respondsToSelector:@selector(didPassValidation:)]) {
//                [self.delegate didPassValidation:[responseObject[@"data"][@"coins"] floatValue]];
//            }
//        }else {
//            [MBProgressHUD fs_showDetailMessage:responseObject[@"msg"]];
//            if ([self.delegate respondsToSelector:@selector(didFailedValidation:)]) {
//                [self.delegate didFailedValidation:responseObject[@"msg"]];
//            }
//        }
////        if ([responseObject[@"data"][@"transaction_id"] stringValue] == transaction.transactionIdentifier) {
//            if ([SKPaymentQueue defaultQueue]) {
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            }
////        }
//    } failure:^(NSError * _Nonnull error) {
//        NSMutableDictionary *zgDic = [NSMutableDictionary dictionaryWithDictionary:@{@"错误信息" : error.description, @"方式" : @"苹果"}];
//        if (dic[@"code"]) {
//            [zgDic setObject:dic[@"code"] forKey:@"订单号"];
//        }
//        // ////[[Zhuge sharedInstance] track:@"支付-发送回执失败" properties:zgDic];
//        if ([self.delegate respondsToSelector:@selector(didFailedUploadReceipt:)]) {
//            [self.delegate didFailedUploadReceipt:error.localizedDescription];
//        }
//    }];
}

#pragma mark - Not in use below
#pragma mark -

//- (void)postReceiptInfo:(NSDictionary *)dic {
//    [FSAPIHelper varify:dic success:^(id  _Nonnull responseObject) {
//        NSMutableDictionary *zgDic = [NSMutableDictionary dictionaryWithDictionary:@{@"方式" : @"苹果"}];
//        if (dic[@"code"]) {
//            [zgDic setObject:dic[@"code"] forKey:@"订单号"];
//        }
//        // ////[[Zhuge sharedInstance] track:@"支付-发送回执成功" properties:zgDic];
//        if ([responseObject[@"status_code"] integerValue] == 200) {
//            // ////[[Zhuge sharedInstance] track:@"支付-验证回执成功" properties:zgDic];
//            [MBProgressHUD fs_showMessage:@"交易完成"];
//        }else {
//            zgDic[@"错误信息"] = responseObject[@"message"];
//            // ////[[Zhuge sharedInstance] track:@"支付-验证回执失败" properties:zgDic];
//            [MBProgressHUD fs_showDetailMessage:responseObject[@"message"]];
//        }
//        if ([self.delegate respondsToSelector:@selector(didFinishedIAP)]) {
//            [self.delegate didFinishedIAP];
//        }
//        [self removeValidationInfo:[dic objectForKey:@"receipt"]];
//        [[FSUserInfoManager sharedInstance] fetchUserInfoFromServer];
//    } failure:^(NSError * _Nonnull error) {
//        NSMutableDictionary *zgDic = [NSMutableDictionary dictionaryWithDictionary:@{@"错误信息" : error.description, @"方式" : @"苹果"}];
//        if (dic[@"code"]) {
//            [zgDic setObject:dic[@"code"] forKey:@"订单号"];
//        }
//        // ////[[Zhuge sharedInstance] track:@"支付-发送回执失败" properties:zgDic];
//        if ([self.delegate respondsToSelector:@selector(didFailedUploadReceipt:)]) {
//            [self.delegate didFailedUploadReceipt:error.localizedDescription];
//        }
//    }];
//}
//
//- (void)validateReceipt {
//    NSDictionary *dic = [self fetchValidationInfo].lastObject;
//    if (dic) {
//        [self postReceiptInfo:dic];
//    }
//}
//#pragma mark - 本地验证，用于测试
//// 本地验证
//- (void)verifyPurchaseWithPaymentTransaction {
//    NSDictionary *localdic = [self fetchValidationInfo].lastObject;
//    if (!localdic) {// 无回执信息
//        return;
//    }
//
//    NSString *receiptString = localdic[@"receipt"];
//
//    NSString *bodyString =
//    [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}",
//     receiptString];  //拼接请求数据
//    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
//
//    //创建请求到苹果官方进行购买验证
//    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
//    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
//    requestM.HTTPBody = bodyData;
//    requestM.HTTPMethod = @"POST";
//    //创建连接并发送同步请求
//    NSError *error = nil;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:requestM
//                                                 returningResponse:nil
//                                                             error:&error];
//    if (error) {
//        NSLog(@"验证购买过程中发生错误，错误信息：%@", error.localizedDescription);
//        return;
//    }
//    NSDictionary *dic =
//    [NSJSONSerialization JSONObjectWithData:responseData
//                                    options:NSJSONReadingAllowFragments
//                                      error:nil];
//    NSLog(@"%@", dic);
//    if ([dic[@"status"] intValue] == 0) {
//        NSLog(@"购买成功！");
//        NSDictionary *dicReceipt = dic[@"receipt"];
//        NSDictionary *dicInApp = [dicReceipt[@"in_app"] firstObject];
//        NSString *productIdentifier = dicInApp[@"product_id"];  //读取产品标识
//    } else {
//        NSLog(@"购买失败，未通过验证！");
//    }
//}
//
//#pragma mark - 回执上传
//- (void)retryReceiptValidation {
//    NSArray *receiptArray = [self fetchValidationInfo];
//    for (NSDictionary *dic in receiptArray) {
//        [self postReceiptInfo:dic];
//    }
//}
//#pragma mark - 本地存储
//// 需要做加解密处理
//- (NSArray *)fetchValidationInfo {
//    NSData *data = [SAMKeychain passwordDataForService:@"foschool.cn" account:@"receipt"];
//    NSArray *receiptArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
////    NSArray *receiptArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"foschool.receipt"];
//    return receiptArray;
//}
//- (void)storeValidationInfo:(NSDictionary *)validationInfo {
//    NSArray *receiptArray = [self fetchValidationInfo];
//    NSMutableArray *ma = [NSMutableArray arrayWithArray:receiptArray];
//    [ma addObject:validationInfo];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ma];
//    [SAMKeychain setPasswordData:data forService:@"foschool.cn" account:@"receipt"];
//}
//- (void)removeValidationInfo:(NSString *)receipt {
//    NSArray *receiptArray = [self fetchValidationInfo];
//    NSMutableArray *ma = [NSMutableArray arrayWithArray:receiptArray];
//    NSDictionary *toRemove = nil;
//    for (NSDictionary *dic in ma) {
//        if ([[dic objectForKey:@"receipt"] isEqual:receipt]) {
//            toRemove = dic;
//        }
//    }
//    if (toRemove) {
//        [ma removeObject:toRemove];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ma];
//        [SAMKeychain setPasswordData:data forService:@"foschool.cn" account:@"receipt"];
//    }
//}

@end
