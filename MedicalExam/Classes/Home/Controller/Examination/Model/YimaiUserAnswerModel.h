//
//  YimaiUserAnswerModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/26.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    StateNone,
    StateTrue,
    StateFalse,
} StateType;
@interface YimaiUserAnswerModel : NSObject<NSCoding>

/**
 *  是否答完题
 */
@property (nonatomic, assign) BOOL isFinish;
/**
 *  是否正确
 */
@property (nonatomic, assign) StateType state;

/**
 *  答案0,1,2,3,4
 */
//@property (nonatomic, assign) NSInteger index;

/**
 *  多选题答案数组
 */
@property (nonatomic, strong) NSMutableArray *indexArray;
/**
 *  获得分数
 */
@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *common_id_str;

@property (nonatomic, copy) NSString *questionid;

@property (nonatomic, strong) NSMutableArray *sub;

@property (nonatomic, copy) NSString *answer;
@end
