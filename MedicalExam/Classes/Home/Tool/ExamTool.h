//
//  ExamTool.h
//  MedicalExam
//
//  Created by J on 16/9/18.
//  Copyright © 2016年 J. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YimaiMedicalExaminationResultModel;
@interface ExamTool : NSObject

+ (void)MedicalExaminationWithSuccess:(void(^)(YimaiMedicalExaminationResultModel *resutlModel))success failure:(void(^)(NSError *error))failure;

@end
