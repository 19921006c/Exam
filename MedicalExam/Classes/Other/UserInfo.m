//
//  ProfileModel.m
//  DoctorPlatForm
//
//  Created by weiyi on 15/4/17.
//  Copyright (c) 2015年 songzm. All rights reserved.
//
//#define UserInfoFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"userInfo.arch"]
#import "UserInfo.h"
#import "UserInfoTool.h"
@implementation DoctorInfo
+ (instancetype)doctorInfo{
    DoctorInfo *doctorInfo = [[self alloc] initDoctorInfo];
    if (!doctorInfo) {
        return [[self alloc] init];
    }
    return doctorInfo;
}
- (XiaoZhan *)XiaoZhan{
    return [XiaoZhan objectWithKeyValues:self.xiaozhan];
}
// 保存
- (BOOL)saveDoctorInfoWithDict:(NSDictionary *)dict{

    DoctorInfo *userInfo = [DoctorInfo objectWithKeyValues:dict];
   return [self saveUserInfo:userInfo];
}

- (BOOL)saveUserInfo:(DoctorInfo *)userInfo{
    return [NSKeyedArchiver archiveRootObject:userInfo toFile:UserInfoFilePath];
}
- (instancetype)initDoctorInfo{
    if (self = [super init]) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSMutableDictionary *dict = [defaults objectForKey:@"UserInfoDict"];
//        self = [DoctorInfo objectWithKeyValues:dict];
//        WYLog(@"%@", UserInfoFilePath);
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoFilePath];
    }
    return self;
}
+ (void)removeDoctorInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"pwd"];
    [defaults removeObjectForKey:@"phone"];
    [UserInfoTool deleteFilePath:UserInfoFilePath];
}



/**
 * 归档
 */
- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.anonymous forKey:@"anonymous"];
    [encoder encodeObject:self.hosp_level forKey:@"hosp_level"];
    [encoder encodeObject:self.hospital forKey:@"hospital"];
    [encoder encodeObject:self.isdoctor forKey:@"isdoctor"];
    [encoder encodeObject:self.isjob forKey:@"isjob"];
    [encoder encodeObject:self.job forKey:@"job"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.realname forKey:@"realname"];
    [encoder encodeObject:self.subject forKey:@"subject"];
    [encoder encodeObject:self.synopsis forKey:@"synopsis"];
    [encoder encodeObject:self.approveid forKey:@"approveid"];
    [encoder encodeObject:self.cored forKey:@"cored"];
    [encoder encodeObject:self.count forKey:@"count"];
    [encoder encodeObject:self.medal forKey:@"medal"];
    [encoder encodeObject:self.pid forKey:@"pid"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.unreplySubject forKey:@"unreplySubject"];
    [encoder encodeObject:self.huanxin_username forKey:@"huanxin_username"];
    [encoder encodeObject:self.huanxin_password forKey:@"huanxin_password"];
    [encoder encodeObject:self.h_num forKey:@"h_num"];
    [encoder encodeDouble:self.stat forKey:@"stat"];
    [encoder encodeObject:self.points forKey:@"points"];
    [encoder encodeObject:self.subjectName forKey:@"subjectName"];
    [encoder encodeObject:self.profession forKey:@"profession"];
    [encoder encodeObject:self.school forKey:@"school"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.xiaozhan forKey:@"xiaozhan"];

}

/**
 *  解档对象
 */
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.anonymous = [Decoder decodeObjectForKey:@"anonymous"];
        self.hosp_level = [Decoder decodeObjectForKey:@"hosp_level"];
        self.hospital = [Decoder decodeObjectForKey:@"hospital"];
        self.isdoctor = [Decoder decodeObjectForKey:@"isdoctor"];
        self.isjob = [Decoder decodeObjectForKey:@"isjob"];
        self.job = [Decoder decodeObjectForKey:@"job"];
        self.photo = [Decoder decodeObjectForKey:@"photo"];
        self.realname = [Decoder decodeObjectForKey:@"realname"];
        self.subject = [Decoder decodeObjectForKey:@"subject"];
        self.synopsis = [Decoder decodeObjectForKey:@"synopsis"];
        self.approveid = [Decoder decodeObjectForKey:@"approveid"];
        self.cored = [Decoder decodeObjectForKey:@"cored"];
        self.count = [Decoder decodeObjectForKey:@"count"];
        self.medal = [Decoder decodeObjectForKey:@"medal"];
        self.pid = [Decoder decodeObjectForKey:@"pid"];
        self.phone = [Decoder decodeObjectForKey:@"phone"];
        self.unreplySubject = [Decoder decodeObjectForKey:@"unreplySubject"];
        self.huanxin_username = [Decoder decodeObjectForKey:@"huanxin_username"];
        self.huanxin_password = [Decoder decodeObjectForKey:@"huanxin_password"];
        self.h_num = [Decoder decodeObjectForKey:@"h_num"];
        self.stat = [Decoder decodeDoubleForKey:@"stat"];
        self.points = [Decoder decodeObjectForKey:@"points"];
        self.subjectName = [Decoder decodeObjectForKey:@"subjectName"];
        self.school = [Decoder decodeObjectForKey:@"school"];
        self.profession = [Decoder decodeObjectForKey:@"profession"];
        self.username = [Decoder decodeObjectForKey:@"username"];
        self.xiaozhan = [Decoder decodeObjectForKey:@"xiaozhan"];
    }
    return self;
}


