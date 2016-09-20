//
//  MedicineExaminationController.m
//  examTest4.13
//
//  Created by silent on 16/4/13.
//  Copyright © 2016年 joe. All rights reserved.
//

#import "MedicineExaminationController.h"
#import "MedicineExaminationCell.h"
#import "ExaminationListController.h"
#import "ExamTool.h"
#import "YimaiMedicalExaminationDataModel.h"
#import "YimaiMedicalExaminationResultModel.h"
#import "UIImageView+EMWebCache.h"
@interface MedicineExaminationController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 *  存放dataModel的数组
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  请求数据结果模型
 */
@property (nonatomic, strong) YimaiMedicalExaminationResultModel *resultModel;

@end



@implementation MedicineExaminationController


static NSString *const identifier = @"MedicineExaminationCell";

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"医学试题";
    
    //请求数据
    [self requestHttpData];
    
    //设置collection view
    [self loadCollectionView];
    //设置页面属性
    [self setAttributes];
}

- (void)setAttributes
{
    self.title = @"医学试题";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"shareTopImage_normal" higImage:nil targe:self action:@selector(rightDown)];
}

- (void)rightDown
{

}

- (void)requestHttpData
{
    [self addLoading];
    
    [ExamTool MedicalExaminationWithSuccess:^(YimaiMedicalExaminationResultModel *resutlModel) {
        
        [self removeLoading];
        
        self.resultModel = resutlModel;
        
        self.dataArray = resutlModel.data;
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [self removeLoading];
    }];
}

- (void)loadCollectionView
{
    CGFloat top = 17;
    
    CGFloat bottom = top;
    
    CGFloat lineSpacing = 22;
    
    CGFloat width = 126;
    
    CGFloat height = 162;
    
    CGFloat margin  = (kScreenWidth - 2 * width) / 3;
    
    //    NSLog(@"width = %f",width);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(width , height);
    
    layout.sectionInset = UIEdgeInsetsMake(top, margin, bottom, margin);
    
    layout.minimumLineSpacing = lineSpacing;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    self.collectionView.alwaysBounceVertical = YES;
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    MedicineExaminationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    YimaiMedicalExaminationDataModel *dataModel = self.dataArray[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:dataModel.image];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExaminationListController *vc = [[ExaminationListController alloc]init];
    
    YimaiMedicalExaminationDataModel *dataModel = self.dataArray[indexPath.row];
    
    vc.title = dataModel.class_name;
    
    vc.classid = dataModel.class_id;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
