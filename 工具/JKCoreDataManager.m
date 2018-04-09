//
//  JKCoreDataManager.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "JKCoreDataManager.h"
#import "CoreDataManager.h"
static JKCoreDataManager * _coreData = nil;
@implementation JKCoreDataManager

+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _coreData = [[self alloc] init];
    });
    return _coreData;
}

+(void)destroyInstance{
    if (_coreData) {
        _coreData = nil;
    }
}

#pragma mark - 问卷表

//==============================================================================
/*问卷表*/
//==============================================================================
/**
 *  创建问卷表信息
 *
 *  @return QlistModel
 */
-(QlistModel*)efCreateQlistModel{
//    创建新表
    QlistModel * model = (QlistModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KQlistModel];
    return  model;
}
/**
 *  获取所有问卷表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQlistModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQlistModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加问卷表到数据库
 *
 */

-(BOOL)efAddQlistModel:(QlistModel *)jQlistModel{
    
    BOOL isSuccess = NO;
    
    QlistModel * model = [self efGetQlistModelWithQlistModelId:jQlistModel.qID];
    
    if (jQlistModel) {
        
        if (!(jQlistModel == model)) {
            
            [self efDeleteQlistModel:model];
            
            model = jQlistModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
        NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据问卷表ID获取问卷表
 *  @ 问卷表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQlistModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qID = '%@'",modelId];
//    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQlistModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
//    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllQlistModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQlistModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据QlistModelID获取QlistModel信息
 *
 *  @ QlistModelId
 *
 *  @ return
 */

-(QlistModel *)efGetQlistModelWithQlistModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQlistModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        QlistModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateQlistModel];
}

/**
 *  删除问卷表信息
 *
 *  @ param QlistModel
 *
 *  @ return
 */
-(BOOL)efDeleteQlistModel:(QlistModel *)jQlistModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jQlistModel];
    
}

/**
 *  更新问卷表信息
 *
 *  @ param QlistModel
 *
 *  @ return
 */
-(BOOL)efUpdateQlistModel:(QlistModel *)jQlistModel{
    
    return  [self efAddQlistModel:jQlistModel];
    
}

/**
 *  清空所有问卷表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQlistModel{
    
    BOOL flag = YES;
    for (QlistModel * model in [self efGetAllQlistModel]) {
        
        if (![self efDeleteQlistModel:model]) {
            flag = NO;
        }
    }
    return flag;
}

#pragma mark - 题目表

//==============================================================================
/*题目表*/
//==============================================================================
/**
 *  创建题目表信息
 *
 *  @return QtittleModel
 */
-(QtittleModel*)efCreateQtittleModel{
    //    创建新表
    QtittleModel * model = (QtittleModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KQtittleModel];
    return  model;
}
/**
 *  获取所有题目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQtittleModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQtittleModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加题目表到数据库
 *
 */

-(BOOL)efAddQtittleModel:(QtittleModel *)jQtittleModel{
    
    BOOL isSuccess = NO;
    
    QtittleModel * model = [self efGetQtittleModelWithQtittleModelId:jQtittleModel.qID];
    
    if (jQtittleModel) {
        
        if (!(jQtittleModel == model)) {
            
            [self efDeleteQtittleModel:model];
            
            model = jQtittleModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
        NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据问卷表ID获取题目表
 *  @ 问卷表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQtittleModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qListID = '%@'",modelId];
    NSLog(@"conditionStr %@",conditionStr);
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQtittleModel condition:conditionStr sortByKey:@"qNumber" limit:100 ascending:YES];
    
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllQtittleModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQtittleModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据QtittleModelID获取QtittleModel信息
 *
 *  @ QtittleModelId
 *
 *  @ return
 */

-(QtittleModel *)efGetQtittleModelWithQtittleModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQtittleModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        QtittleModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateQtittleModel];
}

/**
 *  删除题目表信息
 *
 *  @ param QtittleModel
 *
 *  @ return
 */
-(BOOL)efDeleteQtittleModel:(QtittleModel *)jQtittleModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jQtittleModel];
    
}

/**
 *  更新题目表信息
 *
 *  @ param QtittleModel
 *
 *  @ return
 */
-(BOOL)efUpdateQtittleModel:(QtittleModel *)jQtittleModel{
    
    return  [self efAddQtittleModel:jQtittleModel];
    
}

