//
//  YimaiExaminationHeaderCellDescriptionView.m
//  DoctorPlatForm
//
//  Created by J on 16/5/20.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationHeaderCellDescriptionView.h"

@interface YimaiExaminationHeaderCellDescriptionView ()


@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation YimaiExaminationHeaderCellDescriptionView

- (void)awakeFromNib
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    self.bottomView.layer.cornerRadius = 5;
    
}
- (IBAction)btnAction:(id)sender {

    if (self.block) {
        self.block();
    }
    
}

- (void)setPaper_node_desc:(NSString *)paper_node_desc
{
    _paper_node_desc = paper_node_desc;
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    attributes[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333333"];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    [style setLineSpacing:11];
    
    attributes[NSParagraphStyleAttributeName] = style;
    
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:paper_node_desc attributes:attributes];
    
    self.label.attributedText = attStr;
}

@end
