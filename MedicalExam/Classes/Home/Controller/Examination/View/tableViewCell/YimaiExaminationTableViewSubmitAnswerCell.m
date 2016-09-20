//
//  YimaiExaminationTableViewSubmitAnswerCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/19.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationTableViewSubmitAnswerCell.h"

@interface YimaiExaminationTableViewSubmitAnswerCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn;


@end
@implementation YimaiExaminationTableViewSubmitAnswerCell

static NSString *const identifier = @"YimaiExaminationTableViewSubmitAnswerCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.layer.cornerRadius = 5;
    self.btn.clipsToBounds = YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    YimaiExaminationTableViewSubmitAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self;
}
@end
