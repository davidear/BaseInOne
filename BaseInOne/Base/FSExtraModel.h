//
//  FSExtraModel.h
//  FSZX
//
//  Created by Lihouzhao on 2017/8/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSExtraModel : NSObject

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) BOOL has_more;

+ (instancetype)calculateExtraModel:(FSExtraModel *)model list:(NSArray *)list;
@end
