//
//  YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "YimaiExaminationTableViewCell.h"
#import "YimaiExaminationAnswerFrameModel.h"
#import "YimaiUserAnswerModel.h"
@interface YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell

static NSString *const identifier = @"YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell";
static NSString *const cellIdentifier = @"YimaiExaminationTableViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    YimaiExaminationTableViewSelectAnswerForMultipleChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tableView.delegate = cell;
        cell.tableView.dataSource = cell;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
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
        YimaiExaminationAnswerModel *answerModel = _questionModel.select_answer_array[indexPath.row];
        if (answerModel.is_Correct) {//显示正确答案
            cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_1"];
        }else{
            
            NSString *str = [_userAnswerModel.indexArray componentsJoinedByString:@""];
            
            if (str) {
                if ([str rangeOfString:answerModel.index].location == NSNotFound) {//选择答案中没有❌答案
                    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
                }else{//已经选择的答案中有错误答案
                    cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_0"];
                }
            }else{
                cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
            }
            
            
        }
    }else{//还未提交答案
        for (NSString *str in _userAnswerModel.indexArray) {
            NSInteger index = [str integerValue];
            if (indexPath.row == index) {//当前cell被勾选
                cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_high_%ld",indexPath.row]];
            }
        }
    }
    //判断是否选择完成，并且显示答案
    
//    YimaiExaminationAnswerModel *answerModel = _questionModel.select_answer_array[indexPath.row];
//    if (_questionModel.is_finish) {
//        if (answerModel.state == StateNone) {
//            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
//        }else if (answerModel.state == StateRight){
//            cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_1"];
//        }else{
//            cell.iconImageView.image = [UIImage imageNamed:@"MedicalExaminationRight_0"];
//        }
//    }else{
//        if (answerModel.mark) {
//            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_high_%ld",indexPath.row]];
//        }else{
//            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MedicalExaminationAnswer_%ld",indexPath.row]];
//        }
//    }
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
    if (_userAnswerModel.isFinish) {
        return;
    }
    
    if (_userAnswerModel.indexArray == nil) {
        _userAnswerModel.indexArray = [NSMutableArray array];
    }
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //第一次点击答案cell
    if (_userAnswerModel.indexArray.count == 0) {
        [_userAnswerModel.indexArray addObject:index];
    }else{
        
        NSString *tmpStr = [_userAnswerModel.indexArray componentsJoinedByString:@""];
        
        NSRange range = [tmpStr rangeOfString:index];
        
        FLOG(@"location = %ld", range.location);
        if (range.location == NSNotFound) {
            [_userAnswerModel.indexArray addObject:index];
        }else{
            [_userAnswerModel.indexArray removeObject:index];
        }
        
        
    }
    
    //刷新cell
    NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
    
    [tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
//    if (_questionModel.is_finish) {
//        return;
//    }
//    //答案model处理
//    YimaiExaminationAnswerModel *answerModel = _questionModel.select_answer_array[indexPath.row];
//    answerModel.mark = !answerModel.mark;
//    
//    if (answerModel.mark) {//选择
//        if (answerModel.is_Correct) {
//            answerModel.state = StateRight;
//        }else{
//            answerModel.state = StateFalse;
//        }
//    }else{//取消选择
//        
//        if (answerModel.is_Correct) {
//            answerModel.state = StateRight;
//        }else{
//            answerModel.state = StateNone;
//        }
//    }
//    
//    //finishModel处理
//    if (answerModel.mark) {//选择
//        if (_questionModel.finishModel.answer == NULL) {
//            _questionModel.finishModel.answer = @"";
//        }
//        _questionModel.finishModel.answer = [NSString stringWithFormat:@"%@%@",_questionModel.finishModel.answer,[self answerWithIndex:indexPath.row]];
//
//    }else{//取消选择
//        NSMutableString *tmpStr = [NSMutableString stringWithFormat:@"%@",_questionModel.finishModel.answer];
//        NSRange range = [tmpStr rangeOfString:[self answerWithIndex:indexPath.row]];
//        [tmpStr deleteCharactersInRange:range];
//        _questionModel.finishModel.answer = [NSString stringWithFormat:@"%@",tmpStr];
//    }
//    
//    //刷新cell
//    NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
//    
//    [tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  根据index返回ABCDEF
 */
- (NSString *)answerWithIndex:(NSInteger)index
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
    }else if (index == 5){
        return @"F";
    }else if (index == 6){
        return @"G";
    }else{
        return @"H";
    }
}
@end
