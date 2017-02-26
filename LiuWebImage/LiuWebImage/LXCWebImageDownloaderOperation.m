//
//  LXCWebImageDownloaderOperation.m
//  LiuWebImage
//
//  Created by 刘晓晨 on 2017/2/25.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCWebImageDownloaderOperation.h"

@implementation LXCWebImageDownloaderOperation

-(void)main {
    NSLog(@"%@",[NSThread currentThread]);
    
    //url
    NSURL *url = [NSURL URLWithString:_icon];
    
    //data
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //image
    UIImage *image = [UIImage imageWithData:data];
    if (self.block) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.block(image);
        }];
        
    }
    
}

+(instancetype) liuOperationWithIcon:(NSString *)icon andBlock:(void(^)(UIImage *image))block {
    LXCWebImageDownloaderOperation *op = [LXCWebImageDownloaderOperation new];
    op.icon = icon;
    op.block = block;
    return op;
}

-(void)setIcon:(NSString *)icon {
    _icon = icon;
}
@end
