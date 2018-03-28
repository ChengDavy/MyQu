//
//  SchoolModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/8.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "SchoolModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SchoolModel (CoreDataProperties)

+ (NSFetchRequest<SchoolModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qShen;
@property (nullable, nonatomic, copy) NSString *qShi;
@property (nullable, nonatomic, copy) NSString *qQu;
@property (nullable, nonatomic, copy) NSString *qSName;
@property (nullable, nonatomic, copy) NSString *qBase;

@end

NS_ASSUME_NONNULL_END
