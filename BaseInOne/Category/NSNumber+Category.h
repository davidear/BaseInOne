//
//  NSNumber+Category.h
//  user
//
//  Created by Liu Jie on 2019/8/28.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Category)
/// 转换成分秒数 88'59"
- (NSString *)minuteSeondTime;
@end

NS_ASSUME_NONNULL_END
