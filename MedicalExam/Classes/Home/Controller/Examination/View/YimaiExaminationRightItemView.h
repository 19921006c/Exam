//
//  YimaiExaminationRightItemView.h
//  DoctorPlatForm
//
//  Created by J on 16/8/23.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YimaiExaminationRightItemViewDelegate <NSObject>

@optional

- (void)didSelectedSubmitBtn;

- (void)didSelectedShareBtn;

@end
@interface YimaiExaminationRightItemView : UIView

+ (instancetype)view;

@property (nonatomic, weak) id<YimaiExaminationRightItemViewDelegate>delegate;

@end
