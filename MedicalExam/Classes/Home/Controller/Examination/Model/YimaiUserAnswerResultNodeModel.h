//
//  YimaiUserAnswerResultNodeModel.h
//  DoctorPlatForm
//
//  Created by J on 16/8/29.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiUserAnswerResultNodeModel : NSObject<NSCoding>

@property (nonatomic, strong) NSMutableArray *node;

@property (nonatomic, copy) NSString *paper_id;

@end
