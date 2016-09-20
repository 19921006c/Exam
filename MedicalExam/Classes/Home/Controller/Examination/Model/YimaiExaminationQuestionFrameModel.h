//
//  YimaiExaminationQuestionFrameModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YimaiExaminationQuestionModel;
@interface YimaiExaminationQuestionFrameModel : NSObject

/**
 *  试题模型
 */
@property (nonatomic, strong) YimaiExaminationQuestionModel *questionModel;

@property (nonatomic, assign) CGFloat descriptionCellHeight;
/**
 *  公用题干cell高度
 */
@property (nonatomic, assign) CGFloat commonContentCellHeight;

/**
 *  追加题干cell高度
 */
@property (nonatomic, assign) CGFloat tipCellHeight;

/**
 *  问题题干cell高度
 */
@property (nonatomic, assign) CGFloat contentCellHeight;

/**
 *  答案解析cell高度
 */
@property (nonatomic, assign) CGFloat questionAnalysisCellHeight;

/**
 *  解析文字高度
 */
@property (nonatomic, assign) CGFloat analysisHeight;

/**
 *  选项总体高度
 */
@property (nonatomic, assign) CGFloat answerTableViewHeight;

@end
