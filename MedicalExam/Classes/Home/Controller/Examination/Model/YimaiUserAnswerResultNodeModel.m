//
//  YimaiUserAnswerResultNodeModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/29.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiUserAnswerResultNodeModel.h"

@implementation YimaiUserAnswerResultNodeModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.node forKey:@"node"];
    [aCoder encodeObject:self.paper_id forKey:@"paper_id"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.node = [aDecoder decodeObjectForKey:@"node"];
        self.paper_id = [aDecoder decodeObjectForKey:@"paper_id"];
    }
    return self;
}

@end