/**
 *  清空所有题目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQtittleModel{
    
    BOOL flag = YES;
    for (QtittleModel * model in [self efGetAllQtittleModel]) {
        
        if (![self efDeleteQtittleModel:model]) {
            flag = NO;
        }
    }
    return flag;
}


#pragma mark - 答案表

//==============================================================================
/*答案表*/
//==============================================================================
/**
 *  创建答案表信息
 *
 *  @return QanswerModel
 */
-(QanswerModel*)efCreateQanswerModel{
    //    创建新表
    QanswerModel * model = (QanswerModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KQanswerModel];
    return  model;
}
/**
 *  获取所有答案表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQanswerModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQanswerModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加答案表到数据库
 *
 */

-(BOOL)efAddQanswerModel:(QanswerModel *)jQanswerModel{
    
    BOOL isSuccess = NO;
    
    QanswerModel * model = [self efGetQanswerModelWithQanswerModelId:jQanswerModel.qID];
    
    if (jQanswerModel) {
        
        if (!(jQanswerModel == model)) {
            
            [self efDeleteQanswerModel:model];
            
            model = jQanswerModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据题目ID获取答案表
 *  @ 题目ID
 *  @ return
 */

-(NSMutableArray *)efGetAllQanswerModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qTittleID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQanswerModel condition:conditionStr sortByKey:@"qIndex" limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllQanswerModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQanswerModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据QanswerModelID获取QanswerModel信息
 *
 *  @ QanswerModelId
 *
 *  @ return
 */

-(QanswerModel *)efGetQanswerModelWithQanswerModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQanswerModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        QanswerModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateQanswerModel];
}

/**
 *  删除答案表信息
 *
 *  @ param QanswerModel
 *
 *  @ return
 */
-(BOOL)efDeleteQanswerModel:(QanswerModel *)jQanswerModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jQanswerModel];
    
}

/**
 *  更新答案表信息
 *
 *  @ param QanswerModel
 *
 *  @ return
 */
-(BOOL)efUpdateQanswerModel:(QanswerModel *)jQanswerModel{
    
    return  [self efAddQanswerModel:jQanswerModel];
    
}

/**
 *  清空所有答案表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQanswerModel{
    
    BOOL flag = YES;
    for (QanswerModel * model in [self efGetAllQanswerModel]) {
        
        if (![self efDeleteQanswerModel:model]) {
            flag = NO;
        }
    }
    return flag;
}


#pragma mark - 学校表

//==============================================================================
/*学校表*/
//==============================================================================
/**
 *  创建学校表信息
 *
 *  @return SchoolModel
 */
-(SchoolModel*)efCreateSchoolModel{
    //    创建新表
    SchoolModel * model = (SchoolModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KSchoolModel];
    return  model;
}
/**
 *  获取所有学校表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllSchoolModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KSchoolModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加学校表到数据库
 *
 */

-(BOOL)efAddSchoolModel:(SchoolModel *)jSchoolModel{
    
    BOOL isSuccess = NO;
    
    SchoolModel * model = [self efGetSchoolModelWithSchoolModelId:jSchoolModel.qID];
    
    if (jSchoolModel) {
        
        if (!(jSchoolModel == model)) {
            
            [self efDeleteSchoolModel:model];
            
            model = jSchoolModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据学校表ID获取学校表
 *  @ 学校表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllSchoolModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KSchoolModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllSchoolModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KSchoolModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据SchoolModelID获取SchoolModel信息
 *
 *  @ SchoolModelId
 *
 *  @ return
 */

-(SchoolModel *)efGetSchoolModelWithSchoolModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KSchoolModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        SchoolModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateSchoolModel];
}

/**
 *  删除学校表信息
 *
 *  @ param SchoolModel
 *
 *  @ return
 */
-(BOOL)efDeleteSchoolModel:(SchoolModel *)jSchoolModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jSchoolModel];
    
}

/**
 *  更新学校表信息
 *
 *  @ param SchoolModel
 *
 *  @ return
 */
-(BOOL)efUpdateSchoolModel:(SchoolModel *)jSchoolModel{
    
    return  [self efAddSchoolModel:jSchoolModel];
    
}

/**
 *  清空所有学校表
 *
 *  @ return
 */
-(BOOL)efDeleteAllSchoolModel{
    
    BOOL flag = YES;
    for (SchoolModel * model in [self efGetAllSchoolModel]) {
        
        if (![self efDeleteSchoolModel:model]) {
            flag = NO;
        }
    }
    return flag;
}


