//
//  UIImage+Category.h
//  user
//
//  Created by Liu Jie on 2019/8/27.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Category)
- (NSData *)compressToMaxSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
