//
//  YimaiExaminationParamModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/9.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取试题内容参数模型
 */
@interface YimaiExaminationParamModel : NSObject

@property (nonatomic, copy) NSString *a;

@property (nonatomic, copy) NSString *m;

@property (nonatomic, copy) NSString *bind;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *paperId;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *sign;

@end
