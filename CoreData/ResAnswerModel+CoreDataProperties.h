//
//  ResAnswerModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ResAnswerModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ResAnswerModel (CoreDataProperties)

+ (NSFetchRequest<ResAnswerModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nonatomic) int32_t qIndex;
@property (nullable, nonatomic, copy) NSString *qMessage;
@property (nullable, nonatomic, copy) NSString *qTittleID;
@property (nonatomic) BOOL qSelect;
@property (nullable, nonatomic, copy) NSString *qOldID;
@property (nullable, nonatomic, copy) NSString *qListID;
@property (nullable, nonatomic, copy) NSString *qOldlistID;

@end

NS_ASSUME_NONNULL_END
