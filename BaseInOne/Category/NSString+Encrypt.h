//
//  NSString+Encrypt.h
//  ZLProject
//
//  Created by 智联技术 on 2019/1/15.
//  Copyright © 2019 智联技术. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

///phone:1868887668  return:186****7668
- (NSString *)formatePrivacyPhone;

/// 隐藏昵称中间文字 return:乔*斯
- (NSString *)formatePrivacyNickName;

#pragma mark - 去空格 和 去掉粘贴来的电话号首位会有隐藏字符
- (NSString *)phoneNumberFormat;

/// 是否标点符号
- (BOOL)isPunctuation;

@end

NS_ASSUME_NONNULL_END
