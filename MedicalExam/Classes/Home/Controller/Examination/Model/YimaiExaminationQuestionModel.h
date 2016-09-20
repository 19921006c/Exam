//
//  YimaiExaminationQuestionModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YimaiExaminationFinishModel;
@interface YimaiExaminationQuestionModel : NSObject<NSCoding>

/**
 *  试题id
 */
@property (nonatomic, copy) NSString *question_id;
/**
 *  父题id
 */
@property (nonatomic, copy) NSString *pid;
/**
 *  提示题干
 */
@property (nonatomic, copy) NSString *tips;
/**
 *  题干
 */
@property (nonatomic, copy) NSString *content;
/**
 *  选项
 */
@property (nonatomic, copy) NSString *select_answer;
/**
 *  试题分值
 */
@property (nonatomic, copy) NSString *question_score;
/**
 *  试题分析
 */
@property (nonatomic, copy) NSString *question_analysis;
/**
 *  试题排序
 */
@property (nonatomic, copy) NSString *list_order;
/**
 *  正确答案
 */
@property (nonatomic, copy) NSString *correct_answer;
/**
 *  试题类型id
 */
@property (nonatomic, copy) NSString *question_type_id;
/**
 *  删除标记：<0 不显示 >50 显示
 */
@property (nonatomic, copy) NSString *isdel;
/**
 *  根据question_type_id判断=2,6,7,10,13,15(哪些题的共用题干);=3,9,14（共用备选答案的题号）
 */
@property (nonatomic, copy) NSString *common_id_str;

@property (nonatomic, strong) NSArray *sub;

#pragma mark - 扩展字段，用于错题集
@property (nonatomic, strong) NSString *answer_option;

/**
 *  放answer_option数组
 */
@property (nonatomic, strong) NSArray *answer_option_array;
#pragma mark - 接口外自己扩展字断，拿出上一层model种的数据，放入次model中

/**
 *  试卷节点名称
 */
@property (nonatomic, copy) NSString *paper_node_name;
/**
 *  节点说明
 */
@property (nonatomic, copy) NSString *paper_node_desc;

@property (nonatomic, copy) NSString *total;

@property (nonatomic, copy) NSString *node_list_order;

@property (nonatomic, strong) NSMutableArray *select_answer_array;

@property (nonatomic, strong) NSMutableArray *correct_answer_array;

@property (nonatomic, copy) NSString *commonContent;

@property (nonatomic, copy) NSString *paper_id;

/**
 *  自定义的题型顺序
 */
@property (nonatomic, assign) NSInteger customListOrder;

/**
 {
 question_id: "42117",
 pid: "0",
 tips: "",
 content: "初孕妇，26岁，妊娠40周，入院前1日出现不规律子宫收缩，入院24小时后静滴缩宫素引产，第一产程5小时，第二产程10分钟，胎儿娩出后2分钟，产妇突然出现寒战，咳嗽，发绀，血压60/40mmHg，随后阴道流血不止，立即配血进行抢救。",
 select_answer: "",
 question_score: "1",
 question_analysis: "",
 list_order: "4",
 correct_answer: "",
 question_type_id: "2",
 isdel: "51",
 common_id_str: "4",
 sub: []
 }
 */

@end
