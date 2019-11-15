//
//  QSBaseViewController.m
//  qujiyi
//
//  Created by jason on 2019/6/6.
//  Copyright © 2019 jason. All rights reserved.
//

#import "QSBaseViewController.h"

@interface QSBaseViewController ()

@end

@implementation QSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)fs_loadDatas {
    
}

@end
