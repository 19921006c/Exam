//
//  YimaiExaminationHttpTool.h
//  DoctorPlatForm
//
//  Created by J on 16/5/9.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YimaiMedicalExaminationResultModel;
@class YimaiExaminationListResultModel;
@class YimaiExaminationResultModel;
@class YimaiFinishExamRecordResultModel;
@class YimaiFinishExamRecordParamModel;
@class YimaiExaminationParamModel;
@class YimaiExaminationWrongInfoResultModel;
@class YimaiFinishExaminationResultModel;
@class YimaiFinishExaminationParamModel;
@class YimaiFinishExaminationDeleteQuestionResultModel;
@interface YimaiExaminationHttpTool : NSObject
/**
 *  试卷分类
 */
+ (void)MedicalExaminationWithSuccess:(void(^)(YimaiMedicalExaminationResultModel *resutlModel))success failure:(void(^)(NSError *error))failure;
/**
 *  试卷列表
 */
+ (void)ExaminationListWithClassid:(NSString *)classid success:(void(^)(YimaiExaminationListResultModel *resutlModel))success failure:(void(^)(NSError *error))failure;
/**
 *  试题内容
 */
+ (void)ExaminationWithPaperid:(YimaiExaminationParamModel *)param success:(void(^)(YimaiExaminationResultModel *resultModel))success failure:(void(^)(NSError *error))failure;

@end
