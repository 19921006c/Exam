//
//  YimaiUserAnswerModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/26.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiUserAnswerModel.h"
#import "NSString+Character.h"
@implementation YimaiUserAnswerModel

- (NSString *)answer
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *str in _indexArray) {
        
        
        [tmpArray addObject:[NSString characterWithIndex:[str integerValue]]];
    }
    
    return [tmpArray componentsJoinedByString:@"|"];
}

/*
 @property (nonatomic, assign) BOOL isFinish;
@property (nonatomic, assign) StateType state;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *common_id_str;
@property (nonatomic, copy) NSString *questionid;
@property (nonatomic, strong) NSMutableArray *sub;
@property (nonatomic, copy) NSString *answer;
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.isFinish forKey:@"isFinish"];
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.indexArray forKey:@"indexArray"];
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeObject:self.common_id_str forKey:@"common_id_str"];
    [aCoder encodeObject:self.questionid forKey:@"questionid"];
    [aCoder encodeObject:self.sub forKey:@"sub"];
    [aCoder encodeObject:self.answer forKey:@"answer"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.isFinish = [aDecoder decodeBoolForKey:@"isFinish"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        self.indexArray = [aDecoder decodeObjectForKey:@"indexArray"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.common_id_str = [aDecoder decodeObjectForKey:@"common_id_str"];
        self.questionid = [aDecoder decodeObjectForKey:@"questionid"];
        self.sub = [aDecoder decodeObjectForKey:@"sub"];
        self.answer = [aDecoder decodeObjectForKey:@"answer"];
    }
    return self;
}
@end
