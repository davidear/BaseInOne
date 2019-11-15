//
//  FSLiveVodContainerController.m
//  FSZX
//
//  Created by jason on 2018/11/13.
//  Copyright © 2018 FO Software Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//
//  need to make it better,just no error right now

#import "FSBaseNavigationTabContainerController.h"
#import "HMSegmentedControl.h"
#import "QSBaseViewController.h"
@interface FSBaseNavigationTabContainerController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
// 这里比较绕，系统没有直接提供读取当前控制器的
@property (assign, nonatomic) NSInteger targetIndex;

@end

@implementation FSBaseNavigationTabContainerController
- (instancetype)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey : @0}];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex == currentIndex) {
        return;
    }
    _currentIndex = currentIndex;
    self.segmentedControl.selectedSegmentIndex = currentIndex;
}

#pragma mark - Life Cycle
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey : @0}];
//        self.pageViewController.dataSource = self;
//        self.pageViewController.delegate = self;
//        self.pageContentArray = @[[[FSLiveStreamListController alloc] init], [[FSVODContainerController alloc] init]];
////        [self addChildViewController:[[FSLiveStreamListController alloc] init]];
////        [self addChildViewController:[[FSVODContainerController alloc] init]];
//    }
//    return self;
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.pageViewController.view.frame = self.view.bounds;
//    [self.view addSubview:self.pageViewController.view];
//    [self.pageViewController setViewControllers:@[self.pageContentArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
//
//    }];
//    self.pageViewController.viewQ.frame = self.view.bounds;
//    [self.view addSubview:self.pageViewController.view];
//    [self addChildViewController:self.pageViewController];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *ma = [NSMutableArray array];
    for (QSBaseViewController *vc in self.pageContentArray) {
//        vc.inContainer = YES;
        [ma addObject:vc.title];
    }
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:ma];
    segmentedControl.frame = CGRectMake(10, 10, 200, 40);
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor darkTextColor]};
//    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : kMainColor};
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.selectionIndicatorHeight = 2.0f;
//    segmentedControl.selectionIndicatorColor = kMainColor;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.navigationItem.titleView = segmentedControl;
    self.segmentedControl = segmentedControl;
    
    [self setViewControllers:@[self.pageContentArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
    }];
    
    if (@available(iOS 11.0, *)) {
    }else {
        float naviH = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        //        self.view.frame = CGRectMake(0, naviH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - naviH);
        UILayoutGuide *layoutGuide = [[UILayoutGuide alloc] init];
        // 需要使用UIView的addLayoutGuide方法添加新建的layoutGuide
        [self.view addLayoutGuide:layoutGuide];
        // 正式的约束代码
        [layoutGuide.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:naviH].active = YES;
    }
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSUInteger index = [self.pageContentArray indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return self.pageContentArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSUInteger index = [self.pageContentArray indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.pageContentArray.count) {
        return nil;
    }
    return self.pageContentArray[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
    NSLog(@"here is %@", pendingViewControllers);
    self.targetIndex = [self.pageContentArray indexOfObject:[pendingViewControllers firstObject]];
}

// jtd how to cooperate with segment control
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentIndex = self.targetIndex;
    }
}

#pragma mark -
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentControl {
    [self setViewControllers:@[self.pageContentArray[segmentControl.selectedSegmentIndex]] direction:(segmentControl.selectedSegmentIndex == 0 ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward) animated:YES completion:^(BOOL finished) {
    }];
    self.currentIndex = segmentControl.selectedSegmentIndex;
}
#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
