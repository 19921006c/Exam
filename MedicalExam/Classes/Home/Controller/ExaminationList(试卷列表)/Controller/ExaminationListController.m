//
//  ExaminationListController.m
//  examTest4.13
//
//  Created by silent on 16/4/13.
//  Copyright © 2016年 joe. All rights reserved.
//

#import "ExaminationListController.h"
#import "ExaminationListHeaderView.h"
#import "YimaiExaminationController.h"
#import "YimaiExaminationListResultModel.h"
#import "YimaiExaminationListClassModel.h"
#import "YimaiExaminationListDataModel.h"
#import "MBProgressHUD+Remind.h"
#import "YimaiExaminationHttpTool.h"
@interface ExaminationListController ()<UITableViewDataSource,UITableViewDelegate,ExaminationListHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/**
 *  试卷列表class字段数组
 */
@property (nonatomic, strong) NSMutableArray *classArray;

/**
 *  请求数据结果模型
 */
@property (nonatomic, strong) YimaiExaminationListResultModel *resultModel;

@end

@implementation ExaminationListController

static NSString *const identifier = @"ExaminationListCell";

- (NSMutableArray *)classArray
{
    if (_classArray == nil) {
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求试卷列表数据
    [self requestExaminationListData];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    [self setAttributes];
}

- (void)setAttributes
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"shareTopImage_normal" higImage:nil targe:self action:@selector(rightDown)];
}

- (void)rightDown
{

}

- (void)requestExaminationListData
{
    [self addLoading];
    
    __weak typeof(self)weakSelf = self;
    
    [YimaiExaminationHttpTool ExaminationListWithClassid:self.classid success:^(YimaiExaminationListResultModel *resutlModel) {
    
        [weakSelf removeLoading];
        
        weakSelf.resultModel = resutlModel;
        
        weakSelf.classArray = resutlModel.classArray;
        
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {
        [weakSelf removeLoading];
        [MBProgressHUD showSuccessWithMoment:@"内容暂未开放，敬请期待"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YimaiExaminationListClassModel *classModel = self.classArray[section];
    
    return classModel.open ? classModel.data.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    FLOG(@"secton = %ld", self.classArray.count);
    return self.classArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YimaiExaminationListClassModel *classModel = self.classArray[indexPath.section];
    
    YimaiExaminationListDataModel *dataModel = classModel.data[indexPath.row];
    
    cell.detailTextLabel.text = dataModel.paper_name;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    cell.contentView.layer.borderWidth = 0.5;
    
    cell.contentView.layer.borderColor = [UIColor colorWithHexString:@"#e8e8e8"].CGColor;
    
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YimaiExaminationListClassModel *classModel = self.classArray[section];
    
    ExaminationListHeaderView *headerView = [ExaminationListHeaderView headerViewWith:tableView];
    
    headerView.delegate = self;

    headerView.classModel = classModel;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationController *vc = [[YimaiExaminationController alloc]init];
    
    YimaiExaminationListClassModel *classModel = self.classArray[indexPath.section];
    
    YimaiExaminationListDataModel *dataModel = classModel.data[indexPath.row];
    
    vc.paperid = dataModel.paper_id;
    
    vc.update_time = dataModel.update_time;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ExaminationListHeaderView delegate
- (void)examiantionListHeaderViewDidSelected
{
    [self.tableView reloadData];
}

@end
