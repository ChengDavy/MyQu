//
//  QanswerModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QanswerModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface QanswerModel (CoreDataProperties)

+ (NSFetchRequest<QanswerModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nonatomic) int32_t qIndex;
@property (nullable, nonatomic, copy) NSString *qTittleID;
@property (nullable, nonatomic, copy) NSString *qMessage;

@end

NS_ASSUME_NONNULL_END
