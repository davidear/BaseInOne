//
//  FSBaseTableViewController.h
//  FSZX
//
//  Created by Lihouzhao on 2017/7/12.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "QSBaseViewController.h"
#import "FSBaseTableView.h"
#import "FSExtraModel.h"
#import "MJRefresh.h"
#import "FSPaginateModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kFSNormalTableViewHeaderView = @"normalHeader";
static NSString * const kFSNormalTableViewFooterView = @"normalFooter";

@interface QSBaseTableController : QSBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL isGroup; // means table style
@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) FSExtraModel *extra;
//@property (nonatomic, strong) NSMutableDictionary *requestParams;

#pragma mark - Reminder
//- (void)qs_endRefreshWithList:(NSArray *)list;
//
//- (void)qs_endRefreshWithList:(NSArray *)list image:(UIImage *)image;
//
//- (void)qs_endRefreshWithList:(NSArray *)list
//                        image:(UIImage *)image
//                      message:(NSString *)message;
//
//- (void)qs_endRefreshWithList:(NSArray *)list
//                        image:(UIImage *)image
//                      message:(NSString *)message
//                  buttonTitle:(NSString *)btnTitle;

/**
 *  请注意 statusCode: FSResponse的statueCode
 */
//- (void)fs_endRefreshWithStatusCode:(NSInteger)StatusCode;
//
/////
//- (void)fs_endRefreshWithList:(NSArray *)list message:(NSString *)message;
//
/////
//- (void)fs_endRefreshWithList:(NSArray *)list image:(UIImage *)image message:(NSString *)message;

- (void)fs_endRefresh;

- (void)fs_refreshHeader;

- (void)fs_refreshFooter;

@end


NS_ASSUME_NONNULL_END
