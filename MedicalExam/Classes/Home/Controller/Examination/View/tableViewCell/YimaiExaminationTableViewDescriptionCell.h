//
//  YimaiExaminationTableViewDescriptionCell.h
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YimaiExaminationQuestionModel;
@interface YimaiExaminationTableViewDescriptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)YimaiExaminationQuestionModel *questionModel;
@end