@end
@implementation XiaoZhan



@end
@implementation PersonalInfo

+ (instancetype)personalInfo{
    PersonalInfo *personInfo = [[self alloc] initPersonalInfo];
    if (!personInfo) {
        return [[self alloc] init];
    }
    return personInfo;
}

- (instancetype)initPersonalInfo{
    if (self = [super init]) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSDictionary *dict = [defaults objectForKey:@"personalInfo"];
//        self = [PersonalInfo objectWithKeyValues:dict];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:PersonalInfoFilePath];
    }
    return self;
}
- (BOOL)savePersonalInfoWithDict:(NSDictionary *)dict{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:dict forKey:@"personalInfo"];
//    [defaults synchronize];
    PersonalInfo *personalInfo = [PersonalInfo objectWithKeyValues:dict];
    return [self savePersonalInfo:personalInfo];
}

- (BOOL)savePersonalInfo:(PersonalInfo *)personInfo{
    return [NSKeyedArchiver archiveRootObject:personInfo toFile:PersonalInfoFilePath];
}
+ (BOOL)removePersonInfo{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"personalInfo"];
    return [UserInfoTool deleteFilePath:PersonalInfoFilePath];
}
/**
 * 归档
 */
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.birth_day forKey:@"birth_day"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.hospital forKey:@"hospital"];
    [encoder encodeObject:self.job forKey:@"job"];
    [encoder encodeObject:self.job_id forKey:@"job_id"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.profess_job forKey:@"profess_job"];
    [encoder encodeObject:self.profess_job_id forKey:@"profess_job_id"];
    [encoder encodeObject:self.subject_id forKey:@"subject_id"];
    [encoder encodeObject:self.subject2_id forKey:@"subject2_id"];
    [encoder encodeObject:self.profession forKey:@"profession"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.provinceName forKey:@"provinceName"];
    [encoder encodeObject:self.realname forKey:@"realname"];
    [encoder encodeObject:self.school forKey:@"school"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.special forKey:@"special"];
    [encoder encodeObject:self.subject forKey:@"subject"];
    [encoder encodeObject:self.subject2 forKey:@"subject2"];
    [encoder encodeObject:self.synopsis forKey:@"synopsis"];
    [encoder encodeObject:self.training_hospital forKey:@"training_hospital"];
    [encoder encodeObject:self.watchedCount forKey:@"watchedCount"];
    [encoder encodeObject:self.dynamiccount forKey:@"dynamiccount"];
}
/**
 *  解档对象
 */
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.birth_day = [Decoder decodeObjectForKey:@"birth_day"];
        self.city = [Decoder decodeObjectForKey:@"city"];
        self.cityName = [Decoder decodeObjectForKey:@"cityName"];
        self.hospital = [Decoder decodeObjectForKey:@"hospital"];
        self.job = [Decoder decodeObjectForKey:@"job"];
        self.job_id = [Decoder decodeObjectForKey:@"job_id"];
        self.phone = [Decoder decodeObjectForKey:@"phone"];
        self.photo = [Decoder decodeObjectForKey:@"photo"];
        self.profess_job = [Decoder decodeObjectForKey:@"profess_job"];
        self.profess_job_id = [Decoder decodeObjectForKey:@"profess_job_id"];
        self.subject_id = [Decoder decodeObjectForKey:@"subject_id"];
        self.subject2_id = [Decoder decodeObjectForKey:@"subject2_id"];
        self.profession = [Decoder decodeObjectForKey:@"profession"];
        self.province = [Decoder decodeObjectForKey:@"province"];
        self.provinceName = [Decoder decodeObjectForKey:@"provinceName"];
        self.realname = [Decoder decodeObjectForKey:@"realname"];
        self.school = [Decoder decodeObjectForKey:@"school"];
        self.sex = [Decoder decodeObjectForKey:@"sex"];
        self.special = [Decoder decodeObjectForKey:@"special"];
        self.subject = [Decoder decodeObjectForKey:@"subject"];
        self.subject2 = [Decoder decodeObjectForKey:@"subject2"];
        self.synopsis = [Decoder decodeObjectForKey:@"synopsis"];
        self.training_hospital = [Decoder decodeObjectForKey:@"training_hospital"];
        self.dynamiccount = [Decoder decodeObjectForKey:@"dynamiccount"];
        self.watchedCount = [Decoder decodeObjectForKey:@"watchedCount"];
    }
    return self;
}
@end


