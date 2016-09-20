//
//  YimaiMedicalExaminationDataModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiMedicalExaminationDataModel : NSObject

/**
 *  分类id
 */
@property (nonatomic, copy) NSString *class_id;

/**
 *  试卷类型名称
 */
@property (nonatomic, copy) NSString *class_name;

/**
 *  父类id
 */
@property (nonatomic, copy) NSString *pid;

/**
 *  分类等级
 */
@property (nonatomic, copy) NSString *class_level;

/**
 *  删除标记
 */
@property (nonatomic, copy) NSString *isdel;

/**
 *  图片url
 */
@property (nonatomic, copy) NSURL *image;
@end