#pragma mark - 基地表

//==============================================================================
/*基地表*/
//==============================================================================
/**
 *  创建基地表信息
 *
 *  @return JKbase
 */
-(JKbase*)efCreateJKbase{
    //    创建新表
    JKbase * model = (JKbase*)[[CoreDataManager shareInstance] CreateObjectWithTable:KJKbase];
    return  model;
}
/**
 *  获取所有基地表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllJKbase{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KJKbase sortByKey:nil];
    return ModelArr;
}

/**
 *  添加基地表到数据库
 *
 */

-(BOOL)efAddJKbase:(JKbase *)jJKbase{
    
    BOOL isSuccess = NO;
    
    JKbase * model = [self efGetJKbaseWithJKbaseId:jJKbase.qID];
    
    if (jJKbase) {
        
        if (!(jJKbase == model)) {
            
            [self efDeleteJKbase:model];
            
            model = jJKbase;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据基地表ID获取基地表
 *  @ 基地表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllJKbaseWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KJKbase condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllJKbaseWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KJKbase condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据JKbaseID获取JKbase信息
 *
 *  @ JKbaseId
 *
 *  @ return
 */

-(JKbase *)efGetJKbaseWithJKbaseId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KJKbase condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        JKbase *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateJKbase];
}

/**
 *  删除基地表信息
 *
 *  @ param JKbase
 *
 *  @ return
 */
-(BOOL)efDeleteJKbase:(JKbase *)jJKbase{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jJKbase];
    
}

/**
 *  更新基地表信息
 *
 *  @ param JKbase
 *
 *  @ return
 */
-(BOOL)efUpdateJKbase:(JKbase *)jJKbase{
    
    return  [self efAddJKbase:jJKbase];
    
}

/**
 *  清空所有基地表
 *
 *  @ return
 */
-(BOOL)efDeleteAllJKbase{
    
    BOOL flag = YES;
    for (JKbase * model in [self efGetAllJKbase]) {
        
        if (![self efDeleteJKbase:model]) {
            flag = NO;
        }
    }
    return flag;
}


#pragma mark - 已答问题表

//==============================================================================
/*已答问题表*/
//==============================================================================
/**
 *  创建已答问题表信息
 *
 *  @return ResListModel
 */
-(ResListModel*)efCreateResListModel{
    //    创建新表
    ResListModel * model = (ResListModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KResListModel];
    return  model;
}
/**
 *  获取所有已答问题表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllResListModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResListModel sortByKey:nil];
    
    return ModelArr;
}

/**
 *  添加已答问题表到数据库
 *
 */

-(BOOL)efAddResListModel:(ResListModel *)jResListModel{
    
    BOOL isSuccess = NO;
    
    ResListModel * model = [self efGetResListModelWithResListModelId:jResListModel.qID];
    
    if (jResListModel) {
        
        if (!(jResListModel == model)) {
            
            [self efDeleteResListModel:model];
            
            model = jResListModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据已答问题表ID获取已答问题表
 *  @ 已答问题表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllResListModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResListModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}


//@property (nullable, nonatomic, copy) NSString *qID;
//@property (nullable, nonatomic, copy) NSString *qName;
//@property (nullable, nonatomic, copy) NSString *qSchoolTittle;
//@property (nullable, nonatomic, copy) NSString *qSchoolID;
//@property (nullable, nonatomic, copy) NSString *qBaseID;
//@property (nullable, nonatomic, copy) NSString *qBaseName;
//@property (nullable, nonatomic, copy) NSString *qQuTittle;
//@property (nullable, nonatomic, copy) NSString *qQuID;
//@property (nullable, nonatomic, copy) NSString *qClassID;
//@property (nullable, nonatomic, copy) NSString *qClassName;
//@property (nullable, nonatomic, copy) NSString *qObjectID;
//@property (nullable, nonatomic, copy) NSString *qObjectName;
//@property (nullable, nonatomic, copy) NSDate *qTime;
/**
 *  筛选查询
 *  @ 查询字段  base   school  class  object
 *  @ return
 */

-(NSMutableArray *)efSearchAllResListModelWithBaseID:(NSString*)baseID SchoolID:(NSString*)schoolID ClassID:(NSString*)classID ObjectID:(NSString*)objectID{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qBaseID LIKE '*%@*' and qSchoolID LIKE '*%@*' and qClassID LIKE '*%@*' and qObjectID LIKE '*%@*') ",baseID,schoolID,classID,objectID];
    
    NSLog(@"conditionStr  %@",conditionStr);
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResListModel condition:conditionStr sortByKey:@"qTime" limit:10000 ascending:YES];
    
    return modelArr;
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllResListModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResListModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据ResListModelID获取ResListModel信息
 *
 *  @ ResListModelId
 *
 *  @ return
 */

-(ResListModel *)efGetResListModelWithResListModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResListModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        ResListModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateResListModel];
}

