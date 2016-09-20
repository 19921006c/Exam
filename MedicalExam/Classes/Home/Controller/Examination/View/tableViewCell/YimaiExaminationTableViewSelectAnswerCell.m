//
//  YimaiExaminationTableViewSelectAnswerCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//
#define SaveUnfinishExamDataNotification @"SaveUnfinishExamDataNotification"

#import "YimaiExaminationTableViewSelectAnswerCell.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "YimaiExaminationTableViewCell.h"
#import "YimaiExaminationAnswerFrameModel.h"
#import "YimaiUserAnswerModel.h"
@interface YimaiExaminationTableViewSelectAnswerCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YimaiExaminationTableViewSelectAnswerCell

static NSString *const identifier = @"YimaiExaminationTableViewSelectAnswerCell";
static NSString *const cellIdentifier = @"YimaiExaminationTableViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    YimaiExaminationTableViewSelectAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tableView.delegate = cell;
        cell.tableView.dataSource = cell;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questionModel.select_answer_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationTableViewCell *cell = [YimaiExaminationTableViewCell cellWithTabelView:tableView];
    cell.select_answer_model = _questionModel.select_answer_array[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
    if (indexPath.row %2 == 1) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    }
    
    //选择完成后走这里
    if (_userAnswerModel.isFinish) {
        //判断是否选择完成，并且显示答案
        YimaiExaminationAnswerModel *answerModel = _questionModel.select_answer_array[indexPath.row];
        if (answerModel.is_Correct) {//显示正确答案
            cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_1"];
        }else{
            if ([answerModel.index isEqualToString: _userAnswerModel.indexArray[0]]) {//当前展示的错误答案与用户选择的错误答案一致，则显示为❌
                cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_0"];
            }else{
                cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
            }
            
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YimaiExaminationAnswerFrameModel *frameModel = [[YimaiExaminationAnswerFrameModel alloc]init];
    frameModel.answerModel = _questionModel.select_answer_array[indexPath.row];
    
    return frameModel.answerCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_userAnswerModel.isFinish) {//如果已经答完，则return
        return;
    }
    _userAnswerModel.isFinish = YES;
    
    if (_userAnswerModel.indexArray == nil) {
        _userAnswerModel.indexArray = [NSMutableArray array];
    }
    
    YimaiExaminationAnswerModel *answerModel = _questionModel.select_answer_array[indexPath.row];
    
    if (answerModel.is_Correct) {
        _userAnswerModel.state = StateTrue;
        _userAnswerModel.score = _questionModel.question_score;
    }else{
        _userAnswerModel.state = StateFalse;
        _userAnswerModel.score = @"0";
    }
    //记录答案
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.row];
    [_userAnswerModel.indexArray addObject:index];
    
    //更新父tableview 数据
    if ([self.delegate respondsToSelector:@selector(didSelectedAnswerCell)]) {
        [self.delegate didSelectedAnswerCell];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SaveUnfinishExamDataNotification object:nil];
}

- (NSString *)answerWifthIndex:(NSInteger)index
{
    if (index == 0) {
        return @"A";
    }else if (index == 1){
        return @"B";
    }else if (index == 2){
        return @"C";
    }else if (index == 3){
        return @"D";
    }else if (index == 4){
        return @"E";
    }else{
        return @"F";
    }
}
@end
