//
//  YimaiExaminationQuestionModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "NSString+Character.h"
@implementation YimaiExaminationQuestionModel

- (void)setQuestion_type_id:(NSString *)question_type_id
{
    _question_type_id = question_type_id;
    
}
- (void)setSelect_answer:(NSString *)select_answer
{
    // joe to do
    
    self.select_answer_array = [self stringToArray:select_answer];
    
    _select_answer = select_answer;
}

- (void)setCorrect_answer:(NSString *)correct_answer
{
    if (correct_answer.length > 1) {//多选题
        
        NSArray *characterArr = [NSArray arrayWithArray:[self stringToArray:correct_answer]];
        
        NSArray *indexArr = [self indexArrayWith:characterArr];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        for (int i = 0; i < _select_answer_array.count; i ++) {
            YimaiExaminationAnswerModel *model = [[YimaiExaminationAnswerModel alloc] init];
            model.answer = _select_answer_array[i];
            
            for (NSString *indexStr in indexArr) {
                if ([indexStr isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                    model.is_Correct = YES;
                }
            }
            model.index = [NSString stringWithFormat:@"%d",i];
            [tmpArray addObject:model];
        }
        _select_answer_array = tmpArray;
        
        _correct_answer = correct_answer;
        return;
    }
    
    //单选题
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    int index = [self indexWithString:correct_answer];
    
    for (int i = 0; i < _select_answer_array.count; i ++) {
        YimaiExaminationAnswerModel *model = [[YimaiExaminationAnswerModel alloc] init];
        model.answer = _select_answer_array[i];
        if (index == i) {
            model.is_Correct = YES;
        }else{
            model.is_Correct = NO;
        }
        model.index = [NSString stringWithFormat:@"%d",i];
        [tmpArray addObject:model];
    }
    _select_answer_array = tmpArray;
    
    _correct_answer = correct_answer;
}

- (void)setAnswer_option:(NSString *)answer_option
{
    _answer_option = answer_option;
    
    NSArray *answer_optionArray = [self stringToArray:answer_option];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *str in answer_optionArray) {
        NSString *index = [NSString stringWithFormat:@"%ld",[NSString indexWithCharacter:str]];
        
        [tmpArray addObject:index];
    }
    
    _answer_option_array = tmpArray;
}

- (NSMutableArray *)indexArrayWith:(NSArray *)array
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *character in array) {
        [tmpArray addObject:[NSString stringWithFormat:@"%d",[self indexWithString:character]]];
    }
    return tmpArray;
}

/**
 *  返回选项对应的序号
 *
 *  @param correct_answer a/b/c/d/e
 *
 *  @return 0/1/2/3/4
 */
- (int)indexWithString:(NSString *)correct_answer
{
    if ([correct_answer isEqualToString:@"A"]) {
        return 0;
    }else if ([correct_answer isEqualToString:@"B"]) {
        return 1;
    }else if ([correct_answer isEqualToString:@"C"]) {
        return 2;
    }else if ([correct_answer isEqualToString:@"D"]) {
        return 3;
    }else if ([correct_answer isEqualToString:@"E"]) {
        return 4;
    }else if ([correct_answer isEqualToString:@"F"]) {
        return 5;
    }else if ([correct_answer isEqualToString:@"G"]) {
        return 6;
    }else if ([correct_answer isEqualToString:@"H"]) {
        return 7;
    }else if ([correct_answer isEqualToString:@"I"]) {
        return 8;
    }else if ([correct_answer isEqualToString:@"J"]) {
        return 9;
    }else if ([correct_answer isEqualToString:@"K"]) {
        return 10;
    }else if ([correct_answer isEqualToString:@"L"]) {
        return 11;
    }else if ([correct_answer isEqualToString:@"M"]) {
        return 12;
    }else if ([correct_answer isEqualToString:@"N"]) {
        return 13;
    }else if ([correct_answer isEqualToString:@"O"]) {
        return 14;
    }else if ([correct_answer isEqualToString:@"P"]) {
        return 15;
    }else if ([correct_answer isEqualToString:@"Q"]) {
        return 16;
    }else if ([correct_answer isEqualToString:@"R"]) {
        return 17;
    }else if ([correct_answer isEqualToString:@"S"]) {
        return 18;
    }else if ([correct_answer isEqualToString:@"T"]) {
        return 19;
    }else if ([correct_answer isEqualToString:@"U"]) {
        return 20;
    }else if ([correct_answer isEqualToString:@"V"]) {
        return 21;
    }else if ([correct_answer isEqualToString:@"W"]) {
        return 22;
    }else if ([correct_answer isEqualToString:@"X"]) {
        return 23;
    }else if ([correct_answer isEqualToString:@"Y"]) {
        return 24;
    }else{
        return 25;
    }
}

/**
 *  将   支气管哮喘|血清病|药物过敏性休克|接触性皮炎|自身免疫性溶血性贫血
 *
 *  @param select_answer 答案字符串
 *
 *  @return 返回答案数组
 */