/**
 *  删除已答问题表信息
 *
 *  @ param ResListModel
 *
 *  @ return
 */
-(BOOL)efDeleteResListModel:(ResListModel *)jResListModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jResListModel];
    
}

/**
 *  更新已答问题表信息
 *
 *  @ param ResListModel
 *
 *  @ return
 */
-(BOOL)efUpdateResListModel:(ResListModel *)jResListModel{
    
    return  [self efAddResListModel:jResListModel];
    
}

/**
 *  清空所有已答问题表
 *
 *  @ return
 */
-(BOOL)efDeleteAllResListModel{
    
    BOOL flag = YES;
    for (ResListModel * model in [self efGetAllResListModel]) {
        
        if (![self efDeleteResListModel:model]) {
            flag = NO;
        }
    }
    return flag;
}

#pragma mark - 已答题目表

//==============================================================================
/*已答题目表*/
//==============================================================================
/**
 *  创建已答题目表信息
 *
 *  @return RestittleModel
 */
-(RestittleModel*)efCreateRestittleModel{
    //    创建新表
    RestittleModel * model = (RestittleModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KRestittleModel];
    return  model;
}
/**
 *  获取所有已答题目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllRestittleModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KRestittleModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加已答题目表到数据库
 *
 */

-(BOOL)efAddRestittleModel:(RestittleModel *)jRestittleModel{
    
    BOOL isSuccess = NO;
    
    RestittleModel * model = [self efGetRestittleModelWithRestittleModelId:jRestittleModel.qID];
    
    if (jRestittleModel) {
        
        if (!(jRestittleModel == model)) {
            
            [self efDeleteRestittleModel:model];
            
            model = jRestittleModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据已答题目表ID获取已答题目表
 *  @ 已答题目表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllRestittleModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qListID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KRestittleModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllRestittleModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KRestittleModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据RestittleModelID获取RestittleModel信息
 *
 *  @ RestittleModelId
 *
 *  @ return
 */

-(RestittleModel *)efGetRestittleModelWithRestittleModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KRestittleModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        RestittleModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateRestittleModel];
}

/**
 *  删除已答题目表信息
 *
 *  @ param RestittleModel
 *
 *  @ return
 */
-(BOOL)efDeleteRestittleModel:(RestittleModel *)jRestittleModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jRestittleModel];
    
}

/**
 *  更新已答题目表信息
 *
 *  @ param RestittleModel
 *
 *  @ return
 */
-(BOOL)efUpdateRestittleModel:(RestittleModel *)jRestittleModel{
    
    return  [self efAddRestittleModel:jRestittleModel];
    
}

/**
 *  清空所有已答题目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllRestittleModel{
    
    BOOL flag = YES;
    for (RestittleModel * model in [self efGetAllRestittleModel]) {
        
        if (![self efDeleteRestittleModel:model]) {
            flag = NO;
        }
    }
    return flag;
}


#pragma mark - 已答答案表

//==============================================================================
/*已答答案表*/
//==============================================================================
/**
 *  创建已答答案表信息
 *
 *  @return ResAnswerModel
 */
-(ResAnswerModel*)efCreateResAnswerModel{
    //    创建新表
    ResAnswerModel * model = (ResAnswerModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KResAnswerModel];
    return  model;
}
/**
 *  获取所有已答答案表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllResAnswerModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResAnswerModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加已答答案表到数据库
 *
 */

