//
//  FileName.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/7/3.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#ifndef DoctorPlatForm_FileName_h
#define DoctorPlatForm_FileName_h
#define kTag 501
// 拍照
#define kTakePicture @"takePicture"
// 认证信息入口
#define kDoctorCertify @"DoctorCer"
#define kStuToDocCertify @"stuToDoctorCer"
#define kFailStuToDoctorCertify @"failStuToDoctorCer"
#define kStuContinueDocCertify @"stuContinueDocCertify"
// 签到标识
#define kSignIn @"signIn"
#define kShareViewHeight 162
#define kChecking @"checking"

#define MD5STRING @"9ab41cc1bbef27fa4b5b7d4cbe17a75a"
typedef void (^CollectHandler)(id sender);

// 资讯页面
#define kConsultOnePath @"consult_1.arch"
#define kConsultTwoPath @"consult_2.arch"
#define kConsultThreePath @"consult_3.arch"
#define kConsultFourPath @"consult_4.arch"
#define kConsultFivePath @"consult_5.arch"
#define kConsultSixPath @"consult_6.arch"
#define kConsultSevenPath @"consult_7.arch"
#define kConsultEightPath @"consult_8.arch"
// 资讯子页面
#define kSubConsultOnePath @"consult_2_1.arch"
#define ksubConsultTwoPath @"consult_2_2.arch"
#define ksubConsultThreePath @"consult_2_3.arch"
#define ksubConsultFourPath @"consult_2_4.arch"
#define ksubConsultFivePath @"consult_2_5.arch"
// 检查手册
#define kChemistryPath @"chemistry.arch"
#define kTestPath @"test.arch"
#define kPhysicsPath @"physics.arch"
#define ArticlePath @"Article.arch"

// 药典
#define kChinaPath @"chinaPill.arch"
#define kWestPath @"westPill.arch"

// 收藏列表
#define kCollectedList @"CollectedList"
// 枚举
// 跳转积分充值页面来源
typedef enum {
    TradeScoreTypeScore = 0,   // 积分部分跳转
    TradeScoreTypeLoading = 1, // 文献下载部分跳转
} TradeScoreType;


#endif
