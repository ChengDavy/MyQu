//
//  QtittleModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QtittleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface QtittleModel (CoreDataProperties)

+ (NSFetchRequest<QtittleModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qTittle;
@property (nonatomic) int32_t qNumber;
@property (nullable, nonatomic, copy) NSString *qListID;
@property (nonatomic) BOOL qBOOL;
@property (nonatomic) BOOL qHidden;

@end

NS_ASSUME_NONNULL_END
