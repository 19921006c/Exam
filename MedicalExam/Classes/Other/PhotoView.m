//
//  PhotoView.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/5/29.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "PhotoView.h"
#import "WYPhoto.h"
#import "UIImageView+YYWebImage.h"

@interface PhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建gif图片(以后可能会用)
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;

        // 2.设置图片的内容模式
        self.contentMode =  UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setPhoto:(WYPhoto *)photo
{
    _photo = photo;
    NSURL *url = [NSURL URLWithString:photo.picUrl];
//    __weak PhotoView *weakself = self;
    [self setImageWithURL:url placeholder:[UIImage imageNamed:@"120x120"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        weakself.image = image;
//        FLOG(@"ERROR===%@", error);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
