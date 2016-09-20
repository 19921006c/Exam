//
//  YimaiExaminationToolModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YimaiUserAnswerResultNodeModel;
@interface YimaiExaminationToolModel : NSObject

@property (nonatomic, strong) YimaiUserAnswerResultNodeModel *resultModel;

@property (nonatomic, copy) NSString *page;

@end
