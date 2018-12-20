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
    NSTimer * _timer;
    NSArray <NSURL *> *_urls;
    //轮播当前页
    NSUInteger _currentPage;
    //轮播实际总页数
    NSUInteger _totalPage;
}

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[SDBannerViewFlowLayout new]];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        self.delegate = self;
        _totalPage = urls.count * 3;
        [self registerClass:[SDBannerViewCell class] forCellWithReuseIdentifier:SDBannerViewCellID];
        //利用主队列异步保证数据源执行完毕之后再滚动
        // 初始显示第二组
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            _currentPage = _urls.count;
        });
        [self creatTimer];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (![_timer isValid]) {
        [self creatTimer];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 获取当前停留页
    long offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (offset == _totalPage - 1) {
        _currentPage = _urls.count - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentPage inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 获取当前停留页
    _currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //当前页为第0页 就跳转到第一组的第0页;当前页为最后一页，就跳转到第0组的最后一页
    if (_currentPage == 0) {
        _currentPage = _urls.count;
    }
    if (_currentPage == _totalPage - 1) {
        _currentPage = _urls.count - 1;
    }
    // 重新调整scrollView的偏移尺寸
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem: _currentPage inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

# pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalPage;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDBannerViewCellID forIndexPath:indexPath];
    cell.url = _urls[indexPath.item % _urls.count];
   return cell;
}

#pragma mark - timer
- (void)creatTimer {
    //添加定时器
    _timer = [NSTimer timerWithTimeInterval:2.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self bannerWithTimer:timer];
    }];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)bannerWithTimer:(NSTimer *)timer{
    _currentPage ++;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentPage inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

@end
