//
//  YimaiExaminationCollectionCell.h
//  DoctorPlatForm
//
//  Created by silent on 16/4/19.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YimaiExaminationQuestionModel;

@protocol YimaiExaminationCollectionCellDelegate <NSObject>

@optional

- (void)finishUpBtnClickAction;

@end

typedef void(^YimaiExaminationCollectionCellBlock)(void);

@interface YimaiExaminationCollectionCell : UICollectionViewCell

//@property (nonatomic, strong) YimaiExaminationFinishModel *finishModel;

@property (nonatomic, copy) YimaiExaminationCollectionCellBlock block;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign)id<YimaiExaminationCollectionCellDelegate> delegate;

/**
 *  单个问题所有数据model
 */
@property (nonatomic, strong) YimaiExaminationQuestionModel *questionModel;

@end
