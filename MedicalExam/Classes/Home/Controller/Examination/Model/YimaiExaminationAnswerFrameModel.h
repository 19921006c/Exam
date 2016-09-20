//
//  YimaiExaminationAnswerFrameModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YimaiExaminationAnswerModel;

@interface YimaiExaminationAnswerFrameModel : NSObject

@property (nonatomic, strong) YimaiExaminationAnswerModel *answerModel;

@property (nonatomic, assign) CGFloat answerCellHeight;
@end
