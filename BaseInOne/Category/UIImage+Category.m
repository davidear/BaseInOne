//
//  UIImage+Category.m
//  user
//
//  Created by Liu Jie on 2019/8/27.
//  Copyright © 2019 jason. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (NSData *)compressToMaxSize:(CGFloat)size {
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
@end
