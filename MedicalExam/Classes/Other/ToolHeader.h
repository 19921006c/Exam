//
//  ToolHeader.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-15.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#ifndef DoctorPlatForm_ToolHeader_h
#define DoctorPlatForm_ToolHeader_h


#ifdef DEBUG
#define FLOG(str, args...) NSLog(@"\t[%s][%d][%s]  %@", strrchr(__FILE__, '/'), __LINE__, sel_getName(_cmd), [NSString stringWithFormat:str , ##args])
//#define FLOG(fmt,...)    NSLog((@"[%@][%d] " fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,##__VA_ARGS__)
#else
#define FLOG(str, args...) ((void)0)
#endif


#endif