- (NSMutableArray *)stringToArray:(NSString *)select_answer{
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    NSMutableArray *answerArray = [NSMutableArray array];
    
    if (select_answer.length == 1) {
        
        [answerArray addObject:select_answer];
        
        return answerArray;
    }
    for (int i = 0; i < select_answer.length; i ++) {
        NSString *indexStr = [select_answer substringWithRange:NSMakeRange(i, 1)];
        
        if ([indexStr isEqualToString:@"|"]) {
            
            [tmpArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    //    FLOG(@"tmpArr = %@", tmpArr);
    
    
    for (int i = 0; i < tmpArr.count; i ++) {
        
        int index = [tmpArr[i] intValue];
        if (i == 0) {
            if (tmpArr.count == 1) {//如果只有两个对象时进行的操作
    
                [answerArray addObject:[select_answer substringWithRange:NSMakeRange(0, index)]];
                
                [answerArray addObject:[select_answer substringFromIndex:[tmpArr[i] intValue] + 1]];
            }else{
                [answerArray addObject:[select_answer substringWithRange:NSMakeRange(0, index)]];
            }

        } else if(i == tmpArr.count - 1){
            index = [tmpArr[i - 1] intValue] + 1;
            int length = [tmpArr[i] intValue] - [tmpArr[i - 1] intValue] - 1;
            [answerArray addObject:[select_answer substringWithRange:NSMakeRange(index, length)]];
            
            [answerArray addObject:[select_answer substringFromIndex:[tmpArr[i] intValue] + 1]];
        } else{
            index = [tmpArr[i - 1] intValue] + 1;
            int length = [tmpArr[i] intValue] - [tmpArr[i - 1] intValue] - 1;
            [answerArray addObject:[select_answer substringWithRange:NSMakeRange(index, length)]];
        }
        
    }
    
    return answerArray;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.question_id forKey:@"question_id"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.tips forKey:@"tips"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.select_answer forKey:@"select_answer"];
    [aCoder encodeObject:self.question_score forKey:@"question_score"];
    [aCoder encodeObject:self.question_analysis forKey:@"question_analysis"];
    [aCoder encodeObject:self.list_order forKey:@"list_order"];
    [aCoder encodeObject:self.correct_answer forKey:@"correct_answer"];
    [aCoder encodeObject:self.question_type_id forKey:@"question_type_id"];
    [aCoder encodeObject:self.isdel forKey:@"isdel"];
    [aCoder encodeObject:self.common_id_str forKey:@"common_id_str"];
    [aCoder encodeObject:self.sub forKey:@"sub"];
    [aCoder encodeObject:self.answer_option forKey:@"answer_option"];
    [aCoder encodeObject:self.answer_option_array forKey:@"answer_option_array"];
    [aCoder encodeObject:self.paper_node_name forKey:@"paper_node_name"];
    [aCoder encodeObject:self.paper_node_desc forKey:@"paper_node_desc"];
    [aCoder encodeObject:self.total forKey:@"total"];
    [aCoder encodeObject:self.node_list_order forKey:@"node_list_order"];
    [aCoder encodeObject:self.select_answer_array forKey:@"select_answer_array"];
    [aCoder encodeObject:self.correct_answer_array forKey:@"correct_answer_array"];
    [aCoder encodeObject:self.commonContent forKey:@"commonContent"];
    [aCoder encodeObject:self.paper_id forKey:@"paper_id"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.question_id = [aDecoder decodeObjectForKey:@"question_id"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
        self.tips = [aDecoder decodeObjectForKey:@"tips"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        _select_answer = [aDecoder decodeObjectForKey:@"select_answer"];
        self.question_score = [aDecoder decodeObjectForKey:@"question_score"];
        self.question_analysis = [aDecoder decodeObjectForKey:@"question_analysis"];
        self.list_order = [aDecoder decodeObjectForKey:@"list_order"];
        _correct_answer = [aDecoder decodeObjectForKey:@"correct_answer"];
        _question_type_id = [aDecoder decodeObjectForKey:@"question_type_id"];
        self.isdel = [aDecoder decodeObjectForKey:@"isdel"];
        self.common_id_str = [aDecoder decodeObjectForKey:@"common_id_str"];
        self.sub = [aDecoder decodeObjectForKey:@"sub"];
        _answer_option = [aDecoder decodeObjectForKey:@"answer_option"];
        self.answer_option_array = [aDecoder decodeObjectForKey:@"answer_option_array"];
        self.paper_node_name = [aDecoder decodeObjectForKey:@"paper_node_name"];
        self.paper_node_desc = [aDecoder decodeObjectForKey:@"paper_node_desc"];
        self.total = [aDecoder decodeObjectForKey:@"total"];
        self.node_list_order = [aDecoder decodeObjectForKey:@"node_list_order"];
        self.select_answer_array = [aDecoder decodeObjectForKey:@"select_answer_array"];
        self.correct_answer_array = [aDecoder decodeObjectForKey:@"correct_answer_array"];
        self.commonContent = [aDecoder decodeObjectForKey:@"commonContent"];
        self.paper_id = [aDecoder decodeObjectForKey:@"paper_id"];
    }
    return self;
}
@end
