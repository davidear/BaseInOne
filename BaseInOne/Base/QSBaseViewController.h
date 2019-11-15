//
//  QSBaseViewController.h
//  qujiyi
//
//  Created by jason on 2019/6/6.
//  Copyright © 2019 jason. All rights reserved.
//
//  对于直接布局非scrollView的视图，可设置edgesForExtendedLayout来控制其布局区域
//  其他情况可使用ios10TopOffset来对ios10进行适配
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FSCallbackActionBlock) (void);
@interface QSBaseViewController : UIViewController
@property (nonatomic, copy) FSCallbackActionBlock callback;
@property (nonatomic, assign) float ios10TopOffset;

- (void)fs_loadDatas;
@end

NS_ASSUME_NONNULL_END
