//
//  YimaiMedicalExaminationScroeView.h
//  DoctorPlatForm
//
//  Created by silent on 16/4/20.
//  Copyright © 2016年 songzm. All rights reserved.
//  分数统计view

#import <UIKit/UIKit.h>

@class YimaiUserAnswerResultNodeModel;
@protocol YimaiMedicalExaminationScroeViewDelegate <NSObject>

@optional

- (void)scoreViewAddloading;

- (void)scoreViewRemoveLoading;

@end

@interface YimaiMedicalExaminationScroeView : UIView


@property (nonatomic, strong) YimaiUserAnswerResultNodeModel *userResultModel;
@property (nonatomic, assign) id<YimaiMedicalExaminationScroeViewDelegate> delegate;
@end
