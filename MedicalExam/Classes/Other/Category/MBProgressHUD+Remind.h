//
//  MBProgressHUD+Remind.h
//  DoctorPlatForm
//
//  Created by silent on 16/3/21.
//  Copyright © 2016年 songzm. All rights reserved.
//  一个短暂显示的提示view

#import "MBProgressHUD.h"

@interface MBProgressHUD (Remind)

+ (void)showSuccessWithMoment:(NSString *)message;

+ (void)showErrorWithMoment:(NSString *)message;

@end