-(BOOL)efAddResAnswerModel:(ResAnswerModel *)jResAnswerModel{
    
    BOOL isSuccess = NO;
    
    ResAnswerModel * model = [self efGetResAnswerModelWithResAnswerModelId:jResAnswerModel.qID];
    
    if (jResAnswerModel) {
        
        if (!(jResAnswerModel == model)) {
            
            [self efDeleteResAnswerModel:model];
            
            model = jResAnswerModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据已答答案表ID获取已答答案表
 *  @ 已答答案表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllResAnswerModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qTittleID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResAnswerModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllResAnswerModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResAnswerModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据ResAnswerModelID获取ResAnswerModel信息
 *
 *  @ ResAnswerModelId
 *
 *  @ return
 */

-(ResAnswerModel *)efGetResAnswerModelWithResAnswerModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KResAnswerModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        ResAnswerModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateResAnswerModel];
}

/**
 *  删除已答答案表信息
 *
 *  @ param ResAnswerModel
 *
 *  @ return
 */
-(BOOL)efDeleteResAnswerModel:(ResAnswerModel *)jResAnswerModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jResAnswerModel];
    
}

/**
 *  更新已答答案表信息
 *
 *  @ param ResAnswerModel
 *
 *  @ return
 */
-(BOOL)efUpdateResAnswerModel:(ResAnswerModel *)jResAnswerModel{
    
    return  [self efAddResAnswerModel:jResAnswerModel];
    
}

/**
 *  清空所有已答答案表
 *
 *  @ return
 */
-(BOOL)efDeleteAllResAnswerModel{
    
    BOOL flag = YES;
    for (ResAnswerModel * model in [self efGetAllResAnswerModel]) {
        
        if (![self efDeleteResAnswerModel:model]) {
            flag = NO;
        }
    }
    return flag;
}

#pragma mark - 班级表

//==============================================================================
/*班级表*/
//==============================================================================
/**
 *  创建班级表信息
 *
 *  @return ClassModel
 */
-(ClassModel*)efCreateClassModel{
    //    创建新表
    ClassModel * model = (ClassModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KClassModel];
    return  model;
}
/**
 *  获取所有班级表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllClassModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KClassModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加班级表到数据库
 *
 */

-(BOOL)efAddClassModel:(ClassModel *)jClassModel{
    
    BOOL isSuccess = NO;
    
    ClassModel * model = [self efGetClassModelWithClassModelId:jClassModel.qID];
    
    if (jClassModel) {
        
        if (!(jClassModel == model)) {
            
            [self efDeleteClassModel:model];
            
            model = jClassModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据班级表ID获取班级表
 *  @ 班级表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllClassModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"sID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KClassModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllClassModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KClassModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据ClassModelID获取ClassModel信息
 *
 *  @ ClassModelId
 *
 *  @ return
 */

-(ClassModel *)efGetClassModelWithClassModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KClassModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        ClassModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateClassModel];
}

/**
 *  删除班级表信息
 *
 *  @ param ClassModel
 *
 *  @ return
 */
-(BOOL)efDeleteClassModel:(ClassModel *)jClassModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jClassModel];
    
}

/**
 *  更新班级表信息
 *
 *  @ param ClassModel
 *
 *  @ return
 */
-(BOOL)efUpdateClassModel:(ClassModel *)jClassModel{
    
    return  [self efAddClassModel:jClassModel];
    
}

/**
 *  清空所有班级表
 *
 *  @ return
 */
-(BOOL)efDeleteAllClassModel{
    
    BOOL flag = YES;
    for (ClassModel * model in [self efGetAllClassModel]) {
        
        if (![self efDeleteClassModel:model]) {
            flag = NO;
        }
    }
    return flag;
}

#pragma mark - 项目表

//==============================================================================
/*项目表*/
//==============================================================================
/**
 *  创建项目表信息
 *
 *  @return QobjectModel
 */
-(QobjectModel*)efCreateQobjectModel{
    //    创建新表
    QobjectModel * model = (QobjectModel*)[[CoreDataManager shareInstance] CreateObjectWithTable:KQobjectModel];
    return  model;
}
/**
 *  获取所有项目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQobjectModel{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel sortByKey:nil];
    return ModelArr;
}

/**
 *  添加项目表到数据库
 *
 */

-(BOOL)efAddQobjectModel:(QobjectModel *)jQobjectModel{
    
    BOOL isSuccess = NO;
    
    QobjectModel * model = [self efGetQobjectModelWithQobjectModelId:jQobjectModel.qID];
    
    if (jQobjectModel) {
        
        if (!(jQobjectModel == model)) {
            
            [self efDeleteQobjectModel:model];
            
            model = jQobjectModel;
        }
    }
    isSuccess = [[CoreDataManager shareInstance] saveContext];
    
    //    NSLog( @ "%@ ",isSuccess?@"成功":@"失败");
    return isSuccess;
    
}

