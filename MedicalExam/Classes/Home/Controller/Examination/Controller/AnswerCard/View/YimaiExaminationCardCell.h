//
//  YimaiExaminationCardCell.h
//  DoctorPlatForm
//
//  Created by J on 16/8/24.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YimaiUserAnswerModel;
@interface YimaiExaminationCardCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) YimaiUserAnswerModel *userAnswerModel;

@end
