//
//  YimaiUserAnswerNodeModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/26.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiUserAnswerNodeModel.h"

@implementation YimaiUserAnswerNodeModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.question forKey:@"question"];
    [aCoder encodeObject:self.paper_node_name forKey:@"paper_node_name"];
    [aCoder encodeObject:self.node_type_id forKey:@"node_type_id"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.question = [aDecoder decodeObjectForKey:@"question"];
        self.paper_node_name = [aDecoder decodeObjectForKey:@"paper_node_name"];
        self.node_type_id = [aDecoder decodeObjectForKey:@"node_type_id"];
    }
    return self;
}

@end
