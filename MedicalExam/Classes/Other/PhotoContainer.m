//
//  PhotoContainer.m
//  DoctorPlatForm
//
//  Created by weiyi on 15/5/29.
//  Copyright (c) 2015年 songzm. All rights reserved.
//
#define PhotoWidth 60
#define PhotoHeight PhotoWidth
#define PhotoMargin 5 // 间隙

#import "PhotoContainer.h"
#import "PhotoView.h"
#import "WYPhoto.h"
@implementation PhotoContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建9张图片
        for (int i = 0; i < 9; i++) {
            PhotoView *photoView = [[PhotoView alloc] init];
            [self addSubview:photoView];
            photoView.tag = (i + 1) * 1000;
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

- (void)setPicUrls:(NSArray *)picUrls // 6 0~5 7 0~6
{
    _picUrls = picUrls;
    
    int count = (int)picUrls.count;
    
    // 防止重用
    if (count == 0) {
        self.hidden = YES;
        return;
    }else
    {
        self.hidden = NO;
    }
    
    for (int i = 0; i < 9; i++) {
        PhotoView *photoView = (PhotoView *)self.subviews[i];
        // 判断是否需要显示
        if (i < count) {
            // 显示子配图
            photoView.hidden = NO;
            WYPhoto *photo = [[WYPhoto alloc]init];
            photo.picUrl = _picUrls[i];
            photoView.photo = photo;
        }else
        {
            // 隐藏子配图
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.picUrls.count;
    if (count == 1) {
        UIImageView *imageView = self.subviews[0];
        imageView.frame = CGRectMake(0, 0, 120, 120);
        return;
    }
    if (count > 9) {
        count = 9;
    }
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        imageView.width = PhotoWidth;
        imageView.height = PhotoHeight;
        int maxClos = count == 4 ? 2 : 3;
        int row = i / maxClos;
        imageView.y = row * (PhotoHeight + PhotoMargin);
        int col = i % maxClos;
        imageView.x = col * (PhotoWidth + PhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)count
{
    if (count == 1) {
        return CGSizeMake(120, 120);
    }
    // 最大列数
    int maxClos = count == 4 ? 2 : 3;
    int cols = count >= 3 ? maxClos : count;
    
    int rows = 0;
    // 3 / 6 / 9
    if (count % 3 == 0) {
        rows = count / 3;// 1 2 3
    }else
    {
        rows = count / 3 + 1;// 1 2
    }
    
    CGFloat photosViewW = cols * PhotoWidth + (cols - 1) * PhotoMargin;
    CGFloat photosViewH = rows * PhotoHeight + (rows - 1) * PhotoMargin;
    
    return CGSizeMake(photosViewW, photosViewH);
}
+ (CGSize)PhotoSizeWithCount:(int)count{
    return CGSizeZero;
}

//- (void)imageTapAction:(UITapGestureRecognizer *)tap{
//    WYLog(@"ddd");
//}
@end
