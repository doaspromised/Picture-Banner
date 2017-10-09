//
//  ViewController.m
//  PictureBanner
//
//  Created by Abner on 2017/10/9.
//  Copyright © 2017年 姜守栋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
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
