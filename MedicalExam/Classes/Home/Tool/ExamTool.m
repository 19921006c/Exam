//
//  ExamTool.m
//  MedicalExam
//
//  Created by J on 16/9/18.
//  Copyright © 2016年 J. All rights reserved.
//

#import "ExamTool.h"
#import "CustomAFHTTPSessionManager.h"
#import "YimaiMedicalExaminationParamModel.h"
#import "DoctorIdenTool.h"
#import "YimaiMedicalExaminationResultModel.h"
@implementation ExamTool

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
    
    FLOG(@"param.keyvalues = %@", param.keyValues);
    [manager POST:@"index.interface.php" parameters:param.keyValues success:^(NSURLSessionDataTask *task, id responseObject) {
        FLOG(@"responseObject = %@", responseObject);
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

@end
