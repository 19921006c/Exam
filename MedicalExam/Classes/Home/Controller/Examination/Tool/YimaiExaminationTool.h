//
//  YimaiExaminationTool.h
//  DoctorPlatForm
//
//  Created by J on 16/5/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YimaiExaminationResultModel;
@class YimaiExaminationToolModel;
@class YimaiExaminationVersonModel;
@class YimaiUserAnswerResultNodeModel;
@interface YimaiExaminationTool : NSObject

+ (YimaiExaminationResultModel *)dataWithParams:(NSString *)params;

/**
 *  存储微博数据
 *
 *  @param exam 需要存储的字典
 */
+ (void)saveExam:(YimaiExaminationResultModel *)resutlModel;


/**
 *  查询是否有未答完试卷
 *
 *  @param paperid 试卷id
 */
+ (YimaiExaminationToolModel *)infoWithPaperid:(NSString *)paperid;

/**
 *  保存已答的试卷
 *
 *  @param array   要保存的数据
 *  @param paperid 试卷id
 */
+ (void)saveUnfinishExam:(YimaiUserAnswerResultNodeModel *)userAnswerNodeModel paperid:(NSString *)paperid page:(NSString *)page;

/**
 *  删除未答完试卷数据
 */
+ (void)deleteUnfinishExam:(NSString *)paperid;

/**
 *  查看是错题集
 */
+ (YimaiExaminationToolModel *)WrongInfoWithVersonModel:(YimaiExaminationVersonModel *)versonModel;

/**
 *  保存错题集
 */
+ (void)saveWrongExam:(NSArray *)array versonModel:(YimaiExaminationVersonModel *)versonModel page:(NSString *)page;
@end
