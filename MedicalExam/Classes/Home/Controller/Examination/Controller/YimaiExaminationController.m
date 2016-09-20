//
//  YimaiExaminationController.m
//  DoctorPlatForm
//
//  Created by silent on 16/4/19.
//  Copyright © 2016年 songzm. All rights reserved.
//
#define SaveUnfinishExamDataNotification @"SaveUnfinishExamDataNotification"

#import "YimaiExaminationController.h"
#import "YimaiExaminationCollectionCell.h"
#import "YimaiExaminationHttpTool.h"

#import "YimaiExaminationParamModel.h"
#import "YimaiExaminationResultModel.h"
#import "YimaiExaminationNodeModel.h"
#import "YimaiExaminationQuestionModel.h"

#import "YimaiExaminationCollectionForTypeOneCell.h"
#import "YimaiExaminationCollectionForTypeTwoCell.h"
#import "YimaiExaminationCollectionForTypeThreeCell.h"
#import "YimaiExaminationCollectionForTypeFourCell.h"
#import "YimaiExaminationCollectionForTypeFiveCell.h"

#import "YimaiExaminationCardControllerViewController.h"
#import "YimaiExaminationRightItemView.h"
#import "YimaiComputeScoreViewController.h"
#import "YimaiExaminationTool.h"
#import "YimaiExaminationToolModel.h"
#import "YimaiUserAnswerModel.h"
#import "YimaiUserAnswerNodeModel.h"
#import "YimaiUserAnswerResultNodeModel.h"
@interface YimaiExaminationController ()<UICollectionViewDataSource,UICollectionViewDelegate,YimaiExaminationCollectionCellDelegate,UIAlertViewDelegate,YimaiExaminationRightItemViewDelegate,UIAlertViewDelegate,YimaiExaminationCardControllerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *array;

@property (nonatomic, strong) NSArray *sourceArray;

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (nonatomic, strong) YimaiExaminationResultModel *resultModel;

@property (nonatomic, strong) YimaiUserAnswerResultNodeModel *userResultModel;
@property (nonatomic, strong) NSMutableArray *userAnswerModelArray;
//@property (nonatomic, weak) YimaiMedicalExaminationScroeView *scroeView;

@end

@implementation YimaiExaminationController

static NSString *const identifier = @"YimaiExaminationCollectionCell";
static NSString *const typeOneIdentifier = @"YimaiExaminationCollectionForTypeOneCell";
static NSString *const typeTwoIdentifier = @"YimaiExaminationCollectionForTypeTwoCell";
static NSString *const typeThreeIdentifier = @"YimaiExaminationCollectionForTypeThreeCell";
static NSString *const typeFourIdentifier = @"YimaiExaminationCollectionForTypeFourCell";
static NSString *const typeFiveIdentifier = @"YimaiExaminationCollectionForTypeFiveCell";
static NSString *const identifierScroe = @"YimaiMedicalExaminationScroeView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基础知识";
    
    //清空数据库处理
    [self dbProcess];
    
    //设置 collection view
    [self loadCollectionView];
    
    [self requestData];
    
    [self setAttributes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUnfinishExamDataFun) name:SaveUnfinishExamDataNotification object:nil];
}
- (void)dbProcess{
    //存储是否清空过数据库
    NSString *key = @"deleteExaminationDB";
    
    BOOL isDelete = [[NSUserDefaults standardUserDefaults]boolForKey:key];
    
    //未清空过数据库，则清空数据库
    if (!isDelete) {
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *path = [doc stringByAppendingPathComponent:@"MedicalExamination.sqlite"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        [manager removeItemAtPath:path error:nil];
        
        //清空数据库后保存已经清空状态
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:key];
    }
}

- (void)setAttributes
{
    YimaiExaminationRightItemView *view = [YimaiExaminationRightItemView view];
    
    view.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"交卷" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectedSubmitBtn)];
}

//分享代理方法
- (void)didSelectedShareBtn
{
#pragma mark - 数据库中的数据
    //取的缓存
    
}
//交卷代理方法
- (void)didSelectedSubmitBtn
{
    for (YimaiUserAnswerModel *userAnswerModel in self.userAnswerModelArray) {
        if (!userAnswerModel.isFinish) {//有未答完的试题跳出遍历
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还有试题未答，确认交卷吗？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alert show];
            return;
        }
    }
    [self submitPaper];
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//否，跳到答题卡
        YimaiExaminationCardControllerViewController *vc = [[YimaiExaminationCardControllerViewController alloc] init];
        
        vc.delegate = self;
        vc.userResultModel = _userResultModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{//交卷
        [self submitPaper];
    }
}

#pragma mark - YimaiExaminationCardControllerViewController delegate
- (void)slideToPosition:(int)index
{
    [self.collectionView setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:YES];
}
/**
 *  交卷处理
 */
