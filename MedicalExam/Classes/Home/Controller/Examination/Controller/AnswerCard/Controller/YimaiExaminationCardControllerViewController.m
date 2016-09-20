//
//  YimaiExaminationCardControllerViewController.m
//  DoctorPlatForm
//
//  Created by J on 16/8/22.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationCardControllerViewController.h"
#import "YimaiExaminationCardHeaderView.h"
#import "YimaiExaminationCardCell.h"

#import "YimaiUserAnswerModel.h"
#import "YimaiUserAnswerNodeModel.h"
#import "YimaiUserAnswerResultNodeModel.h"
@interface YimaiExaminationCardControllerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineImageViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 *  显示A型题，B型题，C型题label
 */
@property (nonatomic, strong) UILabel *questionTypeLabel;
@end

@implementation YimaiExaminationCardControllerViewController


static NSString *const identifier = @"YimaiExaminationCardCell";
static NSString *const identifierForHeader = @"YimaiExaminationCardHeaderView";
static NSString *const identifierForFooter = @"YimaiExaminationCardFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"答题卡";
    
    [self setlabelAttributes];
    
    [self setCollectionViewAttributes];
}

/**
 *  设置collection view
 */
- (void)setCollectionViewAttributes
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(36, 36);
    layout.minimumLineSpacing = 7;
    layout.minimumInteritemSpacing = 7;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 46);
    layout.footerReferenceSize = CGSizeMake(kScreenWidth, 10);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.collectionView registerNib:[UINib nibWithNibName:identifierForHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierForHeader];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierForFooter];
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    YimaiUserAnswerNodeModel *nodeModel = self.userResultModel.node[section];
    
    int count = 0;
    for (YimaiUserAnswerModel *userModel in nodeModel.question) {
        
        if (userModel.sub.count > 0) {
            for (YimaiUserAnswerModel *model in userModel.sub) {
                if (model) {
                    count += 1;
                }
            }
        }else{
            count += 1;
        }
    }
    return count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.userResultModel.node.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YimaiExaminationCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
//    YimaiExaminationNodeModel *nodeModel = self.resultModel.node[indexPath.section];
//    
//    NSMutableArray *tmpArray = [NSMutableArray array];
//    
//    for (YimaiExaminationQuestionModel *questionModel in nodeModel.question) {
//        if (questionModel.sub.count > 0) {
//            for (YimaiExaminationQuestionModel *model in questionModel.sub) {
//                [tmpArray addObject:model];
//            }
//        }else{
//            [tmpArray addObject:questionModel];
//        }
//    }
    
    YimaiUserAnswerNodeModel *nodeModel = self.userResultModel.node[indexPath.section];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (YimaiUserAnswerModel *userAnswerModel in nodeModel.question) {
        if (userAnswerModel.sub.count > 0) {
            for (YimaiUserAnswerModel *model in userAnswerModel.sub) {
                [tmpArray addObject:model];
            }
        }else{
            [tmpArray addObject:userAnswerModel];
        }
    }
    cell.userAnswerModel = tmpArray[indexPath.item];
    
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        YimaiExaminationCardHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierForHeader forIndexPath:indexPath];
        
        YimaiUserAnswerNodeModel *nodeModel = self.userResultModel.node[indexPath.section];
        
        header.label.text = nodeModel.paper_node_name;
        return header;
    }
    
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifierForFooter forIndexPath:indexPath];
    
    return footer;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int totalIndex = 0;
    for (int i = 0; i < indexPath.section; i ++) {
        YimaiUserAnswerNodeModel *nodeModel = self.userResultModel.node[i];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        for (YimaiUserAnswerModel *userAnswerModel in nodeModel.question) {
            if (userAnswerModel.sub.count > 0) {
                for (YimaiUserAnswerModel *model in userAnswerModel.sub) {
                    [tmpArray addObject:model];
                    totalIndex ++;
                }
            }else{
                [tmpArray addObject:userAnswerModel];
                totalIndex ++;
            }
        }
    }
    
    totalIndex += indexPath.item;
    
    if ([self.delegate respondsToSelector:@selector(slideToPosition:)]) {
        [self.delegate slideToPosition:totalIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setlabelAttributes
{
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"答题卡 (  错误  正确  未答 )           点击题号查看试题"];
    
    
    // 修改富文本中的不同文字的样式
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, 5)];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(5, 12)];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(18, 1)];
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(30, 8)];
    
    
    
    // 用label的attributedText属性来使用富文本
    // 添加表情
    NSTextAttachment *attch1 = [[NSTextAttachment alloc] init];
    // 表情图片
    attch1.image = [UIImage imageNamed:@"Exam_Card_False_min"];
    // 设置图片大小
    attch1.bounds = CGRectMake(0, -2, 12, 12);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch1];
    [attri insertAttributedString:string atIndex:6];
    
    // 添加表情
    NSTextAttachment *attch2 = [[NSTextAttachment alloc] init];
    // 表情图片
    attch2.image = [UIImage imageNamed:@"Exam_Card_Right_min"];
    // 设置图片大小
    attch2.bounds = CGRectMake(0, -2, 12, 12);
    
    // 创建带有图片的富文本
    NSAttributedString *string2 = [NSAttributedString attributedStringWithAttachment:attch2];
    [attri insertAttributedString:string2 atIndex:11];
    
    // 添加表情
    NSTextAttachment *attch3 = [[NSTextAttachment alloc] init];
    // 表情图片
    attch3.image = [UIImage imageNamed:@"Exam_Card_unfinish_min"];
    // 设置图片大小
    attch3.bounds = CGRectMake(0, -2, 12, 12);
    
    // 创建带有图片的富文本
    NSAttributedString *string3 = [NSAttributedString attributedStringWithAttachment:attch3];
    [attri insertAttributedString:string3 atIndex:16];
    
    self.label.attributedText = attri;
    
    self.lineImageViewHeight.constant = 0.5;
}

#pragma mark - lazy load

- (UILabel *)questionTypeLabel
{
    if (_questionTypeLabel == nil) {
        _questionTypeLabel = [[UILabel alloc]init];
        _questionTypeLabel.frame = CGRectMake(12, 10, kScreenWidth - 12 * 2, 12);
        _questionTypeLabel.font = [UIFont systemFontOfSize:12];
        _questionTypeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _questionTypeLabel.text = @"A型题";
    }
    return _questionTypeLabel;
}


@end