//
//  SDBannerViewFlowLayout.m
//  PictureBanner
//
//  Created by Abner on 2017/10/9.
//  Copyright © 2017年 姜守栋. All rights reserved.
//

#import "SDBannerViewFlowLayout.h"

@implementation SDBannerViewFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    
}
@end
