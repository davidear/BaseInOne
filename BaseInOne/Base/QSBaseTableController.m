//
//  FSBaseTableViewController.m
//  FSZX
//
//  Created by Lihouzhao on 2017/7/12.
//  Copyright © 2017年 ZSGY. All rights reserved.
//
//  neet to fill the DZNEmptyDataSet

#import "QSBaseTableController.h"
#import "FSBaseTableView.h"
#import "Masonry.h"
#import "UIScrollView+EmptyDataSet.h"
//Unless you are importing as a framework, then do:
//#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface QSBaseTableController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, assign) BOOL constraintIsSet;// 控制限制只添加一次
@end

@implementation QSBaseTableController

@synthesize dataSource = _dataSource;

//- (NSMutableDictionary *)requestParams {
//    if (!_requestParams) {
//        _requestParams = @{}.mutableCopy;
//    }
//    return _requestParams;
//}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource.mutableCopy;
}

- (FSExtraModel *)extra {
    if (!_extra) {
        _extra = [[FSExtraModel alloc] init];
        _extra.page = 1;
        _extra.page_size = 20;
    }
    return _extra;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    FSBaseTableView *tableView = nil;
    if (_isGroup) {
        tableView = [[FSBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    } else {
        tableView = [[FSBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fs_refreshHeader)];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
//    header.lastUpdatedTimeLabel.textColor = KColor4;
    header.stateLabel.font = [UIFont systemFontOfSize:12];
//    header.stateLabel.textColor = KColor4;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fs_refreshFooter)];
    [footer setTitle:@"————  我是有底线的  ————" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.stateLabel.textColor = KColor4;
    
    tableView.mj_header = header;
    tableView.mj_footer = footer;
    
    self.tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.constraintIsSet) {
        if (@available(iOS 11.0, *)) {
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }];
        }else {
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(self.ios10TopOffset);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(self.mas_bottomLayoutGuide);
            }];
        }
        self.constraintIsSet = YES;
    }
}

//- (void)qs_endRefreshWithList:(NSArray *)list {
//    [self qs_endRefreshWithList:list image:[UIImage imageNamed:@"p_null_data"]];
//}
//
//- (void)qs_endRefreshWithList:(NSArray *)list image:(UIImage *)image {
//    [self qs_endRefreshWithList:list image:image message:@"这里没有数据哦～"];
//}
//
//- (void)qs_endRefreshWithList:(NSArray *)list
//                        image:(UIImage *)image
//                      message:(NSString *)message {
//    [self qs_endRefreshWithList:list image:image message:message buttonTitle:nil];
//}
//
//- (void)qs_endRefreshWithList:(NSArray *)list
//                        image:(UIImage *)image
//                      message:(NSString *)message
//                  buttonTitle:(NSString *)btnTitle {
//    [self fs_endRefresh];
//    if (list.count < 1) {
//        __weak typeof(self) weakSelf = self;
//        [self.tableView addReminderWithImage:image message:message btnTitle:btnTitle clickBlock:^(UIButton *btn) {
//            [weakSelf fs_loadDatas];
//        }];
//    }
//}

- (void)fs_endRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)fs_refreshHeader {
//    [self.tableView dismissReminder];
    self.extra.page = 1;
    [self fs_loadDatas];
}

- (void)fs_refreshFooter {
    self.extra.page++;
    [self fs_loadDatas];
}

#pragma mark - delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
