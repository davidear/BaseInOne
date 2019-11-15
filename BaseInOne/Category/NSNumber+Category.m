//
//  NSNumber+Category.m
//  user
//
//  Created by Liu Jie on 2019/8/28.
//  Copyright © 2019 jason. All rights reserved.
//

#import "NSNumber+Category.h"

@implementation NSNumber (Category)
- (NSString *)minuteSeondTime {
    NSInteger time = self.integerValue;
    NSInteger second = time%60;
    NSInteger minute = time/60;
    return [NSString stringWithFormat:@"%ld'%02ld\"", minute, second];
}
@end
