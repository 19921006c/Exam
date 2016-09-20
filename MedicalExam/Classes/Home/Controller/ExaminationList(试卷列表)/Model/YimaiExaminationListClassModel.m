//
//  YimaiExaminationListClassModel.m
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationListClassModel.h"
#import "YimaiExaminationListDataModel.h"
@implementation YimaiExaminationListClassModel

- (void)setData:(NSMutableArray *)data
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (NSDictionary *dataDic in data) {
        
        YimaiExaminationListDataModel *dataModel = [YimaiExaminationListDataModel objectWithKeyValues:dataDic];
        
        [tmpArr addObject:dataModel];
    }
    
    _data = tmpArr;
}

@end
