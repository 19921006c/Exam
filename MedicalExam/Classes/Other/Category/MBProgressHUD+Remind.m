//
//  MBProgressHUD+Remind.m
//  DoctorPlatForm
//
//  Created by silent on 16/3/21.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "MBProgressHUD+Remind.h"

@implementation MBProgressHUD (Remind)

+ (void)showSuccessWithMoment:(NSString *)message
{
    [MBProgressHUD showSuccess:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTipTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

+ (void)showErrorWithMoment:(NSString *)message
{
    [MBProgressHUD showSuccess:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTipTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}
@end
