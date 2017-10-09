//
//  SDBannerViewCell.m
//  PictureBanner
//
//  Created by Abner on 2017/10/9.
//  Copyright © 2017年 姜守栋. All rights reserved.
//

#import "SDBannerViewCell.h"

@implementation SDBannerViewCell
{
    UIImageView *_imgView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imgView];
    }
    return self;
}
- (void)setUrl:(NSURL *)url{
    _url = url;
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    _imgView.image = image;
}
@end
