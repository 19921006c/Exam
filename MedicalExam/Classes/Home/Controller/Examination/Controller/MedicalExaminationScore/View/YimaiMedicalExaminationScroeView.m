//
//  YimaiMedicalExaminationScroeView.m
//  DoctorPlatForm
//
//  Created by silent on 16/4/20.
//  Copyright © 2016年 songzm. All rights reserved.
//

#define kYimaiFinishExaminationKey @"kYimaiFinishExaminationKey"

#import "YimaiMedicalExaminationScroeView.h"
#import "YimaiExaminationHttpTool.h"
#import "YimaiFinishExamRecordResultModel.h"
#import "YimaiExaminationController.h"
#import "YimaiFinishExamRecordParamModel.h"
#import "YimaiUserAnswerResultNodeModel.h"
#import "YimaiUserAnswerNodeModel.h"
#import "YimaiUserAnswerModel.h"
#import "YimaiExaminationTool.h"
@interface YimaiMedicalExaminationScroeView ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isPassImageView;

@end

@implementation YimaiMedicalExaminationScroeView


- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];   
}

- (void)setUserResultModel:(YimaiUserAnswerResultNodeModel *)userResultModel
{
    _userResultModel = userResultModel;
    
    [self networkingRequest];
}
//- (void)setSourceArray:(NSArray *)sourceArray
//{
//    _sourceArray = sourceArray;
//    
//    //请求网络，提交试卷
//    [self networkingRequest];
//}

//- (void)setPassOnFinishModel:(YimaiExaminationPassOnFinishModel *)passOnFinishModel
//{
//    _passOnFinishModel = passOnFinishModel;
//    
//    //请求网络,提交试卷
////    [self networkingRequest];
//}

- (void)networkingRequest
{
    NSMutableArray *sourceArray = [NSMutableArray array];
    
    for (YimaiUserAnswerNodeModel *nodeModel in _userResultModel.node) {//遍历node
        for (YimaiUserAnswerModel *answerModel in nodeModel.question) {//遍历quetion
            if (answerModel.sub.count != 0) {
                for (YimaiUserAnswerModel *model in answerModel.sub) {
                    [sourceArray addObject:model];
                }
            }else{
                [sourceArray addObject:answerModel];
            }
        }
    }
    
    YimaiFinishExamRecordParamModel *param = [[YimaiFinishExamRecordParamModel alloc] init];

    //拼接paper 字符串
    NSMutableArray *tmpArray = [NSMutableArray array];

    for (YimaiUserAnswerModel *userAnswerModel in sourceArray) {
        if (!param.paperId) {
            param.paperId = [NSString stringWithFormat:@"%@",_userResultModel.paper_id];
        }
        if (userAnswerModel.isFinish) {//已答了的题
            if ([userAnswerModel.score integerValue] <= 0) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"answer"] = [NSString stringWithFormat:@"%@",userAnswerModel.answer];
                dic[@"questionId"] = [NSString stringWithFormat:@"%@",userAnswerModel.questionid];
                [tmpArray addObject:dic];
            }
        }
    }
    
//    NSMutableArray *strArray = [NSMutableArray array];
//    
//    for (NSDictionary *dictionary in tmpArray) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
//        
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//        [strArray addObject:jsonStr];
//    }
    
    NSMutableString *jsonStr = nil;
    
    if (tmpArray.count != 0) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpArray options:0 error:nil];
        
        jsonStr = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
//    NSString *character = nil;
//    for (int i = 0; i < jsonStr.length; i ++) {
//        character = [jsonStr substringWithRange:NSMakeRange(i, 1)];
//        if ([character isEqualToString:@"\\"])
//            [jsonStr deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
    
    param.paper = jsonStr;

    //计算分数
    NSInteger score = 0;
    NSInteger otherScore = 0;
    for (YimaiUserAnswerNodeModel *nodeModel in _userResultModel.node) {
        if ([nodeModel.node_type_id isEqualToString:@"15"]) {//案例分析题
            for (YimaiUserAnswerModel *userAnswerModel in nodeModel.question) {
                NSInteger nodeSubScore = 0;
                for (YimaiUserAnswerModel *model in userAnswerModel.sub) {
                    
                    if (!model.isFinish) {//没答
                        model.score = [NSString stringWithFormat:@"%d",-1];
                    }
                    nodeSubScore += [model.score integerValue];
                }
                
                if (nodeSubScore < 0) {
                    nodeSubScore = 0;
                }
                otherScore += nodeSubScore;
            }
        }else{
            for (YimaiUserAnswerModel *userAnswerModel in nodeModel.question) {
                if (userAnswerModel.sub.count > 0) {
                    for (YimaiUserAnswerModel *model in userAnswerModel.sub) {
                        score += [model.score integerValue];
                    }
                }else{
                    score += [userAnswerModel.score integerValue] ;
                }
                
            }
        }
    }

    NSInteger totalScore = score + otherScore;
    
    param.score = [NSString stringWithFormat:@"%ld",(long)totalScore];
    
    
    self.scoreLabel.text = param.score;
    
    if ([self.delegate respondsToSelector:@selector(scoreViewAddloading)]) {
        [self.delegate scoreViewAddloading];
    }
    
    
//    [YimaiExaminationHttpTool finishExamRecordWith:param success:^(YimaiFinishExamRecordResultModel *resultModel) {
//        
//        if ([self.delegate respondsToSelector:@selector(scoreViewRemoveLoading)]) {
//            [self.delegate scoreViewRemoveLoading];
//        }
//        [YimaiExaminationTool deleteUnfinishExam:resultModel.paperId];
//
//        NSString *rank = [NSString stringWithFormat:@"名列考生排行榜第%@名",resultModel.userRank];
//        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:rank];
//        
//        NSRange range;
//        
//        range.location = 8;
//        
//        range.length = resultModel.userRank.length;
//        
//        NSMutableDictionary *highDic = [NSMutableDictionary dictionary];
//        
//        if ([resultModel.ispass isEqualToString:@"1"]) {
//            highDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#ff862f"];
//            self.isPassImageView.image = [UIImage imageNamed:@"MedicalExaminationScroe_01"];
//        } else{
//            highDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#47d6dc"];
//            self.isPassImageView.image = [UIImage imageNamed:@"MedicalExaminationScroe_02"];
//        }
//        
//        
//        highDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//        
//        [attributedString addAttributes:highDic range:range];
//        
//        self.rankLabel.attributedText = attributedString;
//        
//        self.timeLabel.text = [NSString stringWithFormat:@"考试时间: %@",resultModel.answerTime];
//        
////        [YimaiExaminationTool deleteUnfinishExam:self.passOnFinishModel.paperid];
//        
//        //通知错题集列表刷新
//        [[NSNotificationCenter defaultCenter] postNotificationName:kYimaiFinishExaminationKey object:nil];
//    
//    } failure:^(NSError *error) {
//        
//        if ([self.delegate respondsToSelector:@selector(scoreViewRemoveLoading)]) {
//            [self.delegate scoreViewRemoveLoading];
//        }
//        
//    }];
}


- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
