//
//  ProfileModel.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/4/17.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
// 医生信息
@class XiaoZhan;
@interface  DoctorInfo : NSObject<NSCoding>

//匿名身份
@property (nonatomic, copy) NSString *anonymous;


@property (nonatomic, copy) NSString *hosp_level;
@property (nonatomic, copy) NSString *hospital;
//
@property (nonatomic, strong) NSNumber *isdoctor;
//
@property (nonatomic, copy) NSString *isjob;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *approveid;
@property (nonatomic, strong) NSNumber *cored;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *medal;
//用户id
@property (nonatomic, copy) NSString *pid;
//手机号码
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *unreplySubject;
@property (nonatomic, copy) NSString *mobileSubject;
//环信username
@property (nonatomic, copy) NSString *huanxin_username;
//环信密码
@property (nonatomic, copy) NSString *huanxin_password;
//
@property (nonatomic, copy) NSString *h_num;

@property (nonatomic, assign) CGFloat stat;

@property (nonatomic, copy) NSString *points;

@property (nonatomic, copy) NSString *subjectName;

@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSDictionary *xiaozhan;
// 取出UserInfo
- (instancetype)initDoctorInfo;
+ (instancetype)doctorInfo;
- (XiaoZhan *)XiaoZhan;
// 保存UserInfo
- (BOOL)saveDoctorInfoWithDict:(NSDictionary *)dict;
- (BOOL)saveUserInfo:(DoctorInfo *)userInfo;
// 删除UserInfo
+ (void)removeDoctorInfo;
@end

@interface XiaoZhan : NSObject

@property (nonatomic, copy) NSString *dati;
@property (nonatomic, copy) NSString *yuyue;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *iszj;
@property (nonatomic, copy) NSString *family;

@end

@interface PersonalInfo : NSObject<NSCoding>
/*
     "birth_day" = "--";
     city = 38;
     cityName = "\U4e1c\U57ce";
     hospital = "\U5317\U4eac\U5927\U5b66\U53e3\U8154\U533";
     job = "\U4e3b\U4efb\U533b\U5e08";
     "job_id" = "";
     phone = 15210240936;
     photo = "http://doctor.club.xywy.com/images/upload/paper/2015051511080472632.jpg";
     "profess_job" = "\U533b\U5e08";
     "profess_job_id" = "";
     profession = "";
     province = 1;
     provinceName = "\U5317\U4eac";
     realname = "\U8463\U6aa9";
     school = "\U4e2d\U56fd";
     sex = 1;
     special = "";
     subject = "\U7cbe\U795e\U79d1";
     subject2 = "\U5984\U60f3\U75c7";
     synopsis = "\U6d4b\U8bd5\Uff0c\U533b\U5e08\Uff0c\U6bd5\U4e1";
     "training_hospital" = "";
 */
@property (nonatomic, copy) NSString *birth_day;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *job_id;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *profess_job;
@property (nonatomic, copy) NSString *profess_job_id;
@property (nonatomic, copy) NSString *subject_id;
@property (nonatomic, copy) NSString *subject2_id;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *subject2;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *training_hospital;

//关注数
@property (strong, nonatomic) NSNumber *watchedCount;
//动态数
@property (strong, nonatomic) NSNumber *dynamiccount;

- (BOOL)savePersonalInfoWithDict:(NSDictionary *)dict;
- (BOOL)savePersonalInfo:(PersonalInfo *)personInfo;
+ (instancetype)personalInfo;
- (instancetype)initPersonalInfo;
+ (BOOL)removePersonInfo;
@end

@interface LogoutInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSData *iconData;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

// 取出UserInfo
- (instancetype)initLogoutInfo;
+ (instancetype)logoutInfo;

// 保存UserInfo
- (BOOL)saveLogoutInfoWithDict:(NSDictionary *)dict;
- (BOOL)saveLogoutInfo:(LogoutInfo *)logoutInfo;
@end




// 诊所信息
@interface  ClinicInfo : NSObject<NSCoding>
//答题
@property (nonatomic, strong) NSNumber *dati;
//预约
@property (nonatomic, strong) NSNumber *yuyue;
//电话医生
@property (nonatomic, strong) NSNumber *phone;
//家庭医生
@property (nonatomic, strong) NSNumber *family;
//是否专家
@property (nonatomic, strong) NSNumber *iszj;
// 取出UserInfo
- (instancetype)initClinicInfo;
+ (instancetype)clinicInfo;

// 保存UserInfo
- (BOOL)saveClinicInfoWithDict:(NSDictionary *)dict;
- (BOOL)saveClinicInfo:(ClinicInfo *)clinicInfo;
// 删除UserInfo
+ (void)removeClinicInfo;
@end


