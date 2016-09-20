//
//  YimaiExaminationAnswerModel.m
//  DoctorPlatForm
//
//  Created by J on 16/8/19.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationAnswerModel.h"

@implementation YimaiExaminationAnswerModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.answer forKey:@"answer"];
    [aCoder encodeBool:self.is_Correct forKey:@"is_Correct"];
    [aCoder encodeObject:self.index forKey:@"index"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.answer = [aDecoder decodeObjectForKey:@"answer"];
        self.is_Correct = [aDecoder decodeBoolForKey:@"is_Correct"];
        self.index = [aDecoder decodeObjectForKey:@"index"];
    }
    return self;
}

@end
