//
//  FSExtraModel.m
//  FSZX
//
//  Created by Lihouzhao on 2017/8/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FSExtraModel.h"

@implementation FSExtraModel

+ (instancetype)calculateExtraModel:(FSExtraModel *)model list:(NSArray *)list {
    if (model) {
        model.total = NSIntegerMax;
        model.has_more = ((list.count % 20) == 0) && list.count ? YES : NO;
//        model.page = model.page;
        model.page_size = 20;
    }
    return model;
}
@end
