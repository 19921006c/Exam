//
//  YimaiExaminationNodeModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/17.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationNodeModel.h"
#import "YimaiExaminationQuestionModel.h"
@implementation YimaiExaminationNodeModel

- (void)setQuestion:(NSArray *)question
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSDictionary *dictionary in question) {
//        dictionary[@"correct_answer"] = @"A|B|C|D|E";
        YimaiExaminationQuestionModel *model = [YimaiExaminationQuestionModel objectWithKeyValues:dictionary];
        model.paper_node_name = self.paper_node_name;
        model.paper_node_desc = self.paper_node_desc;
        model.total = self.total;
        model.node_list_order = self.list_order;
        model.paper_id = self.paper_id;
        
        NSMutableArray *subTmpArray = [NSMutableArray array];
        FLOG(@"%@", model.question_type_id);
        for (NSDictionary *subDictionary in model.sub) {
            YimaiExaminationQuestionModel *subModel = [YimaiExaminationQuestionModel objectWithKeyValues:subDictionary];
            subModel.paper_node_name = model.paper_node_name;
            subModel.paper_node_desc = model.paper_node_desc;
            subModel.total = model.total;
            subModel.node_list_order = model.node_list_order;
            subModel.commonContent = model.content;
            subModel.paper_id = model.paper_id;
            subModel.content = [NSString stringWithFormat:@"%@、%@(%@分)",subModel.list_order,subModel.content,subModel.question_score];
            
//            if ([model.question_type_id isEqualToString:@"15"]) {
//                subModel.commonContent = [NSString stringWithFormat:@"%@%@",model.content,subModel.tips];
//            }
            [subTmpArray addObject:subModel];
        }
        
        model.content = [NSString stringWithFormat:@"%@、%@(%@分)",model.list_order,model.content,model.question_score];
        
        model.sub = subTmpArray;
        
        [tmpArray addObject:model];
    }
    _question = tmpArray;
    
}
//@property (nonatomic, copy) NSString *paper_node_id;
//@property (nonatomic, copy) NSString *paper_id;
//@property (nonatomic, copy) NSString *paper_node_name;
//@property (nonatomic, copy) NSString *node_type_id;
//@property (nonatomic, copy) NSString *list_order;
//@property (nonatomic, copy) NSString *isdel;
//@property (nonatomic, copy) NSString *paper_node_desc;
//@property (nonatomic, copy) NSString *total;
//@property (nonatomic, strong) NSArray *question;
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.paper_node_id forKey:@"paper_node_id"];
    [aCoder encodeObject:self.paper_id forKey:@"paper_id"];
    [aCoder encodeObject:self.paper_node_name forKey:@"paper_node_name"];
    [aCoder encodeObject:self.node_type_id forKey:@"node_type_id"];
    [aCoder encodeObject:self.list_order forKey:@"list_order"];
    [aCoder encodeObject:self.isdel forKey:@"isdel"];
    [aCoder encodeObject:self.paper_node_desc forKey:@"paper_node_desc"];
    [aCoder encodeObject:self.total forKey:@"total"];
    [aCoder encodeObject:self.question forKey:@"question"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.paper_node_id = [aDecoder decodeObjectForKey:@"paper_node_id"];
        self.paper_id = [aDecoder decodeObjectForKey:@"paper_id"];
        self.paper_node_name = [aDecoder decodeObjectForKey:@"paper_node_name"];
        self.node_type_id = [aDecoder decodeObjectForKey:@"node_type_id"];
        self.list_order = [aDecoder decodeObjectForKey:@"list_order"];
        self.isdel = [aDecoder decodeObjectForKey:@"isdel"];
        self.paper_node_desc = [aDecoder decodeObjectForKey:@"paper_node_desc"];
        self.total = [aDecoder decodeObjectForKey:@"total"];
        _question = [aDecoder decodeObjectForKey:@"question"];
    }
    return self;
}
@end
