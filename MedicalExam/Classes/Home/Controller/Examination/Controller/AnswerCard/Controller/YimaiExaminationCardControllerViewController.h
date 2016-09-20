//
//  YimaiExaminationCardControllerViewController.h
//  DoctorPlatForm
//
//  Created by J on 16/8/22.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "BasicViewController.h"

@protocol YimaiExaminationCardControllerViewControllerDelegate <NSObject>

@optional
- (void)slideToPosition:(int)index;

@end
@class YimaiUserAnswerResultNodeModel;
@interface YimaiExaminationCardControllerViewController : BasicViewController

@property (nonatomic, strong) YimaiUserAnswerResultNodeModel *userResultModel;
@property (nonatomic, weak) id<YimaiExaminationCardControllerViewControllerDelegate>delegate;
@end
