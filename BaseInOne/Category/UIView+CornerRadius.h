//
//  UIView+CornerRadius.h
//  ZLProject
//
//  Created by 智联技术 on 2019/1/29.
//  Copyright © 2019 智联技术. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)
- (void)cornerRadiusTopLeftReact:(CGRect)rect radius:(CGFloat)radius;
- (void)cornerRadiusTopLeftRightReact:(CGRect)rect radius:(CGFloat)radius;
- (void)cornerRadiusBottomLeftRightReact:(CGRect)rect radius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
