//
//  YimaiExaminationAnswerFrameModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationAnswerFrameModel.h"
#import "YimaiExaminationAnswerModel.h"
#import "DTCoreText.h"
@implementation YimaiExaminationAnswerFrameModel


- (void)setAnswerModel:(YimaiExaminationAnswerModel *)answerModel
{
    _answerModel = answerModel;
    
    _answerCellHeight = [self attributesStrHeight:answerModel.answer] + 28;
}

- (CGFloat)attributesStrHeight:(NSString *)coreTextString
{
    NSData *data = [coreTextString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    CGFloat width = kScreenWidth - 81;
    CGRect maxRect = CGRectMake(0.0, 0.0, width, CGFLOAT_HEIGHT_UNKNOWN);
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:maxRect range:entireString];
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded.height;
}
@end
