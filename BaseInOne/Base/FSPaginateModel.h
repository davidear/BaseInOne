//
//  FSPaginateModel.h
//  FSZX
//
//  Created by foschool on 2017/10/12.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPaginateModel : NSObject
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) BOOL has_more;
@property (nonatomic, assign) NSInteger total_page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger page;
@end
