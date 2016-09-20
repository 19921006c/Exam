//
//  BadgeValueButton.m
//  DoctorPlatForm
//
//  Created by weiyi on 15/6/13.
//  Copyright (c) 2015年 songzm. All rights reserved.
//
#define kValueFont [UIFont systemFontOfSize:self.font]

#import "BadgeValueButton.h"
#import "WYTabBarButton.h"
#import "WYTabBar.h"
#import "NSString+Extension.h"

@implementation BadgeValueButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.font = 11;
        self.titleLabel.font = kValueFont;
        [self addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if (_badgeValue.length == 0) {
        [self setBackgroundImage:[UIImage imageNamed:@"no_badge_btn"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge_btn"] forState:UIControlStateNormal];
    }
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGSize contentSize = CGSizeMake(kScreenWidth, 999);
        CGRect contentRect = [NSString heightForString:badgeValue Size:contentSize Font:kValueFont];
        if (self.font == 10) { // 医圈
            if (badgeValue.length == 1) {
                self.width = contentRect.size.width + 9;
                self.height = contentRect.size.height + 3;
                self.layer.cornerRadius = 8;
                self.layer.masksToBounds = YES;
            }else if(badgeValue.length == 2){
                self.width = contentRect.size.width + 10;
                self.height = contentRect.size.height + 3;
                self.layer.cornerRadius = 8;
                self.layer.masksToBounds = YES;
            }else if(badgeValue.length == 3){
                self.width = contentRect.size.width + 10;
                self.height = contentRect.size.height + 3;
                self.layer.cornerRadius = 8;
                self.layer.masksToBounds = YES;
            }else if(badgeValue.length == 0){
                self.hidden = YES;
            }
        }else{ // tabbar
            if (badgeValue.length == 1) {
                self.width = contentRect.size.width + 11;
                self.height = contentRect.size.height + 4;
                self.layer.cornerRadius = 9;
                self.layer.masksToBounds = YES;
            }else if(badgeValue.length == 2){
                self.width = contentRect.size.width + 11;
                self.height = contentRect.size.height + 2;
                self.layer.cornerRadius = 8;
                self.layer.masksToBounds = YES;
            }else if(badgeValue.length == 3){
                self.width = contentRect.size.width + 12;
                self.height = contentRect.size.height + 4;
                self.layer.cornerRadius = 9;
                self.layer.masksToBounds = YES;

            }else{
                // 设置frame
                self.height = self.currentBackgroundImage.size.height + 3;
                self.width = self.currentBackgroundImage.size.width + 3;
            }
        }
    } else {
        self.hidden = YES;
    }
}
- (void)badgeValueWithView:(UIView *)titleView ControllerName:(ControllerName)ControllerName{
    // 实名
    CGFloat locationX = titleView.width * .5 - self.width - 2;
    CGFloat locationY = 1;
    
//    匿名
    CGFloat locationX1 = titleView.width - self.width - 2;
    CGFloat locationY1 = 1;
    if(ControllerName == ControllerNameRealName){
        if (_badgeValue.length != 0) {
                self.x = locationX;
                self.y = locationY;
        }
    }else if(ControllerName == controllerNameNoneName){
        if(_badgeValue.length != 0) {
            self.x = locationX1;
            self.y = locationY1;
        }
    }else if(ControllerName == controllerNameSignIn){
        self.x = 33;
        self.y = 7;
    }
    [titleView addSubview:self];

}

- (void)badgeValueWithViewController:(UIViewController *)vc ControllerName:(ControllerName)ControllerName{
    // badgeValue有值
//    CGFloat locationX = kScreenWidth / 4 * .55;
//    CGFloat locationY = 1;
//
//    //badgeValue没值
//    CGFloat locationX1 = kScreenWidth / 4 * .60;
//    CGFloat locationY1 = 5;
//
//    if (ControllerName == ControllerNameSevice) {
//        WYTabBarController *tabbarVc = (WYTabBarController *)vc.tabBarController;
//        for (UIView *view in tabbarVc.customTabBar.subviews) {
//            if ([view isKindOfClass:[WYTabBarButton class]]) {
//                WYTabBarButton *btn = (WYTabBarButton *)view;
//                if (btn.tag == ControllerNameSevice) {
//                    if (_badgeValue.length == 0) {
//                        self.x = locationX1;
//                        self.y = locationY1;
//                    }else{
//                        self.x = locationX;
//                        self.y = locationY;
//                    }
//                    [btn addSubview:self];
//                }
//            }
//        }
//    }
//    if (ControllerName == ControllerNameMessage) {
//        WYLog(@"%@", [vc class]);
//        WYTabBarController *tabbarVc = (WYTabBarController *)vc.tabBarController;
//        for (UIView *view in tabbarVc.customTabBar.subviews) {
//            if ([view isKindOfClass:[WYTabBarButton class]]) {
//                WYTabBarButton *btn = (WYTabBarButton *)view;
//                if (btn.tag == ControllerNameMessage) {
//                    if (_badgeValue.length == 0) {
//                        self.x = locationX1;
//                        self.y = locationY1;
//                    }else{
//                        self.x = locationX;
//                        self.y = locationY;
//                    }
//
//                    [btn addSubview:self];
//                }
//            }
//        }
//    }else if(ControllerName == ControllerNameProfile){
//        WYTabBarController *tabbarVc = (WYTabBarController *)vc.tabBarController;
//        for (UIView *view in tabbarVc.customTabBar.subviews) {
//            if ([view isKindOfClass:[WYTabBarButton class]]) {
//                WYTabBarButton *btn = (WYTabBarButton *)view;
//                WYLog(@"%@", btn);
//                if (btn.tag == ControllerNameProfile) {
//                    if (_badgeValue.length == 0) {
//                    self.x = locationX1;
//                    self.y = locationY1;
//                }else{
//                    self.x = locationX;
//                    self.y = locationY;
//                }
//
//                    [btn addSubview:self];
//                }
//            }
//        }
//    }else if(ControllerName == ControllerNameMine){
//        WYTabBarController *tabbarVc = (WYTabBarController *)vc.tabBarController;
//        for (UIView *view in tabbarVc.customTabBar.subviews) {
//            if ([view isKindOfClass:[WYTabBarButton class]]) {
//                WYTabBarButton *btn = (WYTabBarButton *)view;
//                WYLog(@"%@", btn);
//                if (btn.tag == ControllerNameMine) {
//                    if (_badgeValue.length == 0) {
//                    self.x = locationX1;
//                    self.y = locationY1;
//                }else{
//                    self.x = locationX;
//                    self.y = locationY;
//                }
//                    
//                    [btn addSubview:self];
//                }
//            }
//        }
//    }
}
- (void)removeSelf:(UIButton *)btn{
//    [btn removeFromSuperview];
}
@end
