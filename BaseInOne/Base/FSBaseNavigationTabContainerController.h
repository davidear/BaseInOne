//
//  FSLiveVodContainerController.h
//  FSZX
//
//  Created by jason on 2018/11/13.
//  Copyright © 2018 FO Software Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSBaseNavigationTabContainerController : UIPageViewController
@property (nonatomic, strong) NSArray *pageContentArray;
@property (assign, nonatomic) NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
