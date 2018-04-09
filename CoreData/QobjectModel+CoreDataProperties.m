//
//  QobjectModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/3.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QobjectModel+CoreDataProperties.h"

@implementation QobjectModel (CoreDataProperties)

+ (NSFetchRequest<QobjectModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"QobjectModel"];
}

@dynamic qID;
@dynamic qName;
@dynamic qSID;
@dynamic qBID;
@dynamic qCID;
@dynamic qtime;
@dynamic qtime1;
@dynamic qHidden;
@dynamic qDelete;
@dynamic qBName;
@dynamic qSName;
@dynamic qCName;
@dynamic qUSE;
@dynamic qQID;
@dynamic qQName;
@dynamic qCID1;
@dynamic qCName1;
@dynamic qCID2;
@dynamic qCName2;

@end
