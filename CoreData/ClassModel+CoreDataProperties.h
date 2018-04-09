//
//  ClassModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/4/2.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ClassModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ClassModel (CoreDataProperties)

+ (NSFetchRequest<ClassModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *sID;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *notice;
@property (nullable, nonatomic, copy) NSString *manager;

@end

NS_ASSUME_NONNULL_END
