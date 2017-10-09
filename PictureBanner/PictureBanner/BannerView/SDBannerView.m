//
//  SDBannerView.m
//  PictureBanner
//
//  Created by Abner on 2017/10/9.
//  Copyright © 2017年 姜守栋. All rights reserved.
//

#import "SDBannerView.h"
#import "SDBannerViewFlowLayout.h"
#import "SDBannerViewCell.h"
NSString *const SDBannerViewCellID = @"SDBannerViewCellID";

@interface SDBannerView() <UICollectionViewDataSource>

@end
@implementation SDBannerView {
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[SDBannerViewFlowLayout new]];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        [self registerClass:[SDBannerViewCell class] forCellWithReuseIdentifier:SDBannerViewCellID];
    }
    return self;
}

# pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _urls.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDBannerViewCellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.url = _urls[indexPath.item];
    return cell;
}
@end
