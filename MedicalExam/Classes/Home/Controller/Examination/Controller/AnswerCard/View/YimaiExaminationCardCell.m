//
//  YimaiExaminationCardCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/24.
//  Copyright © 2016年 songzm. All rights reserved.
//
#import "YimaiExaminationCardCell.h"
#import "YimaiUserAnswerModel.h"
@interface YimaiExaminationCardCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@end

@implementation YimaiExaminationCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setUserAnswerModel:(YimaiUserAnswerModel *)userAnswerModel
{
    _userAnswerModel = userAnswerModel;
    
    if (userAnswerModel.state == StateNone) {
        self.iconImage.image = [UIImage imageNamed:@"Exam_Card_unfinish_max"];
        return;
    }
    
    if (userAnswerModel.state == StateTrue) {
        self.iconImage.image = [UIImage imageNamed:@"Exam_Card_Right_max"];
        return;
    }
    
    if (userAnswerModel.state == StateFalse) {
        self.iconImage.image = [UIImage imageNamed:@"Exam_Card_False_max"];
        return;
    }
}


@end
