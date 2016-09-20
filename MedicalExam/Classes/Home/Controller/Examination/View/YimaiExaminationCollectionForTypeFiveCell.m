//
//  YimaiExaminationCollectionForTypeFiveCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//
#define SaveUnfinishExamDataNotification @"SaveUnfinishExamDataNotification"

#import "YimaiExaminationCollectionForTypeFiveCell.h"
#import "YimaiExaminationTableViewDescriptionCell.h"
#import "YimaiExaminationTableViewCommonContentCell.h"
#import "YimaiExaminationTableViewTipCell.h"
#import "YimaiExaminationTableViewContentCell.h"
#import "YimaiExaminationQuestionFrameModel.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell.h"
#import "YimaiExaminationTableViewSubmitAnswerCell.h"
#import "YimaiExaminationTableViewQuestionAnalysisCell.h"
#import "YimaiUserAnswerModel.h"
#import "NSString+Character.h"
@interface YimaiExaminationCollectionForTypeFiveCell()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic)UITableView *tableView;

@end

@implementation YimaiExaminationCollectionForTypeFiveCell

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
    return 6;
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
        YimaiExaminationTableViewTipCell *cell = [YimaiExaminationTableViewTipCell cellWithTabelView:tableView];
        cell.questionModel = _questionModel;
        return cell;
    }else if (indexPath.row == 3){
        YimaiExaminationTableViewContentCell *cell = [YimaiExaminationTableViewContentCell cellWithTabelView:tableView];
        cell.questionModel = _questionModel;
        
        return cell;
    }else if (indexPath.row == 4){
        YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell *cell = [YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell cellWithTableView:tableView];
        cell.questionModel = _questionModel;
        cell.userAnswerModel = _userAnswerModel;
        return cell;
    }else{
        if (_userAnswerModel.isFinish) {
            //选择了现实解析
            YimaiExaminationTableViewQuestionAnalysisCell *cell = [YimaiExaminationTableViewQuestionAnalysisCell cellWithTableView:tableView];
            YimaiExaminationQuestionFrameModel *frameModel = [[YimaiExaminationQuestionFrameModel alloc]init];
            frameModel.questionModel = _questionModel;
            cell.frameModel = frameModel;
            return cell;
        }else{
            YimaiExaminationTableViewSubmitAnswerCell *cell = [YimaiExaminationTableViewSubmitAnswerCell cellWithTableView:tableView];
            
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[YimaiExaminationTableViewSubmitAnswerCell class]]) {
        
        //没有选择任何答案则，return
        if (_userAnswerModel.indexArray.count == 0) {
            return;
        }
        //设置成已完成
        _userAnswerModel.isFinish = YES;
        //        _questionModel.is_finish = YES;
        //        //刷新tableview
        [tableView reloadData];
        //比较答案是否正确
        //正确答案
        NSMutableString *tmpCorrectStr = [NSMutableString stringWithFormat:@"%@",_questionModel.correct_answer];
        //用户选择的答案
        NSMutableString *tmpFinishStr = [[NSMutableString alloc]init];
        for (NSString *str in _userAnswerModel.indexArray) {
            NSString *tmpStr = [NSString characterWithIndex:[str integerValue]];
            
            [tmpFinishStr insertString:tmpStr atIndex:tmpFinishStr.length];
        }
        
        
        NSInteger correctCount = (tmpCorrectStr.length + 1) / 2;
        int finishCorrectCount = 0;
        
        if (correctCount == tmpFinishStr.length) {//答案数量一样
            for (int i = 0; i < tmpFinishStr.length; i ++) {
                NSRange range = NSMakeRange(i, 1);
                //遍历每一个用户的答案
                NSString *tmpStr = [tmpFinishStr substringWithRange:range];
                if ([tmpCorrectStr rangeOfString:tmpStr].location == NSNotFound) {//不包含
                    
                }else{//包含
                    finishCorrectCount += 1;
                }
            }
            
            if (finishCorrectCount == correctCount) {//正确
                _userAnswerModel.state = StateTrue;
                _userAnswerModel.score = _questionModel.question_score;
            }else{//错误
                _userAnswerModel.state = StateFalse;
                _userAnswerModel.score = [NSString stringWithFormat:@"%ld",-[_questionModel.question_score integerValue]];
            }
        }else{//答案个数不一致，错误
            _userAnswerModel.state = StateFalse;
            _userAnswerModel.score = [NSString stringWithFormat:@"%ld",-[_questionModel.question_score integerValue]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:SaveUnfinishExamDataNotification object:nil];
    }
}

- (NSString *)answerStringWithString:(NSString *)str
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *tmpStr = [str substringWithRange:range];
        
        [array addObject:tmpStr];
    }
    
    NSString *string = [array componentsJoinedByString:@"|"];
    
    return string;
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
        return frameModel.tipCellHeight;
    }else if(indexPath.row == 3){
        return frameModel.contentCellHeight;
    }else if(indexPath.row == 4){
        return frameModel.answerTableViewHeight;
    }else if(indexPath.row == 5){
        if (_userAnswerModel.isFinish) {
            YimaiExaminationQuestionFrameModel *frameModel = [[YimaiExaminationQuestionFrameModel alloc]init];
            frameModel.questionModel = _questionModel;
            return frameModel.questionAnalysisCellHeight;
        }else{
            return 60;
        }
    }
    return 100;
}

- (void)setUserAnswerModel:(YimaiUserAnswerModel *)userAnswerModel
{
    _userAnswerModel = userAnswerModel;
    
    [self.tableView reloadData];
}


@end
