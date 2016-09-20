//
//  YimaiStatisticalNetworkerror.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 16/5/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiStatisticalNetworkerror.h"

@implementation YimaiStatisticalNetworkerror


+ (instancetype)shareInstance
{
    static YimaiStatisticalNetworkerror *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

-(NSString*)getPlistPath{
    //沙盒中的文件路径
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"DoctorNetWorkError.plist"];
    
    //根据需要更改文件名
    NSLog(@"plistPath====%@",plistPath);
    NSFileManager *fileman = [NSFileManager defaultManager];
    if ([fileman fileExistsAtPath:plistPath]) {
        FLOG(@"存在");
    }else{
        FLOG(@"不存在");
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
    }
    return plistPath;
}


- (void)saveDataByPlist
{
    NSString *path = [self getPlistPath];
//    self.arr = @[@"1",@"2,",@"3"];
    NSLog(@"self.arr---%@",self.arr);
    if ([self.arr writeToFile:path atomically:YES]) {
        FLOG(@"saveDataByPlist");
    }else{
        FLOG(@"saveDataByPlisterrrrrpr");
    }
}

- (void)insertObject:(NSDictionary *)dict
{
    [self.arr addObject:dict];
}

- (NSMutableArray *)arr
{
    if (_arr == nil) {
        NSString *str = [self getPlistPath];
        _arr = [NSMutableArray arrayWithContentsOfFile:str];
        if (_arr == nil) {
            _arr= [NSMutableArray array];
        }
    }
    return _arr;
}

@end
