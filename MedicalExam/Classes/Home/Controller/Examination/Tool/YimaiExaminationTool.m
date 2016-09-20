//
//  YimaiExaminationTool.m
//  DoctorPlatForm
//
//  Created by J on 16/5/18.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationTool.h"
#import "FMDB.h"
#import "YimaiExaminationResultModel.h"
//#import "YimaiExaminationDataModel.h"
#import "DoctorIdenTool.h"
#import "YimaiExaminationToolModel.h"
#import "YimaiExaminationVersonModel.h"
#import "YimaiUserAnswerResultNodeModel.h"
@implementation YimaiExaminationTool

static FMDatabase *_db;

+ (void)initialize
{
    //1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MedicalExamination.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    
    //2.创建试卷缓存表  blob 存储二进制数据
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_MedicalExamination (id integer PRIMARY KEY, exam blob NOT NULL, paperid text NOT NULL, update_time text NOT NULL);"];
    
    //创建未答完试卷表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UnfinishMedicalExamination (id integer PRIMARY KEY, exam blob NOT NULL, paperid text NOT NULL, userid text NOT NULL, page text NOT NULL);"];
    
    //创建错题集表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_WrongMedicalExamination (id integer PRIMARY KEY, exam blob NOT NULL, paperid text NOT NULL, userid text NOT NULL, update_time text NOT NULL, page text NOT NULL);"];
}

//查询是否有试卷缓存
+ (YimaiExaminationResultModel *)dataWithParams:(NSString *)params
{
    //根据请求参数生成对应的查询SQL语句
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_MedicalExamination WHERE paperid = %@",params];
    
    //执行sql语句
    FMResultSet *set = [_db executeQuery:sql];
    
    NSDictionary *dictionary = nil;
    
    YimaiExaminationResultModel  *resultModel = nil;
    
    while ([set next]) {
        NSData *data = [set objectForColumnName:@"exam"];
        
        dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        resultModel = [YimaiExaminationResultModel objectWithKeyValues:dictionary];
    }
    
    return resultModel;
}

+ (void)saveExam:(NSDictionary *)responseObject
{
    // 将对象存进数据库的blob字段，最好将对象转成nsdata

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_MedicalExamination(exam, paperid, update_time) VALUES (%@, %@, %@);",data,responseObject[@"paper_id"],responseObject[@"update_time"]];
}



//查询是否有未答完试卷
+ (YimaiExaminationToolModel *)infoWithPaperid:(NSString *)paperid
{
    //根据请求参数生成对应的查询SQL语句
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_UnfinishMedicalExamination WHERE paperid = %@ and userid = %@",paperid,kUserId];
    
    
    //执行sql语句
    FMResultSet *set = [_db executeQuery:sql];
    
    YimaiExaminationToolModel *model = [[YimaiExaminationToolModel alloc] init];
    
    while ([set next]) {
        NSData *data = [set objectForColumnName:@"exam"];
        
        model.page = [set objectForColumnName:@"page"];
        
        model.resultModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }
    return model;
}

+ (void)saveUnfinishExam:(YimaiUserAnswerResultNodeModel *)userAnswerNodeModel paperid:(NSString *)paperid page:(NSString *)page
{
    YimaiExaminationToolModel *model = [YimaiExaminationTool infoWithPaperid:paperid];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userAnswerNodeModel];
    
    if (model.resultModel) {//有未答完的试卷
        [_db executeUpdateWithFormat:@"UPDATE t_UnfinishMedicalExamination SET exam = %@, page = %@ WHERE paperid = %@ and userid = %@;",data,page,paperid,kUserId];
    } else{//没有未答完的试卷
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userAnswerNodeModel];
        
        [_db executeUpdateWithFormat:@"INSERT INTO t_UnfinishMedicalExamination(exam, paperid, userid, page) VALUES (%@, %@, %@, %@);",data,paperid,kUserId,page];
    }
    
}

/**
 *  删除未答完试卷数据
 */
+ (void)deleteUnfinishExam:(NSString *)paperid
{
    NSString *sql = [NSString stringWithFormat:@"delete from t_UnfinishMedicalExamination where paperid = %@ and userid = %@",paperid,kUserId];
    
    [_db executeUpdate:sql];
}

////查看是否有错题集
//+ (YimaiExaminationToolModel *)WrongInfoWithVersonModel:(YimaiExaminationVersonModel *)versonModel
//{
//    //根据请求参数生成对应的查询SQL语句
//    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_WrongMedicalExamination WHERE paperid = %@ and userid = %@ and update_time = %@",versonModel.paperid,[DoctorInfo doctorInfo].pid,versonModel.update_time];
//    
//    //执行sql语句
//    FMResultSet *set = [_db executeQuery:sql];
//    
//    YimaiExaminationToolModel *model = [[YimaiExaminationToolModel alloc] init];
//    
//    while ([set next]) {
//        NSData *data = [set objectForColumnName:@"exam"];
//        
//        model.page = [set objectForColumnName:@"page"];
//        
//        model.sourceArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        
//    }
//    return model;
//}
//
//+ (void)saveWrongExam:(NSArray *)array versonModel:(YimaiExaminationVersonModel *)versonModel page:(NSString *)page
//{
//    YimaiExaminationToolModel *model = [YimaiExaminationTool WrongInfoWithVersonModel:versonModel];
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
//    
//    if (model.sourceArray) {//有未答完的试卷
//        [_db executeUpdateWithFormat:@"UPDATE t_WrongMedicalExamination SET exam = %@, page = %@ ,update_time = %@ WHERE paperid = %@ and userid = %@;",data,page,versonModel.update_time,versonModel.paperid,[DoctorInfo doctorInfo].pid];
//    } else{//没有未答完的试卷
//        
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
//        
//        [_db executeUpdateWithFormat:@"INSERT INTO t_WrongMedicalExamination(exam, paperid, userid,update_time, page) VALUES (%@, %@, %@, %@, %@);",data,versonModel.paperid,[DoctorInfo doctorInfo].pid,versonModel.update_time,page];
//    }
//}

@end
