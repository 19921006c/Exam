//
//  AppDelegate.m
//  MedicalExam
//
//  Created by J on 16/9/14.
//  Copyright © 2016年 J. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNavigationController.h"
#import "MedicineExaminationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置窗口颜色
    window.backgroundColor = [UIColor whiteColor];
    //设置root view controller
    window.rootViewController = [[MainNavigationController alloc] initWithRootViewController:[[MedicineExaminationController alloc]init]];
    //显示窗口
    [window makeKeyAndVisible];
    
    self.window = window;
    
    return YES;
}

@end
