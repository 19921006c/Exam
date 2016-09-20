



//
//  YimaiExamCacheTool.m
//  DoctorPlatForm
//
//  Created by 张志豪 on 16/6/21.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExamCacheTool.h"
#import "YYCache.h"
static NSString *cacheName = @"YimaiExamCache";
@implementation YimaiExamCacheTool
+ (void)setDataObject:(id)object forKey:(NSString *)key
{
    YYCache *cache = [[YYCache alloc]initWithName:cacheName];
    [cache setObject:object forKey:key];
}
+ (id)objectForKey:(NSString *)key
{
    YYCache *cache = [[YYCache alloc]initWithName:cacheName];
    return [cache objectForKey:key];
}
@end
