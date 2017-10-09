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

@interface SDBannerView() <UICollectionViewDataSource, UICollectionViewDelegate>

@end
@implementation SDBannerView {
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[SDBannerViewFlowLayout new]];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[SDBannerViewCell class] forCellWithReuseIdentifier:SDBannerViewCellID];
        // 初始显示第二组
        //利用主队列异步保证数据源执行完毕之后再滚动
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        });
    }
    return self;
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 获取当前停留页
    CGFloat offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"偏移距离：%@-----当前页：%@",@(scrollView.contentOffset.x),@(offset));
    //当前页为第0页 就跳转到第一组的第0页;当前页为最后一页，就跳转到第0组的最后一页
    if (offset == 0) {
        offset = _urls.count;
    }
    if (offset == 5) {
        offset = _urls.count - 1;
    }
    // 重新调整scrollView的偏移尺寸
    scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
}
# pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _urls.count * 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDBannerViewCellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.url = _urls[indexPath.item % _urls.count];
    return cell;
}
@end