- (void)submitPaper
{
    YimaiComputeScoreViewController *vc = [[YimaiComputeScoreViewController alloc] init];
    vc.title = self.resultModel.paper_name;
    vc.userResultModel = _userResultModel;
    [self.navigationController pushViewController:vc animated:YES];
}

//请求网络数据
- (void)requestData
{
#pragma mark - 先看数据库中是否有数据
    
    YimaiExaminationResultModel *resultModel = [YimaiExaminationTool dataWithParams:self.paperid];
    
    
    if (resultModel) {//数据库中有数据,取缓存的数据

        self.resultModel = resultModel;
        
        [self dataProcess];
    }else{//数据库中没有数据
        [self nonDataProcess];
    }
}
#pragma mark - 有缓存数据
- (void)dataProcess{
    //判断数据是否有更新
    if ([self.update_time isEqualToString:self.resultModel.update_time]) {//没有更新
        [self nonNewData];
    }else{//有更新
        //请求网络数据
        [self nonDataProcess];
    }
}
#pragma mark - 没有更新数据处理
- (void)nonNewData{
    //处理数据
    [self dataOperation:self.resultModel];
    
#pragma mark - 看数据库中是否有未答完的试题
    //查看是否有未完成试卷
    YimaiExaminationToolModel *model = [YimaiExaminationTool infoWithPaperid:self.paperid];
    
    if (model.resultModel) {//有未完成试卷
        
        NSInteger index = [model.page integerValue];
        
        self.userResultModel = model.resultModel;
        [self userAnswerDataProcess:index];
        
        return;
    }else{
        [self userAnswerDataProcess:0];
    }
    return;
}
#pragma mark - 没有缓存数据
- (void)nonDataProcess{
    
    [self addLoading];
    
    YimaiExaminationParamModel *param = [[YimaiExaminationParamModel alloc] init];
    
    param.paperId = self.paperid;
    
    param.a = @"medicine";
    
    __weak typeof(self)weakSelf = self;
    
    [YimaiExaminationHttpTool ExaminationWithPaperid:param success:^(YimaiExaminationResultModel *resultModel) {
        
        [weakSelf removeLoading];
        
        weakSelf.resultModel = resultModel;
        
        //处理数据
        [weakSelf dataOperation:resultModel];
        [weakSelf userAnswerDataProcess:0];
        
    } failure:^(NSError *error) {
        
        [weakSelf removeLoading];
        
    }];
}

#pragma mark - 数据处理抽取方法

//试题数据处理
- (void)dataOperation:(YimaiExaminationResultModel *)resultModel
{
    self.title = self.resultModel.paper_name;
    
    NSMutableArray *questionArray = [NSMutableArray array];

    for (YimaiExaminationNodeModel *nodeModel in resultModel.node) {//遍历node
        NSInteger customListOrder = 0;
        for (YimaiExaminationQuestionModel *questionModel in nodeModel.question) {//遍历
            if (questionModel.sub.count != 0) {
                for (YimaiExaminationQuestionModel *model in questionModel.sub) {
                    customListOrder += 1;
                    model.customListOrder = customListOrder;
                    [questionArray addObject:model];
                }
            }else{
                customListOrder += 1;
                questionModel.customListOrder = customListOrder;
                [questionArray addObject:questionModel];
            }
        }
    }
    self.sourceArray = questionArray;
}
//未完成试卷数据处理
- (void)userAnswerDataProcess:(NSInteger)index
{
    self.title = self.resultModel.paper_name;
    
    //有未答完数据
    if (self.userResultModel) {
        [self freshCollectionView:index];
        return;
    }
    
    //没有未答完数据
    
    YimaiUserAnswerResultNodeModel *userResultModel = [[YimaiUserAnswerResultNodeModel alloc] init]
    ;
    userResultModel.paper_id = self.resultModel.paper_id;
    userResultModel.node = [NSMutableArray array];
    
    //0.1
    for (YimaiExaminationNodeModel *nodeModel in self.resultModel.node) {//遍历node
        //2.1
        YimaiUserAnswerNodeModel *node = [[YimaiUserAnswerNodeModel alloc]init];
        node.node_type_id = nodeModel.node_type_id;
        node.paper_node_name = nodeModel.paper_node_name;
        node.question = [NSMutableArray array];
        //0.2
        for (YimaiExaminationQuestionModel *questionModel in nodeModel.question) {//遍历quetion
            //2.2
            YimaiUserAnswerModel *userAnswerModel = [[YimaiUserAnswerModel alloc]init];
            userAnswerModel.sub = [NSMutableArray array];
            userAnswerModel.common_id_str = questionModel.common_id_str;
            userAnswerModel.questionid = questionModel.question_id;
            [node.question addObject:userAnswerModel];
            //0.3
            if (questionModel.sub.count != 0) {
                //0.4
                for (YimaiExaminationQuestionModel *model in questionModel.sub) {
                    //1.1
                    //2.3
                    YimaiUserAnswerModel *userAnswerSub = [[YimaiUserAnswerModel alloc]init];
                    userAnswerSub.common_id_str = model.common_id_str;
                    userAnswerSub.questionid = model.question_id;
                    [userAnswerModel.sub addObject:userAnswerSub];
                }
                //0.
            }else{
            }
        }
        [userResultModel.node addObject:node];
    }
    
    self.userResultModel = userResultModel;
    
    [self freshCollectionView:0];
}
/**
 *  刷新collection view 抽取方法
 */
