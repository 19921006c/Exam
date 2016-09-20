//
//  DoctorIdenTool.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-5-26.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "DoctorIdenTool.h"
#import "RSA.h"
@implementation DoctorIdenTool
// 医生    20 开头
// 医学生  10 开头
+ (int)backIden
{   DoctorInfo *userInfo = [DoctorInfo doctorInfo];
    if (userInfo.pid.length != 0) {//  登陆
        if ([userInfo.isdoctor intValue] != 12 && [userInfo.isdoctor intValue] != 13 && [userInfo.isdoctor intValue] != 14) {//医生
            if ([userInfo.isjob intValue] == 1) {//普通医生
                return 20;
            }else if ([userInfo.isjob intValue] == 2 && [[userInfo  XiaoZhan].dati intValue] != -1){// 专家
                return 30;
            }else if ([userInfo.isjob intValue] == 2 && [[userInfo  XiaoZhan].dati intValue] == -1){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                if ([defaults boolForKey:[NSString stringWithFormat:@"%@%@", userInfo.pid, kChecking]]) { // 专家身份审核中。。。
                    return 50;
                }
                return 40; // 未认证专家
            }else{
                if ([userInfo.isdoctor intValue] == 0 && [userInfo.isjob intValue] == 0 && [userInfo.approveid intValue] == 0) {// 医生认证中
                    return 21;
                }else{//未认证
                    return 22;
                }
            }
        }else{// 医学生
            if([userInfo.isdoctor intValue] == 14){// 认证成功的医学生
                return 10;
            }else{
                if([userInfo.isdoctor intValue]== 13 && [userInfo.approveid intValue] == 0){//认证中的医学生
                    return 11;
                }else if([userInfo.isdoctor intValue] == 13 &&[userInfo.approveid intValue]== 1){//认证失败
                    return 12;
                }else{//未认证
                    return 13;
                }
            }
        }
    }else{//游客
        return 0;
    }
}
+ (int)doctorOrStudent{
    if ([self backIden] == 0) {
        // 游客
        return 0;
    }else if ([self backIden] == 20 || [self backIden] == 21 || [self backIden] == 22) {
        // 医生
        return 1;
    }else if ([self backIden] == 10 || [self backIden] == 11 || [self backIden] == 12 || [self backIden] == 13) {
        // 医学生
        return 2;
    }else if([self backIden] == 30){
        // 专家
        return 3;
    }else if([self backIden] == 50){
        // 专家认证中...
        return 5;
    }else if([self backIden] == 40){
        // 未认证专家
        return 4;
    }else{
        return -1;
    }
}



+ (void)setupCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSString *cookieString = [RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY];
    if (cookieString == nil) {
        return;
    }
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookieVersion : @0,
                                                                NSHTTPCookieName : AFHttpHeadKey,
                                                                NSHTTPCookieValue : cookieString,
                                                                NSHTTPCookieExpires: [NSDate distantFuture],
                                                                NSHTTPCookieDomain : @".xywy.com",
                                                                NSHTTPCookiePath : @"/"
                                                                }];
    [storage setCookie:cookie];
}

+ (NSHTTPCookie *)cookie
{
    NSString *cookieString = [RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookieVersion : @0,
                                                                NSHTTPCookieName : AFHttpHeadKey,
                                                                NSHTTPCookieValue : cookieString,
                                                                NSHTTPCookieExpires: [NSDate distantFuture],
                                                                NSHTTPCookieDomain : @".xywy.com",
                                                                NSHTTPCookiePath : @"/"
                                                                }];
    return cookie;
}

//是否完善信息
+ (BOOL)isCompleteInfo
{
    if ([self doctorOrStudent] == 2) {//医学生:姓名、专业、学校
        if ([PersonalInfo personalInfo].realname.length == 0 ||
            [PersonalInfo personalInfo].profession.length == 0 ||
            [PersonalInfo personalInfo].school.length == 0) {
            return NO;
        }
        return YES;
    }else{//医生
        if ([PersonalInfo personalInfo].realname.length == 0 ||
            [PersonalInfo personalInfo].job.length == 0 ||
            [PersonalInfo personalInfo].hospital.length == 0 ||
            [PersonalInfo personalInfo].subject2.length == 0) {//医生是：姓名、职称、医院、科室
            return NO;
        }
        return YES;
    }
}

@end
