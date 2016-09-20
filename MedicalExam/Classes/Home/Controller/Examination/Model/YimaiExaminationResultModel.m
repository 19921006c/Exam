//
//  YimaiExaminationResultModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationResultModel.h"
#import "YimaiExaminationNodeModel.h"
@implementation YimaiExaminationResultModel

- (void)setTotal:(NSString *)total
{
    _total_NSInteger = [total integerValue];
    
    _total = total;
}

- (void)setNode:(NSArray *)node{
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSDictionary *dictionary in node) {
        YimaiExaminationNodeModel *model = [YimaiExaminationNodeModel objectWithKeyValues:dictionary];
        
        [tmpArray addObject:model];
    }
    _node = [NSArray arrayWithArray:tmpArray];
}

/**
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
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.msg forKey:@"msg"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.share_img forKey:@"share_img"];
    [aCoder encodeObject:self.share_title forKey:@"share_title"];
    [aCoder encodeObject:self.share_url forKey:@"share_url"];
    [aCoder encodeObject:self.paper_id forKey:@"paper_id"];
    [aCoder encodeObject:self.paper_name forKey:@"paper_name"];
    [aCoder encodeObject:self.class_id forKey:@"class_id"];
    [aCoder encodeObject:self.pass_score forKey:@"pass_score"];
    [aCoder encodeObject:self.total_score forKey:@"total_score"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.update_time forKey:@"update_time"];
    [aCoder encodeObject:self.paper_status forKey:@"paper_status"];
    [aCoder encodeObject:self.isdel forKey:@"isdel"];
    [aCoder encodeObject:self.total forKey:@"total"];
    [aCoder encodeObject:self.node forKey:@"node"];
    [aCoder encodeInteger:self.total_NSInteger forKey:@"total_NSInteger"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.share_img = [aDecoder decodeObjectForKey:@"share_img"];
        self.share_title = [aDecoder decodeObjectForKey:@"share_title"];
        self.share_url = [aDecoder decodeObjectForKey:@"share_url"];
        self.paper_id = [aDecoder decodeObjectForKey:@"paper_id"];
        self.paper_name = [aDecoder decodeObjectForKey:@"paper_name"];
        self.class_id = [aDecoder decodeObjectForKey:@"class_id"];
        self.pass_score = [aDecoder decodeObjectForKey:@"pass_score"];
        self.total_score = [aDecoder decodeObjectForKey:@"total_score"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.update_time = [aDecoder decodeObjectForKey:@"update_time"];
        self.paper_status = [aDecoder decodeObjectForKey:@"paper_status"];
        self.isdel = [aDecoder decodeObjectForKey:@"isdel"];
        _total = [aDecoder decodeObjectForKey:@"total"];
        _node = [aDecoder decodeObjectForKey:@"node"];
        self.total_NSInteger = [aDecoder decodeIntegerForKey:@"total_NSInteger"];
    }
    return self;
}
@end
