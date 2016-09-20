//
//  YimaiExaminationResultModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取试题内容结果模型
 */
@interface YimaiExaminationResultModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *share_img;
@property (nonatomic, copy) NSString *share_title;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *paper_id;
@property (nonatomic, copy) NSString *paper_name;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *pass_score;
@property (nonatomic, copy) NSString *total_score;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *paper_status;
@property (nonatomic, copy) NSString *isdel;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray *node;

#pragma mark - 自己扩展字段
@property (nonatomic, assign) NSInteger total_NSInteger;

/**
 *  
 {
 code: 10000,
 msg: "成功",
 userId: 1,
 share_img: "http://xs3.op.xywy.com/yimai.api.xywy.com/medicine/3d6be0da307e2dbb88b443dcd545c157?",
 share_title: "医学试题值得关注",
 share_url: "http://test.yimai.api.xywy.com/1.3/index.interface.php?a=medicine&m=paperClass",
 paper_id: "308",
 paper_name: "测试试卷",
 class_id: "101",
 pass_score: "10",
 total_score: "15",
 create_time: "1470989361",
 update_time: "1470989361",
 paper_status: "1",
 isdel: "51",
 node: []
 }
 */

@end
