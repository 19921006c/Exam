//
//  YimaiExaminationHeaderCellDescriptionView.h
//  DoctorPlatForm
//
//  Created by J on 16/5/20.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YimaiExaminationHeaderCellDescriptionViewBlock)(void);
@interface YimaiExaminationHeaderCellDescriptionView : UIView

@property (nonatomic, copy) YimaiExaminationHeaderCellDescriptionViewBlock block;

@property (nonatomic, copy) NSString *paper_node_desc;

@end