@implementation LogoutInfo

+ (instancetype)logoutInfo{
    LogoutInfo *logoutInfo = [[self alloc] initLogoutInfo];
    if (!logoutInfo) {
        return [[self alloc] init];
    }
    return logoutInfo;
}
// 保存
- (BOOL)saveLogoutInfoWithDict:(NSDictionary *)dict{
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    WYLog(@"%@", dict[@"isjob"]);
    //    [defaults setObject:dict forKey:@"UserInfoDict"];
    //    [defaults synchronize];
    LogoutInfo *logoutInfo = [LogoutInfo objectWithKeyValues:dict];
    return [self saveLogoutInfo:logoutInfo];
    //    return [NSKeyedArchiver archiveRootObject:self toFile:UserInfoFilePath];
}

- (BOOL)saveLogoutInfo:(LogoutInfo *)logoutInfo{
    
    return [NSKeyedArchiver archiveRootObject:logoutInfo toFile: LogoutInfoFilePath];
}
- (instancetype)initLogoutInfo{
    if (self = [super init]) {
        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        NSMutableDictionary *dict = [defaults objectForKey:@"UserInfoDict"];
        //        self = [DoctorInfo objectWithKeyValues:dict];
//        WYLog(@"%@", UserInfoFilePath);
        self = [NSKeyedUnarchiver unarchiveObjectWithFile: LogoutInfoFilePath];
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.iconData forKey:@"iconData"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.password forKey:@"password"];
}
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.iconData = [Decoder decodeObjectForKey:@"iconData"];
        self.phone = [Decoder decodeObjectForKey:@"phone"];
        self.password = [Decoder decodeObjectForKey:@"password"];
    }
    return self;
}
@end


/////诊所信息
@implementation ClinicInfo
+ (instancetype)clinicInfo{
    ClinicInfo *clinicInfo = [[self alloc] initClinicInfo];
    if (!clinicInfo) {
        return [[self alloc] init];
    }
    return clinicInfo;
}
// 保存
- (BOOL)saveClinicInfoWithDict:(NSDictionary *)dict{
    
    ClinicInfo *clinicInfo = [ClinicInfo objectWithKeyValues:dict];
    return [self saveClinicInfo:clinicInfo];
}

- (BOOL)saveClinicInfo:(ClinicInfo *)clinicInfo{
    return [NSKeyedArchiver archiveRootObject:clinicInfo toFile:ClinicInfoFilePath];
}
- (instancetype)initClinicInfo{
    if (self = [super init]) {
        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        NSMutableDictionary *dict = [defaults objectForKey:@"UserInfoDict"];
        //        self = [DoctorInfo objectWithKeyValues:dict];
        //        WYLog(@"%@", UserInfoFilePath);
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:ClinicInfoFilePath];
    }
    return self;
}
+ (void)removeClinicInfo{
    [UserInfoTool deleteFilePath:ClinicInfoFilePath];
}



/**
 * 归档
 */
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.dati forKey:@"dati"];
    [encoder encodeObject:self.yuyue forKey:@"yuyue"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.family forKey:@"family"];
    [encoder encodeObject:self.iszj forKey:@"iszj"];
}
/**
 *  解档对象
 */
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.dati = [Decoder decodeObjectForKey:@"dati"];
        self.yuyue = [Decoder decodeObjectForKey:@"yuyue"];
        self.phone = [Decoder decodeObjectForKey:@"phone"];
        self.family = [Decoder decodeObjectForKey:@"family"];
        self.iszj = [Decoder decodeObjectForKey:@"iszj"];
    }
    return self;
}


@end
