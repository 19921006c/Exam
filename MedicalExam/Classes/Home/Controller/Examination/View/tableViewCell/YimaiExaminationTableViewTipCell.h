//
//  YimaiExaminationTableViewTipCell.h
//  DoctorPlatForm
//
//  Created by J on 16/5/10.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTCoreText.h>

@class YimaiExaminationQuestionModel;
@interface YimaiExaminationTableViewTipCell : UITableViewCell<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, strong) YimaiExaminationQuestionModel *questionModel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet DTAttributedTextView *tipView;
@end
