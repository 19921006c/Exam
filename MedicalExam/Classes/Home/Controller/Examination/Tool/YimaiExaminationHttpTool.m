//
//  YimaiExaminationHttpTool.m
//  DoctorPlatForm
//
//  Created by J on 16/5/9.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationHttpTool.h"
#import "YimaiMedicalExaminationParamModel.h"
#import "YimaiMedicalExaminationResultModel.h"
#import "YimaiExaminationListResultModel.h"
#import "YimaiExaminationListClassModel.h"
#import "YimaiExaminationParamModel.h"
#import "DoctorIdenTool.h"
#import "YimaiExaminationResultModel.h"
#import "YimaiExaminationTool.h"
@implementation YimaiExaminationHttpTool

+ (void)MedicalExaminationWithSuccess:(void (^)(YimaiMedicalExaminationResultModel *))success failure:(void (^)(NSError *))failure
{
    CustomAFHTTPSessionManager *manager = [CustomAFHTTPSessionManager manager];
    
    YimaiMedicalExaminationParamModel *param = [[YimaiMedicalExaminationParamModel alloc]init];
    
    //获取时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", a];
    param.timestamp = timestamp;
    param.userId = kUserId;
    param.bind = param.userId;
    param.m = @"paperClass";
    param.a = @"medicine";
    
    //    param.c = @"paper";
    //    param.a = @"class";
    //    param.userid = [DoctorInfo doctorInfo].pid;
    //    param.level = @"2";
    //    param.classid = @"2";
    param.sign = [Md5 getMd5_32Bit_String:[NSString stringWithFormat:@"%@%@%@",param.timestamp,param.bind,MD5STRING]];
    
//    FLOG(@"param.keyvalues = %@", param.keyValues);
    [manager POST:@"index.interface.php" parameters:param.keyValues success:^(NSURLSessionDataTask *task, id responseObject) {
//        FLOG(@"responseObject = %@", responseObject);
        YimaiMedicalExaminationResultModel *resultModel = [YimaiMedicalExaminationResultModel objectWithKeyValues:responseObject];
        
        if ([resultModel.code isEqualToString:kSuccessCode]) {
            success(resultModel);
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:resultModel.msg};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[resultModel.code intValue] userInfo:userInfo];
            failure(error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        FLOG(@"error = %@", error);
        failure(error);
    }];
}
+ (void)ExaminationListWithClassid:(NSString *)classid success:(void (^)(YimaiExaminationListResultModel *))success failure:(void (^)(NSError *))failure
{
    CustomAFHTTPSessionManager *manager = [CustomAFHTTPSessionManager manager];
    
    YimaiMedicalExaminationParamModel *param = [[YimaiMedicalExaminationParamModel alloc]init];
    
    //获取时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", a];
    
    param.timestamp = timestamp;
    param.userId = kUserId;
    param.bind = param.userId;
    param.classId = classid;
    param.m = @"paperList";
    param.a = @"medicine";
    param.sign = [Md5 getMd5_32Bit_String:[NSString stringWithFormat:@"%@%@%@",param.timestamp,param.bind,MD5STRING]];
    
    //    param.c = @"paper";
    //    param.a = @"list";
    //    param.classid = classid;
    //    FLOG(@"params = %@", param.keyValues);
    
    [manager POST:@"index.interface.php" parameters:param.keyValues success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //        FLOG(@"responseObject = %@", responseObject);
        
        YimaiExaminationListResultModel *resultModel = [YimaiExaminationListResultModel objectWithKeyValues:responseObject];
        
        NSMutableArray *classArray = [NSMutableArray array];
        
        for (NSDictionary *classDic in responseObject[@"class"]) {
            YimaiExaminationListClassModel *classModel = [YimaiExaminationListClassModel objectWithKeyValues:classDic];
            
            [classArray addObject:classModel];
        }
        
        
        resultModel.classArray = classArray;
        
        
        
        //        FLOG(@"resultModel = %@", resultModel);
        
        if ([resultModel.code isEqualToString:kSuccessCode]) {
            success(resultModel);
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:resultModel.msg};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[resultModel.code intValue] userInfo:userInfo];
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
+ (void)ExaminationWithPaperid:(YimaiExaminationParamModel *)param success:(void (^)(YimaiExaminationResultModel *))success failure:(void (^)(NSError *))failure
{
    param.m = @"paperInfo";
    param.userId = kUserId;
    param.bind = param.userId;
    //获取时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", a];
    param.timestamp = timestamp;
    
    param.sign = [Md5 getMd5_32Bit_String:[NSString stringWithFormat:@"%@%@%@",param.timestamp,param.bind,MD5STRING]];
    CustomAFHTTPSessionManager *manager = [CustomAFHTTPSessionManager manager];
    
//    FLOG(@"params = %@", param.keyValues);
    
    [manager POST:@"index.interface.php" parameters:param.keyValues success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        FLOG(@"responseObject =2 %@", responseObject);
    
        YimaiExaminationResultModel *resultModel = [YimaiExaminationResultModel objectWithKeyValues:responseObject];
        
        if ([resultModel.code isEqualToString:kSuccessCode]) {
            
#pragma mark - 存数据到数据库
            [YimaiExaminationTool saveExam:responseObject];
            
            success(resultModel);
            
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:resultModel.msg};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[resultModel.code intValue] userInfo:userInfo];
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

@end