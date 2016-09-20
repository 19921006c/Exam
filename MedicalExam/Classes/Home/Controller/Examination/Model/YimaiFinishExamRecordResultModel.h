//
//  YimaiFinishExamRecordResultModel.h
//  DoctorPlatForm
//
//  Created by J on 16/5/16.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YimaiFinishExamRecordResultModel : NSObject


//{
//    "code": 10000,
//    "msg": "成功",
//    "score": 50,
//    "ispass": false,
//    "paperId": "87",
//    "userId": "1",
//    "answerTime": "8月23日11时22分",
//    "userRank": 1
//}

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *ispass;

@property (nonatomic, copy) NSString *paperId;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *answerTime;

@property (nonatomic, copy) NSString *userRank;


@end
