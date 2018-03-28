//
//  JKbase+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "JKbase.h"


NS_ASSUME_NONNULL_BEGIN

@interface JKbase (CoreDataProperties)

+ (NSFetchRequest<JKbase *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *baseName;
@property (nullable, nonatomic, copy) NSString *baseNotice;
@property (nonatomic) int32_t baseNumber;

@end

NS_ASSUME_NONNULL_END
