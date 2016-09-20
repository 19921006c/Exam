//
//  YimaiMedicalExaminationResultModel.m
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiMedicalExaminationResultModel.h"
#import "YimaiMedicalExaminationDataModel.h"
@implementation YimaiMedicalExaminationResultModel

- (void)setData:(NSArray *)data
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (NSDictionary *dataDic in data) {
        
        YimaiMedicalExaminationDataModel *dataModel = [YimaiMedicalExaminationDataModel objectWithKeyValues:dataDic];
        
        [tmpArr addObject:dataModel];
    }
    _data = tmpArr;
}


@end
