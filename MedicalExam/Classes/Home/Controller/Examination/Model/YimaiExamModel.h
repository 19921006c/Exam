//
//  YimaiExamModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/26.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YimaiUserAnswerModel;
@class YimaiExaminationQuestionModel;
@interface YimaiExamModel : NSObject

@property (nonatomic, strong) YimaiUserAnswerModel *userModel;

@property (nonatomic, strong) YimaiExaminationQuestionModel *questionModel;

@end
