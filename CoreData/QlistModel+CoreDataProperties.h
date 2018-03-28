//
//  QlistModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QlistModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface QlistModel (CoreDataProperties)

+ (NSFetchRequest<QlistModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qTittle;
@property (nullable, nonatomic, copy) NSString *qDate;
@property (nullable, nonatomic, copy) NSString *qNumber;
@property (nullable, nonatomic, copy) NSString *qMessage;
@property (nullable, nonatomic, copy) NSString *qIndex;

@end

NS_ASSUME_NONNULL_END
