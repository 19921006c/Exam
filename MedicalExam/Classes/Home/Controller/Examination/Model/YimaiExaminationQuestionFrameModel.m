//
//  YimaiExaminationQuestionFrameModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationQuestionFrameModel.h"
#import "YimaiExaminationQuestionModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "YimaiExaminationAnswerFrameModel.h"
#import <DTCoreText.h>
#import "NSString+Extension.h"
@implementation YimaiExaminationQuestionFrameModel
-(void)setQuestionModel:(YimaiExaminationQuestionModel *)questionModel
{
    _questionModel = questionModel;
    
    CGFloat margin = 12;
    
    //计算题型说明cell高度
    NSString *paper_node_nameListOrder = [self number:questionModel.node_list_order];
    
    NSString *descriptionStr = [NSString stringWithFormat:@"%@、%@(共%@道,第%@题)",paper_node_nameListOrder,questionModel.paper_node_name,questionModel.total,questionModel.common_id_str];
    
    CGFloat descriptionStrHeight = [NSString sizeWithString:descriptionStr font:[UIFont systemFontOfSize:14] WithSize:CGSizeMake(kScreenWidth - 90 - margin * 2, MAXFLOAT)].height;
    self.descriptionCellHeight = descriptionStrHeight + margin * 3;
    
    //计算公用题干cell的高度
    self.commonContentCellHeight = [self attributesStrHeight:questionModel.commonContent margin:2 * margin] + margin * 3 + 2;
    //计算追加题干cell的高度
    if ([questionModel.tips isEqualToString:@""]) {
        self.tipCellHeight = 0;
    }else{
        self.tipCellHeight = [self attributesStrHeight:questionModel.tips margin:2 * margin] + margin * 3 + 2;
    }
    //计算问题cell的高度
    self.contentCellHeight = [self attributesStrHeight:questionModel.content margin:2 * margin] + margin * 2;
    //计算解析cell的高度
    //解析部分的总高度
    CGFloat questionAnalysisHeight = 0;
    //答案部分总高度
    CGFloat questionAnswerHeight = 1 + margin + 1 + margin + margin + margin + 1;
    //解析文字高度
    self.analysisHeight = [self attributesStrHeight:[NSString stringWithFormat:@"解析: %@",questionModel.question_analysis] margin:2 * margin];
    if (![questionModel.question_analysis isEqualToString:@""]) {
        questionAnalysisHeight =  self.analysisHeight + margin * 2;
    }
    //解析cell高度
    self.questionAnalysisCellHeight = questionAnswerHeight + questionAnalysisHeight;
    //选项table view height
    self.answerTableViewHeight = 0;
    for (YimaiExaminationAnswerModel *answerModel in questionModel.select_answer_array) {
        YimaiExaminationAnswerFrameModel *frameModel = [[YimaiExaminationAnswerFrameModel alloc]init];
        frameModel.answerModel = answerModel;
        self.answerTableViewHeight += frameModel.answerCellHeight;
    }
}

- (CGFloat)attributesStrHeight:(NSString *)coreTextString margin:(CGFloat)margin
{
    NSData *data = [coreTextString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    CGFloat width = kScreenWidth - margin;
    CGRect maxRect = CGRectMake(0.0, 0.0, width, CGFLOAT_HEIGHT_UNKNOWN);
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:maxRect range:entireString];
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded.height;
}
- (NSString *)number:(NSString *)paper_node_nameListOrder
{
    NSInteger number = [paper_node_nameListOrder integerValue];
    
    NSString *word = nil;
    switch (number) {
        case 1:
            word = @"一";
            break;
        case 2:
            word = @"二";
            break;
        case 3:
            word = @"三";
            break;
        case 4:
            word = @"四";
            break;
        case 5:
            word = @"五";
            break;
        case 6:
            word = @"六";
            break;
        case 7:
            word = @"七";
            break;
        case 8:
            word = @"八";
            break;
        case 9:
            word = @"九";
            break;
        case 10:
            word = @"十";
            break;
        case 11:
            word = @"十一";
            break;
        case 12:
            word = @"十二";
            break;
        case 13:
            word = @"十三";
            break;
        case 14:
            word = @"十四";
            break;
        case 15:
            word = @"十五";
            break;
        case 16:
            word = @"十六";
            break;
        case 17:
            word = @"十七";
            break;
        case 18:
            word = @"十八";
            break;
        case 19:
            word = @"十九";
            break;
        case 20:
            word = @"二十";
            break;
        default:
            break;
    }
    return word;
}
@end
