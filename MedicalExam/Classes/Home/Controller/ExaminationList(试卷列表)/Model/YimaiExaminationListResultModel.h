//
//  YimaiExaminationListResultModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/6.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiExaminationListResultModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSMutableArray *classArray;

@property (nonatomic, copy) NSString *share_title;

@property (nonatomic, copy) NSString *share_img;

@property (nonatomic, copy) NSString *share_url;
@end
