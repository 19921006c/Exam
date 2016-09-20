//
//  YimaiExaminationCollectionForTypeTwoCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationCollectionForTypeTwoCell.h"
#import "YimaiExaminationTableViewDescriptionCell.h"
#import "YimaiExaminationTableViewCommonContentCell.h"
#import "YimaiExaminationTableViewContentCell.h"
#import "YimaiExaminationQuestionFrameModel.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationTableViewSelectAnswerCell.h"
#import "YimaiExaminationTableViewQuestionAnalysisCell.h"
#import "YimaiUserAnswerModel.h"
@interface YimaiExaminationCollectionForTypeTwoCell ()<UITableViewDataSource,UITableViewDelegate,YimaiExaminationTableViewSelectAnswerCellDelegate>

@property (weak, nonatomic)UITableView *tableView;

@end
@implementation YimaiExaminationCollectionForTypeTwoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.contentView.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
        [self.contentView addSubview:tableView];
        
        self.tableView = tableView;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.contentView.bounds;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_userAnswerModel.isFinish) {
        return 5;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        YimaiExaminationTableViewDescriptionCell *cell = [YimaiExaminationTableViewDescriptionCell cellWithTableView:tableView];
        cell.questionModel = _questionModel;
        return cell;
    }else if (indexPath.row == 1){
        YimaiExaminationTableViewCommonContentCell *cell = [YimaiExaminationTableViewCommonContentCell cellWithTabelView:tableView];
        
        cell.questionModel = _questionModel;
        return cell;
    }else if (indexPath.row == 2){
        YimaiExaminationTableViewContentCell *cell = [YimaiExaminationTableViewContentCell cellWithTabelView:tableView];
        cell.questionModel = _questionModel;
        
        return cell;
    }else if (indexPath.row == 3){
        YimaiExaminationTableViewSelectAnswerCell *cell = [YimaiExaminationTableViewSelectAnswerCell cellWithTableView:tableView];
        cell.questionModel = _questionModel;
        cell.userAnswerModel = _userAnswerModel;
        cell.delegate = self;
        return cell;
    }else{
        YimaiExaminationTableViewQuestionAnalysisCell *cell = [YimaiExaminationTableViewQuestionAnalysisCell cellWithTableView:tableView];
        YimaiExaminationQuestionFrameModel *frameModel = [[YimaiExaminationQuestionFrameModel alloc]init];
        frameModel.questionModel = _questionModel;
        cell.frameModel = frameModel;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationQuestionFrameModel *frameModel = [[YimaiExaminationQuestionFrameModel alloc]init];
    frameModel.questionModel = _questionModel;
    if (indexPath.row == 0) {
        return frameModel.descriptionCellHeight;
    }else if (indexPath.row == 1) {
        return frameModel.commonContentCellHeight;
    }else if(indexPath.row == 2){
        return frameModel.contentCellHeight;
    }else if(indexPath.row == 3){
        return frameModel.answerTableViewHeight;
    }else if(indexPath.row == 4){
        return frameModel.questionAnalysisCellHeight;
    }
    return 100;
}

- (void)setUserAnswerModel:(YimaiUserAnswerModel *)userAnswerModel
{
    _userAnswerModel = userAnswerModel;
    
    [self.tableView reloadData];
}
- (void)didSelectedAnswerCell
{
    [self.tableView reloadData];
}

@end
