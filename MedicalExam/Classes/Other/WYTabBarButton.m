//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "WYTabBarButton.h"

@implementation WYTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = WYRandomColor;
        // Initialization code
        // 1.设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 2.设置标题居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 3.设置标题的大小
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        // 4.设置标题颜色
        [self setTitleColor:[UIColor colorWithHexString:@"#909093"] forState:UIControlStateNormal];
        // 5.设置选中状态的颜色
        [self setTitleColor:[UIColor colorWithHexString:@"0dc4cd"] forState:UIControlStateSelected];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 3;
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * 0.6;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = self.height * 0.6;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    // 2.设置按钮默认状态的图片
    [self setImage:item.image forState:UIControlStateNormal];
    // 3.设置按钮选中状态的图片
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    // 4.设置按钮的标题
    [self setTitle:item.title forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
