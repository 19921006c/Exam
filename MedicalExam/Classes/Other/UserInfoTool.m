//
//  IWAccountTool.m
//  8期微博
//
//  Created by apple on 14-9-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UserInfoTool.h"

#define UserInfoFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"userInfo.arch"]



@implementation UserInfoTool

+ (BOOL)saveDoctorInfo:(DoctorInfo *)userInfo
{
    WYLog(@"%@", UserInfoFilePath);
    return [NSKeyedArchiver archiveRootObject:userInfo toFile:UserInfoFilePath];
}
+ (DoctorInfo *)doctorInfo
{
    // 1.读取账号模型
    DoctorInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoFilePath];
    WYLog(@"%@", UserInfoFilePath);
    return userInfo;
}

+(NSString *)getFilePathWithFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:fileName];
    
}
+(BOOL)deleteFilePath:(NSString *)fileName{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL flag = NO;
    if ([self isExitFileName:fileName]) {
        flag = [manager removeItemAtPath:fileName error:nil];
    }
    return flag;
}
+ (BOOL)isExitFileName:(NSString *)path{
    if ([path isEqualToString:UserInfoFilePath] || [path isEqualToString:PersonalInfoFilePath]) {
        return YES;
    }
    return NO;
}

@end

@implementation SaveImageTool

+ (BOOL)saveImage:(UIImage *)image withFileName:(NSString *)fileName{
    NSString *filePath = [photoPath stringByAppendingPathComponent:fileName];
    WYLog(@"%@", filePath);
    return [NSKeyedArchiver archiveRootObject:image toFile:filePath ];
}
+ (UIImage *)filePathWithFileName:(NSString *)fileName{
    NSString *filePath = [photoPath stringByAppendingPathComponent:fileName];
    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return image;
}
@end
