//
//  DoctorIdenTool.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-5-26.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface DoctorIdenTool : NSObject


+ (int)backIden;
+ (int)doctorOrStudent;
+ (void)setupCookies;
+ (NSHTTPCookie *)cookie;
//是否完善信息
+ (BOOL)isCompleteInfo;
@end
