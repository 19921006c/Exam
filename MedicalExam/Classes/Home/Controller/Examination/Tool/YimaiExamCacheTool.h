//
//  YimaiExamCacheTool.h
//  DoctorPlatForm
//
//  Created by 张志豪 on 16/6/21.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiExamCacheTool : NSObject
//set
+ (void)setDataObject:(id)object forKey:(NSString *)key;
//get
+ (id)objectForKey:(NSString *)key;
@end
