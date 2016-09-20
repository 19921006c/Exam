//
//  CustomAFHTTPSessionManager.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-13.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CustomAFHTTPSessionManager : AFHTTPSessionManager

typedef void(^successBlock)(id json);
typedef void(^failureBlock)(NSError *error);
+ (instancetype)manager;
+ (NSString *)getRsaKey;
- (NSURLSessionDataTask *)postWithUrl:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(successBlock)success failure:(failureBlock)failure;
@end
