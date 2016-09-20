//
//  YimaiExaminationCollectionCell.m
//  DoctorPlatForm
//
//  Created by silent on 16/4/19.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationCollectionCell.h"
#import "YimaiExaminationQuestionModel.h"

#import "YimaiExaminationTableViewDescriptionCell.h"
//#import "YimaiExaminationQuestionFrameModel.h"
//#import "YimaiExaminationTableViewCell.h"
//#import "YimaiExaminationTableHeaderCell.h"
//#import "YimaiExaminationQuestionModel.h"
//#import "YimaiExaminationSelect_answerModel.h"
//#import "YimaiExaminationTableFooterCell.h"
//#import "YimaiExaminationFinishModel.h"
//#import "YimaiExaminationCoreTextTableViewCell.h"
//#import "YimaiFinishExaminationWrong_question_inforDataModel.h"
@interface YimaiExaminationCollectionCell ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) UIButton *finishUpBtn;

@end

@implementation YimaiExaminationCollectionCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 64;
    
    CGFloat wExaminationView = width;
    CGFloat hExaminationView = height;
    
    self.size = CGSizeMake(wExaminationView, hExaminationView);
    
    FLOG(@"subView = %@", self.tableView.subviews);
}

#pragma mark table view data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationTableViewDescriptionCell *cell = [YimaiExaminationTableViewDescriptionCell cellWithTableView:tableView];
    
    cell.questionModel = self.questionModel;
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (CGFloat)attributesStrHeight:(NSString *)coreTextString
//{
//    NSData *data = [coreTextString dataUsingEncoding:NSUTF8StringEncoding];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
//    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
//    CGFloat width = kScreenWidth - 48 - 33;
//    CGRect maxRect = CGRectMake(0.0, 0.0, width, CGFLOAT_HEIGHT_UNKNOWN);
//    NSRange entireString = NSMakeRange(0, [attributedString length]);
//    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:maxRect range:entireString];
//    CGSize sizeNeeded = [layoutFrame frame].size;
//    return sizeNeeded.height;
//}


- (void)finishUpBtnAction
{
    if ([self.delegate respondsToSelector:@selector(finishUpBtnClickAction)]) {
        [self.delegate finishUpBtnClickAction];
    }
}

@end
