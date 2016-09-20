//
//  YimaiStatisticalNetworkerror.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 16/5/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiStatisticalNetworkerror : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,strong)NSMutableArray *arr;

//
- (NSString *)getPlistPath;
//
- (void)saveDataByPlist;
//
- (void)insertObject:(NSDictionary *)dict;

@end
