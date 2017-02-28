//
//  ViewController.m
//  LiuWebImage
//
//  Created by 刘晓晨 on 2017/2/25.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "ViewController.h"
#import "LXCWebImageDownloaderOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "LiuAppModel.h"
#import "LXCWebImageManager.h"
#import "UIImageView+LXCWebCache.h"
@interface ViewController ()



@property(nonatomic,weak)UIImageView *imageView;




@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [self setupUI];
}

-(void)setupUI {
    //
    UIImageView *imageView = [UIImageView new];
    
    [self.view addSubview:imageView];
    
    imageView.center = self.view.center;
    imageView.bounds = CGRectMake(0, 0, 60, 60);
    
    self.imageView = imageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LiuAppModel *model = _dataArr[arc4random()%_dataArr.count];
    NSString *URLStr = model.icon;
    [self.imageView lxc_setImageWithURLStr:URLStr];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
-(void) loadData {
    
    //创建网络请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //获取网络数据
    [manager GET:@"https://raw.githubusercontent.com/butterflyXX/Liu_OCxxx/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        NSLog(@"%@",[NSThread currentThread]);
        self.dataArr = [NSArray yy_modelArrayWithClass:[LiuAppModel class] json:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"网络请求失败");
    }];
}

#pragma mark - 懒加载




@end
