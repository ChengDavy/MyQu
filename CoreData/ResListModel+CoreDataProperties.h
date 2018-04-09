//
//  ResListModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ResListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ResListModel (CoreDataProperties)

+ (NSFetchRequest<ResListModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qName;
@property (nullable, nonatomic, copy) NSString *qSchoolTittle;
@property (nullable, nonatomic, copy) NSString *qSchoolID;
@property (nullable, nonatomic, copy) NSString *qBaseID;
@property (nullable, nonatomic, copy) NSString *qBaseName;
@property (nullable, nonatomic, copy) NSString *qQuTittle;
@property (nullable, nonatomic, copy) NSString *qQuID;
@property (nullable, nonatomic, copy) NSString *qClassID;
@property (nullable, nonatomic, copy) NSString *qClassName;
@property (nullable, nonatomic, copy) NSString *qObjectID;
@property (nullable, nonatomic, copy) NSString *qObjectName;
@property (nullable, nonatomic, copy) NSDate *qTime;

@end

NS_ASSUME_NONNULL_END
