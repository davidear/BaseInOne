//
//  FSBaseNavigationController.m
//  FSZX
//
//  Created by HZ L on 2017/11/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FSBaseNavigationController.h"

@interface FSBaseNavigationController () <UINavigationControllerDelegate, UINavigationBarDelegate>

//@property (nonatomic, strong) NSArray *classArray;

@end

@implementation FSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    UIViewController *rootController = [navigationController.viewControllers firstObject];
//    NSLog(@"willShowViewController %@", viewController);
//    if (rootController == viewController) {
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kMainColor, NSFontAttributeName : [UIFont systemFontOfSize:18.0f]}];
//    }else {
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : GGGrayBarColor, NSFontAttributeName : [UIFont systemFontOfSize:18.0f]}];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
