//
//  YimaiExaminationTableViewDescriptionCell.m
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationTableViewDescriptionCell.h"
#import "YimaiExaminationHeaderCellDescriptionView.h"
#import "YimaiExaminationQuestionModel.h"
@interface YimaiExaminationTableViewDescriptionCell()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *questionTypeDescriptionBtn;

@property (nonatomic, weak) YimaiExaminationHeaderCellDescriptionView *descriptionView;

@end
@implementation YimaiExaminationTableViewDescriptionCell

static NSString *const identifier = @"YimaiExaminationTableViewDescriptionCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    YimaiExaminationTableViewDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
/**
 *  题型说明btn action
 */
- (IBAction)questionTypeDescriptionBtnAction:(id)sender {
    YimaiExaminationHeaderCellDescriptionView *view = [[[NSBundle mainBundle] loadNibNamed:@"YimaiExaminationHeaderCellDescriptionView" owner:self options:nil] lastObject];
    
    self.descriptionView = view;
    
    [[CommonTool findNearsetViewController:self].navigationController.view addSubview:view];
    
//    view.paper_node_desc = self.frameModel.questionModel.paper_node_desc;
    view.paper_node_desc = self.questionModel.paper_node_desc;
    
    __weak typeof(self)weakSelf = self;
    
    view.block = ^(){
        [weakSelf.descriptionView removeFromSuperview];
        weakSelf.questionTypeDescriptionBtn.imageView.transform = CGAffineTransformIdentity;
    };
    
    [UIView animateWithDuration:.5 animations:^{
        self.questionTypeDescriptionBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)setQuestionModel:(YimaiExaminationQuestionModel *)questionModel
{
    [self paper_node_nameLabelAttributeOperate:questionModel];
    
    _questionModel = questionModel;
}

- (void)paper_node_nameLabelAttributeOperate:(YimaiExaminationQuestionModel *)questionModel{
    
    NSString *paper_node_nameListOrder = [self number:questionModel.node_list_order];
    
    NSString *firstStr = [NSString stringWithFormat:@"%@、%@",paper_node_nameListOrder,questionModel.paper_node_name];
    
    NSString *secondStr = [NSString stringWithFormat:@"(共%@道,第%ld题)",questionModel.total,questionModel.customListOrder];
    //
    NSString *thirdStr = questionModel.total;
    
    
    NSString *labeltext =[NSString stringWithFormat:@"%@、%@(共%@道,第%ld题)",paper_node_nameListOrder,questionModel.paper_node_name,questionModel.total,questionModel.customListOrder];
    
    NSMutableDictionary *firstDic = [NSMutableDictionary dictionary];
    firstDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333333"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:labeltext];
    NSRange rang;
    rang.location = 0;
    rang.length = firstStr.length;
    [attStr addAttributes:firstDic range:rang];
    
    
    NSMutableDictionary *secondDic = [NSMutableDictionary dictionary];
    secondDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#999999"];
    rang.location = firstStr.length;
    rang.length = secondStr.length;
    [attStr addAttributes:secondDic range:rang];
    
    NSMutableDictionary *thirdDic = [NSMutableDictionary dictionary];
    thirdDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#3bc9d6"];
    rang.location = firstStr.length + 2;
    rang.length = thirdStr.length;
    [attStr addAttributes:thirdDic range:rang];
    
    
    self.label.attributedText = attStr;
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
