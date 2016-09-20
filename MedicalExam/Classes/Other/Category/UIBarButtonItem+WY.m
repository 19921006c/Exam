//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 . All rights reserved.
//
#define kContextFont [UIFont systemFontOfSize:16]
#import "UIBarButtonItem+WY.h"
#import "NSString+Extension.h"
#import "BadgeValueButton.h"
@implementation UIBarButtonItem (WY)

+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action withNew:(BOOL)isSignIn{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL SignIn = [userDefault boolForKey:kSignIn];
    if (SignIn) {
        BadgeValueButton *btns = [[BadgeValueButton alloc] init];
        btns.badgeValue = @"";
        [btns badgeValueWithView:btn ControllerName:controllerNameSignIn];
//        btns.width = 3;
//        btns.height = 3;
        btns.y = 0;
        btns.x = 20;
//        [btn addSubview:btns];
    }
    // 设置默认状态图片
    [btn setBackgroundImage:[UIImage imageWithName:norImageName] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setBackgroundImage:[UIImage imageWithName:higImageName] forState:UIControlStateHighlighted];
    // 设置frame
    btn.size = btn.currentBackgroundImage.size;
    // 添加监听事件
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    // 返回item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置默认状态图片
    [btn setBackgroundImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setBackgroundImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    // 设置frame
    btn.size = btn.currentBackgroundImage.size;
    // 添加监听事件
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    // 返回item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
+ (instancetype)itemWithDrection:(ButtonDrection)dection NormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor targe:(id)targe action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
 
    [btn setTitle:normalTitle forState:UIControlStateNormal];
//    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:kContextFont];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
//    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    if (dection == ButtonDrectionRight) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    if (dection == ButtonDrectionLeft) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    btn.frame = CGRectMake(0, 0, 70, 44);
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
