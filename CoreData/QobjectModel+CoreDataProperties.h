//
//  QobjectModel+CoreDataProperties.h
//  问卷研学
//
//  Created by 程党威 on 2018/4/3.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QobjectModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface QobjectModel (CoreDataProperties)

+ (NSFetchRequest<QobjectModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *qID;
@property (nullable, nonatomic, copy) NSString *qName;
@property (nullable, nonatomic, copy) NSString *qSID;
@property (nullable, nonatomic, copy) NSString *qBID;
@property (nullable, nonatomic, copy) NSString *qCID;
@property (nullable, nonatomic, copy) NSString *qtime;
@property (nullable, nonatomic, copy) NSString *qtime1;
@property (nonatomic) BOOL qHidden;
@property (nonatomic) BOOL qDelete;
@property (nullable, nonatomic, copy) NSString *qBName;
@property (nullable, nonatomic, copy) NSString *qSName;
@property (nullable, nonatomic, copy) NSString *qCName;
@property (nonatomic) BOOL qUSE;
@property (nullable, nonatomic, copy) NSString *qQID;
@property (nullable, nonatomic, copy) NSString *qQName;
@property (nullable, nonatomic, copy) NSString *qCID1;
@property (nullable, nonatomic, copy) NSString *qCName1;
@property (nullable, nonatomic, copy) NSString *qCID2;
@property (nullable, nonatomic, copy) NSString *qCName2;

@end

NS_ASSUME_NONNULL_END
