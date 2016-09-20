//
//  YimaiExaminationListClassModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//  试卷分类

#import <Foundation/Foundation.h>

@interface YimaiExaminationListClassModel : NSObject

@property (nonatomic, copy) NSString *class_id;

@property (nonatomic, copy) NSString *class_name;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *class_level;

@property (nonatomic, copy) NSString *isdel;

/**
 *  试卷数组
 */
@property (nonatomic, strong) NSMutableArray *data;

/**
 *  
 */
@property (nonatomic, assign) BOOL open;
@end
