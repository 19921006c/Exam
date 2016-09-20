//
//  YimaiExaminationTableViewSelectAnswerCell.h
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YimaiExaminationTableViewSelectAnswerCellDelegate <NSObject>

@optional

- (void)didSelectedAnswerCell;

@end
@class YimaiExaminationQuestionModel;
@class YimaiUserAnswerModel;
@interface YimaiExaminationTableViewSelectAnswerCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) YimaiExaminationQuestionModel *questionModel;
@property (nonatomic, strong) YimaiUserAnswerModel *userAnswerModel;
@property (nonatomic, assign) id<YimaiExaminationTableViewSelectAnswerCellDelegate> delegate;

@end