/**
 *  根据班级ID获取项目表
 *  @ 班级ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithClassId:(NSString*)ClassId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qCID1 = '%@' or qCID2 = '%@' or qCID = '%@'",ClassId,ClassId,ClassId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:nil limit:1000 ascending:YES];
    //    返回
    return modelArr;
}


/**
 *  根据项目表ID获取项目表
 *  @ 项目表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWith:(NSString*)modelId{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"qTittleID = '%@'",modelId];
    //    查询
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
}

/**
 *  根据项目表ID获取是否使用项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithqUSE:(BOOL)use{
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel sortByKey:nil];
    
    NSMutableArray * modelArr = [[NSMutableArray alloc]init];
    
    for (QobjectModel * model in ModelArr) {
        
        if (model.qUSE == use) {
            [modelArr addObject:model];
        }
    }
    
    
    //    //sql
    //    NSString *conditionStr = [NSString stringWithFormat:@"qHidden = '%@'and qDelete = '%@'and qUSE = '%@' ",hidden,delete,use ];
    //    //    查询
    //    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  根据项目表ID获取是否隐藏项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithHidden:(BOOL)hidden{

    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel sortByKey:nil];

    NSMutableArray * modelArr = [[NSMutableArray alloc]init];
    
    for (QobjectModel * model in ModelArr) {
        
        if (model.qHidden == hidden ) {
            [modelArr addObject:model];
        }
    }
    
    
//    //sql
//    NSString *conditionStr = [NSString stringWithFormat:@"qHidden = '%@'and qDelete = '%@'and qUSE = '%@' ",hidden,delete,use ];
//    //    查询
//    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  根据项目表ID获取未是否删除项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithDelete:(BOOL)isdelete {
    
    NSMutableArray *ModelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel sortByKey:nil];
    
    NSMutableArray * modelArr = [[NSMutableArray alloc]init];
    
    for (QobjectModel * model in ModelArr) {
        
        if (model.qDelete == isdelete ) {
            
            [modelArr addObject:model];
        }
    }
    
    
    //    //sql
    //    NSString *conditionStr = [NSString stringWithFormat:@"qHidden = '%@'and qDelete = '%@'and qUSE = '%@' ",hidden,delete,use ];
    //    //    查询
    //    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:nil limit:100 ascending:YES];
    //    返回
    return modelArr;
    
}

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */

-(NSMutableArray *)efSearchAllQobjectModelWithsearchText:(NSString*)searchText{
    //sql
    NSString *conditionStr = [NSString stringWithFormat:@"(qTittle LIKE '*%@*' or qDate LIKE '*%@*' or qUser LIKE '*%@*') ",searchText,searchText,searchText];
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:conditionStr sortByKey:@"testBeginTime" limit:100 ascending:YES];
    
    return modelArr;
}

/**
 *  根据QobjectModelID获取QobjectModel信息
 *
 *  @ QobjectModelId
 *
 *  @ return
 */

-(QobjectModel *)efGetQobjectModelWithQobjectModelId:(NSString *)modelId{
    
    NSMutableArray *modelArr = [[CoreDataManager shareInstance] QueryObjectsWithTable:KQobjectModel condition:[NSString stringWithFormat:@"qID LIKE '%@' ",modelId] sortByKey:nil];
    
    if (modelArr.count > 0) {
        QobjectModel *model = [modelArr objectAtIndexWithSafety:0];
        return model;
    }
    return [self efCreateQobjectModel];
}

/**
 *  删除项目表信息
 *
 *  @ param QobjectModel
 *
 *  @ return
 */
-(BOOL)efDeleteQobjectModel:(QobjectModel *)jQobjectModel{
    
    return  [[CoreDataManager shareInstance] deleteWithObject:jQobjectModel];
    
}

/**
 *  更新项目表信息
 *
 *  @ param QobjectModel
 *
 *  @ return
 */
-(BOOL)efUpdateQobjectModel:(QobjectModel *)jQobjectModel{
    
    return  [self efAddQobjectModel:jQobjectModel];
    
}

/**
 *  清空所有项目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQobjectModel{
    
    BOOL flag = YES;
    for (QobjectModel * model in [self efGetAllQobjectModel]) {
        
        if (![self efDeleteQobjectModel:model]) {
            flag = NO;
        }
    }
    return flag;
}


@end
