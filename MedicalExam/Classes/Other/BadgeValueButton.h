//
//  BadgeValueButton.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/6/13.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYTabBarController;
typedef enum {
    
    ControllerNameSevice = 0,   // 服务窗
    ControllerNameMessage = 1,  //  消息
    ControllerNameProfile = 2,  //  名片夹
    ControllerNameMine = 3,     // 我的
    ControllerNameRealName = 4, //  实名动态
    controllerNameNoneName = 5,  // 匿名动态
    controllerNameSignIn = 6,  //


} ControllerName;

@interface BadgeValueButton : UIButton
@property (nonatomic, assign) int font;
@property (nonatomic, copy) NSString *badgeValue;

- (void)badgeValueWithView:(UIView *)titleView ControllerName:(ControllerName)ControllerName;
- (void)badgeValueWithViewController:(UIViewController *)vc ControllerName:(ControllerName)ControllerName;
@end
