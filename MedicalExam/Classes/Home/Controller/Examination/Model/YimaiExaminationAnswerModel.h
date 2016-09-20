//
//  YimaiExaminationAnswerModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/19.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiExaminationAnswerModel : NSObject<NSCoding>

/**
 *  答案内容
 */
@property (nonatomic, copy) NSString *answer;

/**
 *  是否是正确答案
 */
@property (nonatomic, assign) BOOL is_Correct;

/**
 *  答案序号
 */
@property (nonatomic, copy) NSString *index;
@end
