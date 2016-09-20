//
//  YimaiExaminationNodeModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  YimaiExaminationResultModel.node 字断model
 */
@interface YimaiExaminationNodeModel : NSObject<NSCoding>

/**
 *  试卷节点id
 */
@property (nonatomic, copy) NSString *paper_node_id;
/**
 *  试卷id
 */
@property (nonatomic, copy) NSString *paper_id;
/**
 *  试卷节点名称
 */
@property (nonatomic, copy) NSString *paper_node_name;
/**
 *  节点类型
 */
@property (nonatomic, copy) NSString *node_type_id;
/**
 *  题型序号
 */
@property (nonatomic, copy) NSString *list_order;
/**
 *  删除标记：<0 不显示 >50 显示
 */
@property (nonatomic, copy) NSString *isdel;
/**
 *  节点说明
 */
@property (nonatomic, copy) NSString *paper_node_desc;

/**
 *  节点下试题总数
 */
@property (nonatomic, copy) NSString *total;
/**
 *  试题数据体数组
 */
@property (nonatomic, strong) NSArray *question;

/*
{
paper_node_id: "862",
paper_id: "308",
paper_node_name: "A1/A2型题",
node_type_id: "1",
list_order: "1",
isdel: "51",
paper_node_desc: "每道试题由1个题干和5个供选择的备选答案组成。备选答案中只有1个是最佳选择，其余4个均为干扰答案。干扰答案或是完全不正确，或是部分正确。",
total: 1,
question: []
}
*/
@end
