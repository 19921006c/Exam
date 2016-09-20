//
//  YimaiExaminationCollectionForTypeOneCell.h
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YimaiExaminationQuestionModel;
@class YimaiUserAnswerModel;
/**
 *  typeOne: 普通题型展示tableview cell 顺序1345
 */
@interface YimaiExaminationCollectionForTypeOneCell : UICollectionViewCell

@property (nonatomic, strong)YimaiExaminationQuestionModel *questionModel;
@property (nonatomic, strong)YimaiUserAnswerModel *userAnswerModel;
@end
