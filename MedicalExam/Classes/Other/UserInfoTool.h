//
//  IWAccountTool.h
//  8期微博
//
//  Created by apple on 14-9-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DoctorInfo;
@interface UserInfoTool : NSObject
/**
 *  保存账号模型
 *
 *  @param account 账号模型
 *
 *  @return 时候保存成功
 */
+ (BOOL)saveDoctorInfo:(DoctorInfo *)userInfo;
/**
 *  读取账号模型
 *
 *  @return 账号模型
 */
+ (DoctorInfo *)doctorInfo;
// 删除归档保存文件
+(BOOL)deleteFilePath:(NSString *)fileName;
@end

//// 存图工具类
@interface SaveImageTool : NSObject
+ (BOOL)saveImage:(UIImage *)image withFileName:(NSString *)fileName;
+ (UIImage *)filePathWithFileName:(NSString *)fileName;
@end