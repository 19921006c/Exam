//
//  YimaiMedicalExaminationParamModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiMedicalExaminationParamModel : NSObject

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *bind;

/**
 *  登录人id
 */
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *m;

/**
 *  function名称
 */
@property (nonatomic, copy) NSString *a;

#pragma mark 试题列表才需要传的参数
@property (nonatomic, copy) NSString *classId;

#pragma mark 弃用的参数
/**
 *  action名称
 */
@property (nonatomic, copy) NSString *c;


/**
 *  接口所需md5字符串  userid的值和   9ab41cc1bbef27fa4b5b7d4cbe17a75a 加密
 */
@property (nonatomic, copy) NSString *sign;

/**
 *  分类id
 */
@property (nonatomic, copy) NSString *classid;


/**
 *  分类等级
 */
@property (nonatomic, copy) NSString *level;

@end
