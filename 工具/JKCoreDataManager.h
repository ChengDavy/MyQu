//
//  JKCoreDataManager.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"

#define KQlistModel @"QlistModel"        //问卷名表

#define KQtittleModel @"QtittleModel"    //题目表

#define KQanswerModel @"QanswerModel"    //答案表

#define KSchoolModel  @"SchoolModel"     //学校表

#define KClassModel   @"ClassModel"   //班级表

#define KJKbase  @"JKbase"               //基地表

#define KResListModel  @"ResListModel"   //已答问题表

#define KRestittleModel  @"RestittleModel"  // 已答题目

#define KResAnswerModel  @"ResAnswerModel"  // 已答答案表

#define KQobjectModel @"QobjectModel"   // 测试项目表



@interface JKCoreDataManager : NSObject

+(instancetype)shareInstance;


#pragma mark - 问卷表

//==============================================================================
/*问卷表*/
//==============================================================================
/**
 *  创建问卷表信息
 *
 *  @return QlistModel
 */
-(QlistModel*)efCreateQlistModel;
/**
 *  获取所有问卷表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQlistModel;

/**
 *  添加问卷表到数据库
 *
 */
-(BOOL)efAddQlistModel:(QlistModel *)jQlistModel;

/**
 *  根据问卷表ID获取问卷表
 *  @ 问卷表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQlistModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllQlistModelWithsearchText:(NSString*)searchText;

/**
 *  根据QlistModelID获取QlistModel信息
 *
 *  @ QlistModelId
 *
 *  @ return
 */
-(QlistModel *)efGetQlistModelWithQlistModelId:(NSString *)modelId;

/**
 *  删除问卷表信息
 *
 *  @ param QlistModel
 *
 *  @ return
 */
-(BOOL)efDeleteQlistModel:(QlistModel *)jQlistModel;

/**
 *  更新问卷表信息
 *
 *  @ param QlistModel
 *
 *  @ return
 */
-(BOOL)efUpdateQlistModel:(QlistModel *)jQlistModel;

/**
 *  清空所有问卷表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQlistModel;

#pragma mark - 题目表

//==============================================================================
/*题目表*/
//==============================================================================
/**
 *  创建题目表信息
 *
 *  @return QtittleModel
 */
-(QtittleModel*)efCreateQtittleModel;
/**
 *  获取所有题目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQtittleModel;

/**
 *  添加题目表到数据库
 *
 */
-(BOOL)efAddQtittleModel:(QtittleModel *)jQtittleModel;

/**
 *  根据题目表ID获取题目表
 *  @ 题目表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQtittleModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllQtittleModelWithsearchText:(NSString*)searchText;

/**
 *  根据QtittleModelID获取QtittleModel信息
 *
 *  @ QtittleModelId
 *
 *  @ return
 */
-(QtittleModel *)efGetQtittleModelWithQtittleModelId:(NSString *)modelId;

/**
 *  删除题目表信息
 *
 *  @ param QtittleModel
 *
 *  @ return
 */
-(BOOL)efDeleteQtittleModel:(QtittleModel *)jQtittleModel;

/**
 *  更新题目表信息
 *
 *  @ param QtittleModel
 *
 *  @ return
 */
-(BOOL)efUpdateQtittleModel:(QtittleModel *)jQtittleModel;

/**
 *  清空所有题目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQtittleModel;

#pragma mark - 答案表

//==============================================================================
/*答案表*/
//==============================================================================
/**
 *  创建答案表信息
 *
 *  @return QanswerModel
 */
-(QanswerModel*)efCreateQanswerModel;
/**
 *  获取所有答案表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQanswerModel;

/**
 *  添加答案表到数据库
 *
 */
-(BOOL)efAddQanswerModel:(QanswerModel *)jQanswerModel;

/**
 *  根据答案表ID获取答案表
 *  @ 答案表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQanswerModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllQanswerModelWithsearchText:(NSString*)searchText;

/**
 *  根据QanswerModelID获取QanswerModel信息
 *
 *  @ QanswerModelId
 *
 *  @ return
 */
-(QanswerModel *)efGetQanswerModelWithQanswerModelId:(NSString *)modelId;

/**
 *  删除答案表信息
 *
 *  @ param QanswerModel
 *
 *  @ return
 */
-(BOOL)efDeleteQanswerModel:(QanswerModel *)jQanswerModel;

/**
 *  更新答案表信息
 *
 *  @ param QanswerModel
 *
 *  @ return
 */
-(BOOL)efUpdateQanswerModel:(QanswerModel *)jQanswerModel;

/**
 *  清空所有答案表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQanswerModel;

#pragma mark - 学校表

//==============================================================================
/*学校表*/
//==============================================================================
/**
 *  创建学校表信息
 *
 *  @return SchoolModel
 */
-(SchoolModel*)efCreateSchoolModel;
/**
 *  获取所有学校表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllSchoolModel;

/**
 *  添加学校表到数据库
 *
 */
-(BOOL)efAddSchoolModel:(SchoolModel *)jSchoolModel;

