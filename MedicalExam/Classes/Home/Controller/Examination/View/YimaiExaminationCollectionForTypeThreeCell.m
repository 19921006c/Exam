//
//  YimaiExaminationCollectionForTypeThreeCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationCollectionForTypeThreeCell.h"
#import "YimaiExaminationTableViewDescriptionCell.h"
#import "YimaiExaminationTableViewContentCell.h"
#import "YimaiExaminationQuestionFrameModel.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "YimaiExaminationTableViewSelectAnswerCell.h"
#import "YimaiExaminationTableViewQuestionAnalysisCell.h"
#import "YimaiUserAnswerModel.h"
@interface YimaiExaminationCollectionForTypeThreeCell()<UITableViewDataSource,UITableViewDelegate,YimaiExaminationTableViewSelectAnswerCellDelegate>


@property (weak, nonatomic)UITableView *tableView;

@end

@implementation YimaiExaminationCollectionForTypeThreeCell

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
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        YimaiExaminationTableViewDescriptionCell *cell = [YimaiExaminationTableViewDescriptionCell cellWithTableView:tableView];
        
        cell.questionModel = _questionModel;
        return cell;
    } else if (indexPath.row == 1){
        YimaiExaminationTableViewSelectAnswerCell *cell = [YimaiExaminationTableViewSelectAnswerCell cellWithTableView:tableView];
        cell.questionModel = _questionModel;
        cell.userAnswerModel = _userAnswerModel;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
        YimaiExaminationTableViewContentCell *cell = [YimaiExaminationTableViewContentCell cellWithTabelView:tableView];
        cell.questionModel = _questionModel;
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
        return frameModel.answerTableViewHeight;
    }else if(indexPath.row == 2){
        return frameModel.contentCellHeight;
    }else if(indexPath.row == 3){
        return frameModel.questionAnalysisCellHeight;
    }
    return 100;
}
- (void)setUserAnswerModel:(YimaiUserAnswerModel *)userAnswerModel
{
    _userAnswerModel = userAnswerModel;
    
    [self.tableView reloadData];
}

//点击答案后回调代理方法
- (void)didSelectedAnswerCell
{
    [self.tableView reloadData];
}

@end
