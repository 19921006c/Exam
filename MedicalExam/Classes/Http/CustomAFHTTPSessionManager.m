//
//  CustomAFHTTPSessionManager.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-13.
//  Copyright (c) 2015年 songzm. All rights reserved.
//
#import "CustomAFHTTPSessionManager.h"
#import "Url.h"
#import <ImageIO/ImageIO.h>
#import "RSA.h"
#import <sys/sysctl.h>

//#import "YimaiStatisticalNetworkerror.h"

static NSMutableArray *updaImageArr;

@implementation CustomAFHTTPSessionManager



+ (instancetype)manager{
    static CustomAFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:BASE_URL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //设置头
        //[config setHTTPAdditionalHeaders:@{AFHttpHeadKey:[CustomAFHTTPSessionManager getRsaKey]}];
        //设置超时
        [config setTimeoutIntervalForRequest:20];
        [config setTimeoutIntervalForResource:20];
        //设置缓存
        manager=[[CustomAFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        //设置head
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setValue:[RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY] forHTTPHeaderField:AFHttpHeadKey];
//        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
//                                                          diskCapacity:50 * 1024 * 1024
//                                                              diskPath:nil];
//        [config setURLCache:cache];
//        //设置 cache数据
//        config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        
        [manager.requestSerializer setValue:currentLanguage forHTTPHeaderField:@"Accept-Language"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
        [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:{
                    FLOG(@"网络不通" );
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    FLOG(@"网络通过WIFI连接：");
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    FLOG(@"网络通过无线连接：");
                    break;
                }
                default:
                    break;
            }
            FLOG(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
    });
    return manager;
}

//post
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[CustomAFHTTPSessionManager manager].requestSerializer setValue:[RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY] forHTTPHeaderField:AFHttpHeadKey];
    [[CustomAFHTTPSessionManager manager].requestSerializer setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forHTTPHeaderField:AFUDIDKey];
//    AFNetworkReachabilityManager *reachability = self.reachabilityManager;
//    if (!reachability.isReachable)
//    {
//        if ([URLString isEqualToString:@"zhaopin/shoucang.interface.php"] || [URLString isEqualToString:@"shouce/index.interface.php"]) {
//            [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
//        }else{
//            //网络不行  使用缓存
//            self.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
//        }
//    }else{
//        [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
//    }
    FLOG(@"URLString==%@",URLString);
    FLOG(@"parameters==%@",parameters);
    FLOG(@"rsa--------%@", [RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY]);
    FLOG(@"KEY====%@", [CustomAFHTTPSessionManager manager].requestSerializer.HTTPRequestHeaders);
    NSURLSessionDataTask *sessionTask = [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *supertask, id superResponseObject1) {

        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:superResponseObject1 options:NSJSONReadingMutableContainers error:nil];
        
        success(supertask,[CommonTool nullDic:content]);
        
        
    }  failure:^(NSURLSessionDataTask *supertask, NSError *supererror){
//        NSDictionary *dict = @{@"method":@"get",
//                               @"url":[NSString stringWithFormat:@"%@%@",BASE_URL,URLString],
//                               @"params":parameters,
//                               @"error":supererror.localizedDescription,
//                               @"time":[self stringFromDate:[NSDate date]]};
//        [self getNetWorkError:dict];
        failure(supertask,supererror);
    }];
    return sessionTask;
}
//get请求
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[CustomAFHTTPSessionManager manager].requestSerializer setValue:[RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY] forHTTPHeaderField:AFHttpHeadKey];
    [[CustomAFHTTPSessionManager manager].requestSerializer setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forHTTPHeaderField:AFUDIDKey];
    [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    FLOG(@"URLString==%@",URLString);
    FLOG(@"parameters==%@",parameters);
    FLOG(@"rsa--------%@", [RSA encryptString:[CustomAFHTTPSessionManager getRsaKey] publicKey:RSAPUBLICKEY]);
    FLOG(@"GET---%@", [CustomAFHTTPSessionManager manager].requestSerializer.HTTPRequestHeaders);
    NSURLSessionDataTask *sessionTask=[super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *supertask, id superResponseObject1) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:superResponseObject1 options:NSJSONReadingMutableContainers error:nil];

        success(supertask,[CommonTool nullDic:content]);
    } failure:^(NSURLSessionDataTask *supertask, NSError *supererror){
//        NSDictionary *dict = @{@"method":@"get",
//                               @"url":[NSString stringWithFormat:@"%@%@",BASE_URL,URLString],
//                               @"params":@"",
//                               @"error":supererror.localizedDescription,
//                               @"time":[self stringFromDate:[NSDate date]]};
//        [self getNetWorkError:dict];
        failure(supertask,supererror);
    }];
    return sessionTask;
}
- (NSURLSessionDataTask *)postWithUrl:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(successBlock)success failure:(failureBlock)failure
{
    AFNetworkReachabilityManager *reachability = self.reachabilityManager;
    if (!reachability.isReachable)
    {
        if ([url isEqualToString:@"zhaopin/shoucang.interface.php"] || [url isEqualToString:@"shouce/index.interface.php"]) {
            [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
        }else{
            //网络不行  使用缓存
            self.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        }
    }else{
        [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    }
    FLOG(@"URLString==%@",url);
    FLOG(@"parameters==%@",params);
    NSURLSessionDataTask *sessionTask = [super POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 将图片转换为二进制
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"faker" mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            success(content);
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        if (failure) {
            failure(error);
        }

    }];
    return sessionTask;
}






-(void)dataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        FLOG(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        FLOG(@"得到的网络数据-->%@",jsonString);
    }
}


+ (NSString *)getRsaKey{
    
    NSString *string = nil;
    if (kUserId.length==0) {
        string = @"0";

    }else{
        string = kUserId;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *registerId;
    if ([defaults objectForKey:JPushRegistrationID] == nil || [[defaults objectForKey:JPushRegistrationID] isKindOfClass:[NSNull class]]) {
        registerId = @"";
    }else{
        registerId = [defaults objectForKey:JPushRegistrationID];
    }
    NSString *str = [NSString stringWithFormat:@"%@|%@|IOS%f|%@|%@|%@",string,[CustomAFHTTPSessionManager platformString],[[UIDevice currentDevice].systemVersion floatValue],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],@"",registerId];
    FLOG(@"HEADEEEEE======%@", str);
    return str;
}

//获取设备型号
+ (NSString *) platformString{
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);

        
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
    
}

//- (void)getNetWorkError:(NSDictionary *)dic
//{
//    YimaiStatisticalNetworkerror *shareInstance = [YimaiStatisticalNetworkerror shareInstance];
//    FLOG(@"error++dic----%@", dic);
//    [shareInstance insertObject:dic];
//    [shareInstance saveDataByPlist];
//}
//
//- (NSString *)stringFromDate:(NSDate *)date{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
//    NSString *destDateString = [dateFormatter stringFromDate:date];
//    return destDateString;
//}


@end
