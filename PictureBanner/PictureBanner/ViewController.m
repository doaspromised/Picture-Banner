//
//  ViewController.m
//  PictureBanner
//
//  Created by Abner on 2017/10/9.
//  Copyright © 2017年 姜守栋. All rights reserved.
//

#import "ViewController.h"
#import "SDBannerView.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    
    //创建界面
    SDBannerView *bannerView = [[SDBannerView alloc] initWithURLs:_urls];
    bannerView.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, 100);
    [self.view addSubview:bannerView];
    NSLog(@"%@",_urls);
}

- (void)loadData{
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%02zd.jpg", (i + 1)];
        NSLog(@"文件名%@",fileName);
        NSURL *imgURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [arrM addObject:imgURL];
    }
    _urls = arrM.copy;
}


@end