- (void)freshCollectionView:(NSInteger)index
{
    NSMutableArray *userArray = [NSMutableArray array];
    for (YimaiExaminationNodeModel *node in self.userResultModel.node) {//遍历node
        for (YimaiUserAnswerModel *userAnswerModel in node.question) {//遍历quetion
            if (userAnswerModel.sub.count != 0) {
                for (YimaiUserAnswerModel *model in userAnswerModel.sub) {
                    [userArray addObject:model];
                }
            }else{
                [userArray addObject:userAnswerModel];
            }
        }
    }
    self.userAnswerModelArray = userArray;
    
    if (index) {
        __weak typeof(self)weakSelf = self;
        
        [self.collectionView performBatchUpdates:^{
            
            [weakSelf.collectionView reloadData];
            
        } completion:^(BOOL finished) {
            
            weakSelf.collectionView.contentOffset = CGPointMake(index * kScreenWidth, 0);
            
        }];
    }else{
        [self.collectionView reloadData];
    }
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //    layout.itemSize = CGSizeMake(self.view.size.width, self.view.size.height);
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - kNavigtaionHeight);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    [self.collectionView registerClass:[YimaiExaminationCollectionForTypeOneCell class] forCellWithReuseIdentifier:typeOneIdentifier];
    [self.collectionView registerClass:[YimaiExaminationCollectionForTypeTwoCell class] forCellWithReuseIdentifier:typeTwoIdentifier];
    [self.collectionView registerClass:[YimaiExaminationCollectionForTypeThreeCell class] forCellWithReuseIdentifier:typeThreeIdentifier];
    [self.collectionView registerClass:[YimaiExaminationCollectionForTypeFourCell class] forCellWithReuseIdentifier:typeFourIdentifier];
    [self.collectionView registerClass:[YimaiExaminationCollectionForTypeFiveCell class] forCellWithReuseIdentifier:typeFiveIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:identifierScroe bundle:nil] forCellWithReuseIdentifier:identifierScroe];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.sourceArray.count == 0) {
        return 0;
    }else{
        return self.sourceArray.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationQuestionModel *questionModel = self.sourceArray[indexPath.row];

    YimaiUserAnswerModel *userAnswerModel = self.userAnswerModelArray[indexPath.row];
    
    NSInteger type = [questionModel.question_type_id integerValue];
    
    if (type == 1 || type == 4 || type == 5 || type == 8 || type == 12) {//普通题型
        YimaiExaminationCollectionForTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeOneIdentifier forIndexPath:indexPath];
        cell.questionModel = questionModel;
        cell.userAnswerModel = userAnswerModel;
        return cell;
    }
    
    if (type == 2 || type == 6 || type == 7 || type == 10 || type == 13) {//公用题干
        YimaiExaminationCollectionForTypeTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeTwoIdentifier forIndexPath:indexPath];
        cell.questionModel = self.sourceArray[indexPath.row];
        cell.userAnswerModel = userAnswerModel;
        return cell;
    }
    if (type == 3 || type == 9 || type == 14) {//公用备选答案
        YimaiExaminationCollectionForTypeThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeThreeIdentifier forIndexPath:indexPath];
        cell.questionModel = self.sourceArray[indexPath.row];
        cell.userAnswerModel = userAnswerModel;
        return cell;
    }
    if (type == 11) {//多选题
        YimaiExaminationCollectionForTypeFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeFourIdentifier forIndexPath:indexPath];
        cell.questionModel = self.sourceArray[indexPath.row];
        cell.userAnswerModel = userAnswerModel;
        return cell;
    }
    if (type == 15) {//案例分析题
        YimaiExaminationCollectionForTypeFiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeFiveIdentifier forIndexPath:indexPath];
        cell.questionModel = self.sourceArray[indexPath.row];
        cell.userAnswerModel = userAnswerModel;
        return cell;
    }
    //其它
    YimaiExaminationCollectionForTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:typeOneIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 存储未完成试卷数据
- (void)saveUnfinishExamDataFun
{
    NSInteger page = self.collectionView.contentOffset.x / kScreenWidth;
    
    NSString *index = [NSString stringWithFormat:@"%ld",page];
    
    [YimaiExaminationTool saveUnfinishExam:self.userResultModel paperid:self.paperid page:index];
}

- (NSMutableArray *)userAnswerModelArray
{
    if (_userAnswerModelArray == nil) {
        _userAnswerModelArray = [NSMutableArray array];
    }
    return _userAnswerModelArray;
}
@end
