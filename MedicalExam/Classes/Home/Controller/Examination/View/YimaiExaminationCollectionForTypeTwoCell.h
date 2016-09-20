//
//  YimaiExaminationCollectionForTypeTwoCell.h
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YimaiExaminationQuestionModel;
@class YimaiUserAnswerModel;
@interface YimaiExaminationCollectionForTypeTwoCell : UICollectionViewCell

@property (nonatomic, strong)YimaiExaminationQuestionModel *questionModel;
@property (nonatomic, strong)YimaiUserAnswerModel *userAnswerModel;
@end
