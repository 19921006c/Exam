//
//  YimaiUserAnswerNodeModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/26.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YimaiUserAnswerNodeModel : NSObject<NSCoding>

@property (nonatomic, strong) NSMutableArray *question;

@property (nonatomic, copy) NSString *paper_node_name;

/**
 *  节点类型
 */
@property (nonatomic, copy) NSString *node_type_id;
@end
