//
//  RestittleModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "RestittleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface RestittleModel (CoreDataProperties)

+ (NSFetchRequest<RestittleModel *> *)fetchRequest;

@property (nonatomic) BOOL qBOOL;
@property (nonatomic) BOOL qHidden;
@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qListID;
@property (nonatomic) int32_t qNumber;
@property (nullable, nonatomic, copy) NSString *qTittle;
@property (nullable, nonatomic, copy) NSString *qOldID;
@property (nullable, nonatomic, copy) NSString *qOldlistID;

@end

NS_ASSUME_NONNULL_END