/**
 *  根据学校表ID获取学校表
 *  @ 学校表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllSchoolModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllSchoolModelWithsearchText:(NSString*)searchText;

/**
 *  根据SchoolModelID获取SchoolModel信息
 *
 *  @ SchoolModelId
 *
 *  @ return
 */
-(SchoolModel *)efGetSchoolModelWithSchoolModelId:(NSString *)modelId;

/**
 *  删除学校表信息
 *
 *  @ param SchoolModel
 *
 *  @ return
 */
-(BOOL)efDeleteSchoolModel:(SchoolModel *)jSchoolModel;

/**
 *  更新学校表信息
 *
 *  @ param SchoolModel
 *
 *  @ return
 */
-(BOOL)efUpdateSchoolModel:(SchoolModel *)jSchoolModel;

/**
 *  清空所有学校表
 *
 *  @ return
 */
-(BOOL)efDeleteAllSchoolModel;

#pragma mark - 基地表

//==============================================================================
/*基地表*/
//==============================================================================
/**
 *  创建基地表信息
 *
 *  @return JKbase
 */
-(JKbase*)efCreateJKbase;
/**
 *  获取所有基地表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllJKbase;

/**
 *  添加基地表到数据库
 *
 */
-(BOOL)efAddJKbase:(JKbase *)jJKbase;

/**
 *  根据基地表ID获取基地表
 *  @ 基地表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllJKbaseWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllJKbaseWithsearchText:(NSString*)searchText;

/**
 *  根据JKbaseID获取JKbase信息
 *
 *  @ JKbaseId
 *
 *  @ return
 */
-(JKbase *)efGetJKbaseWithJKbaseId:(NSString *)modelId;

/**
 *  删除基地表信息
 *
 *  @ param JKbase
 *
 *  @ return
 */
-(BOOL)efDeleteJKbase:(JKbase *)jJKbase;

/**
 *  更新基地表信息
 *
 *  @ param JKbase
 *
 *  @ return
 */
-(BOOL)efUpdateJKbase:(JKbase *)jJKbase;

/**
 *  清空所有基地表
 *
 *  @ return
 */
-(BOOL)efDeleteAllJKbase;

#pragma mark - 已答问题表

//==============================================================================
/*已答问题表*/
//==============================================================================
/**
 *  创建已答问题表信息
 *
 *  @return ResListModel
 */
-(ResListModel*)efCreateResListModel;
/**
 *  获取所有已答问题表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllResListModel;

/**
 *  添加已答问题表到数据库
 *
 */
-(BOOL)efAddResListModel:(ResListModel *)jResListModel;

/**
 *  根据已答问题表ID获取已答问题表
 *  @ 已答问题表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllResListModelWith:(NSString*)modelId;


/**
 *  筛选查询
 *  @ 查询字段  base   school  class  object
 *  @ return
 */

-(NSMutableArray *)efSearchAllResListModelWithBaseID:(NSString*)baseID SchoolID:(NSString*)schoolID ClassID:(NSString*)classID ObjectID:(NSString*)objectID;

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllResListModelWithsearchText:(NSString*)searchText;

/**
 *  根据ResListModelID获取ResListModel信息
 *
 *  @ ResListModelId
 *
 *  @ return
 */
-(ResListModel *)efGetResListModelWithResListModelId:(NSString *)modelId;

/**
 *  删除已答问题表信息
 *
 *  @ param ResListModel
 *
 *  @ return
 */
-(BOOL)efDeleteResListModel:(ResListModel *)jResListModel;

/**
 *  更新已答问题表信息
 *
 *  @ param ResListModel
 *
 *  @ return
 */
-(BOOL)efUpdateResListModel:(ResListModel *)jResListModel;

/**
 *  清空所有已答问题表
 *
 *  @ return
 */
-(BOOL)efDeleteAllResListModel;

#pragma mark - 已答题目表

//==============================================================================
/*已答题目表*/
//==============================================================================
/**
 *  创建已答题目表信息
 *
 *  @return RestittleModel
 */
-(RestittleModel*)efCreateRestittleModel;
/**
 *  获取所有已答题目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllRestittleModel;

/**
 *  添加已答题目表到数据库
 *
 */
-(BOOL)efAddRestittleModel:(RestittleModel *)jRestittleModel;

/**
 *  根据已答题目表ID获取已答题目表
 *  @ 已答题目表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllRestittleModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllRestittleModelWithsearchText:(NSString*)searchText;

/**
 *  根据RestittleModelID获取RestittleModel信息
 *
 *  @ RestittleModelId
 *
 *  @ return
 */
-(RestittleModel *)efGetRestittleModelWithRestittleModelId:(NSString *)modelId;

/**
 *  删除已答题目表信息
 *
 *  @ param RestittleModel
 *
 *  @ return
 */
-(BOOL)efDeleteRestittleModel:(RestittleModel *)jRestittleModel;

/**
 *  更新已答题目表信息
 *
 *  @ param RestittleModel
 *
 *  @ return
 */
