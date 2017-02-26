//
//  ViewController.m
//  LiuWebImage
//
//  Created by 刘晓晨 on 2017/2/25.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "ViewController.h"
#import "LXCWebImageDownloaderOperation.h"
@interface ViewController ()

@property(nonatomic,strong)NSOperationQueue *queue;

@property(nonatomic,weak)UIImageView *imageView;

@property(nonatomic,strong)NSCache *imageLoop;

@property(nonatomic,strong)NSCache *operationLoop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

-(void)setupUI {
    //
    UIImageView *imageView = [UIImageView new];
    
    [self.view addSubview:imageView];
    
    imageView.center = self.view.center;
    imageView.bounds = self.view.bounds;
    
    self.imageView = imageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *URLStr = @"http://img.1985t.com/uploads/attaches/2011/12/4213-QEAM1N.jpg";
    
    UIImage *image = [self.imageLoop objectForKey:URLStr];
    if (image != nil) {
        NSLog(@"从缓存中获取");
        self.imageView.image = image;
        
        return;
    }
    if ([self.operationLoop objectForKey:URLStr]) {
        NSLog(@"正在加载...");
        return;
    }
    LXCWebImageDownloaderOperation *op = [LXCWebImageDownloaderOperation liuOperationWithIcon:URLStr andBlock:^(UIImage *image) {
        self.imageView.image = image;
        [self.imageLoop setObject:image forKey:URLStr cost:1];
    }];
    [self.operationLoop setObject:op forKey:URLStr cost:1];
    [self.queue addOperation:op];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
        _queue.maxConcurrentOperationCount = 6;
    }
    return _queue;
}
-(NSCache *)imageLoop {
    if (!_imageLoop) {
        _imageLoop = [NSCache new];
        _imageLoop.totalCostLimit = 50;
    }
    return _imageLoop;
}
-(NSCache *)operationLoop {
    if (!_operationLoop) {
        _operationLoop = [NSCache new];
        _operationLoop.totalCostLimit = 50;
    }
    return _operationLoop;
}
@end
