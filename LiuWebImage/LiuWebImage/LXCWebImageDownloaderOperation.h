//
//  LXCWebImageDownloaderOperation.h
//  LiuWebImage
//
//  Created by 刘晓晨 on 2017/2/25.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LXCWebImageDownloaderOperation : NSOperation

/**
 下载的图片地址
 */
@property(nonatomic,strong)NSString *icon;

/**
 下载完成回调
 */
@property(nonatomic,copy)void(^block)(UIImage *image);
+(instancetype) liuOperationWithIcon:(NSString *)icon andBlock:(void(^)(UIImage *image))block;
@end