-(BOOL)efUpdateRestittleModel:(RestittleModel *)jRestittleModel;

/**
 *  清空所有已答题目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllRestittleModel;

#pragma mark - 已答答案表

//==============================================================================
/*已答答案表*/
//==============================================================================
/**
 *  创建已答答案表信息
 *
 *  @return ResAnswerModel
 */
-(ResAnswerModel*)efCreateResAnswerModel;
/**
 *  获取所有已答答案表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllResAnswerModel;

/**
 *  添加已答答案表到数据库
 *
 */
-(BOOL)efAddResAnswerModel:(ResAnswerModel *)jResAnswerModel;

/**
 *  根据已答答案表ID获取已答答案表
 *  @ 已答答案表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllResAnswerModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllResAnswerModelWithsearchText:(NSString*)searchText;

/**
 *  根据ResAnswerModelID获取ResAnswerModel信息
 *
 *  @ ResAnswerModelId
 *
 *  @ return
 */
-(ResAnswerModel *)efGetResAnswerModelWithResAnswerModelId:(NSString *)modelId;

/**
 *  删除已答答案表信息
 *
 *  @ param ResAnswerModel
 *
 *  @ return
 */
-(BOOL)efDeleteResAnswerModel:(ResAnswerModel *)jResAnswerModel;

/**
 *  更新已答答案表信息
 *
 *  @ param ResAnswerModel
 *
 *  @ return
 */
-(BOOL)efUpdateResAnswerModel:(ResAnswerModel *)jResAnswerModel;

/**
 *  清空所有已答答案表
 *
 *  @ return
 */
-(BOOL)efDeleteAllResAnswerModel;

#pragma mark - 班级表

//==============================================================================
/*班级表*/
//==============================================================================
/**
 *  创建班级表信息
 *
 *  @return ClassModel
 */
-(ClassModel*)efCreateClassModel;
/**
 *  获取所有班级表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllClassModel;

/**
 *  添加班级表到数据库
 *
 */
-(BOOL)efAddClassModel:(ClassModel *)jClassModel;

/**
 *  根据班级表ID获取班级表
 *  @ 班级表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllClassModelWith:(NSString*)modelId;


/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllClassModelWithsearchText:(NSString*)searchText;

/**
 *  根据ClassModelID获取ClassModel信息
 *
 *  @ ClassModelId
 *
 *  @ return
 */
-(ClassModel *)efGetClassModelWithClassModelId:(NSString *)modelId;

/**
 *  删除班级表信息
 *
 *  @ param ClassModel
 *
 *  @ return
 */
-(BOOL)efDeleteClassModel:(ClassModel *)jClassModel;

/**
 *  更新班级表信息
 *
 *  @ param ClassModel
 *
 *  @ return
 */
-(BOOL)efUpdateClassModel:(ClassModel *)jClassModel;

/**
 *  清空所有班级表
 *
 *  @ return
 */
-(BOOL)efDeleteAllClassModel;

#pragma mark - 项目表

//==============================================================================
/*项目表*/
//==============================================================================
/**
 *  创建项目表信息
 *
 *  @return QobjectModel
 */
-(QobjectModel*)efCreateQobjectModel;
/**
 *  获取所有项目表
 *
 *  @return studentModel
 */
-(NSMutableArray*)efGetAllQobjectModel;

/**
 *  添加项目表到数据库
 *
 */
-(BOOL)efAddQobjectModel:(QobjectModel *)jQobjectModel;


/**
 *  根据班级ID获取项目表
 *  @ 班级ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithClassId:(NSString*)ClassId;


/**
 *  根据项目表ID获取项目表
 *  @ 项目表ID
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWith:(NSString*)modelId;
/**
 *  根据项目表ID获取是否使用项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithqUSE:(BOOL)use;
/**
 *  根据项目表ID获取是否隐藏项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithHidden:(BOOL)hidden;

/**
 *  根据项目表ID获取未是否删除项目表
 *  @ 项目表ID  qHidden;   qDelete;  qUSE;
 *  @ return
 */
-(NSMutableArray *)efGetAllQobjectModelWithDelete:(BOOL)isdelete;

/**
 *  模糊查询
 *  @ 模糊查询字段
 *  @ return
 */
-(NSMutableArray *)efSearchAllQobjectModelWithsearchText:(NSString*)searchText;

/**
 *  根据QobjectModelID获取QobjectModel信息
 *
 *  @ QobjectModelId
 *
 *  @ return
 */
-(QobjectModel *)efGetQobjectModelWithQobjectModelId:(NSString *)modelId;

/**
 *  删除项目表信息
 *
 *  @ param QobjectModel
 *
 *  @ return
 */
-(BOOL)efDeleteQobjectModel:(QobjectModel *)jQobjectModel;

/**
 *  更新项目表信息
 *
 *  @ param QobjectModel1
 *
 *  @ return
 */
-(BOOL)efUpdateQobjectModel:(QobjectModel *)jQobjectModel;

/**
 *  清空所有项目表
 *
 *  @ return
 */
-(BOOL)efDeleteAllQobjectModel;

@end
