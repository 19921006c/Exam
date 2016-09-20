//
//  YimaiExaminationListDataModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//  试卷名称模型

#import <Foundation/Foundation.h>

@interface YimaiExaminationListDataModel : NSObject

/**
 *  试卷id
 */
@property (nonatomic, copy) NSString *paper_id;

@property (nonatomic, copy) NSString *paper_name;

@property (nonatomic, copy) NSString *class_id;

@property (nonatomic, copy) NSString *pass_score;

@property (nonatomic, copy) NSString *total_score;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *paper_status;

@property (nonatomic, copy) NSString *isdel;

@property (nonatomic, copy) NSString *audit_man_id;

@end
