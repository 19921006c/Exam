//
//  YimaiExaminationTableViewQuestionAnalysisCell.h
//  DoctorPlatForm
//
//  Created by J on 16/5/11.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTCoreText.h>
@class YimaiExaminationQuestionFrameModel;
@interface YimaiExaminationTableViewQuestionAnalysisCell : UITableViewCell<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) YimaiExaminationQuestionFrameModel *frameModel;
@property (weak, nonatomic) IBOutlet DTAttributedTextView *question_analysisLabelView;

@end
