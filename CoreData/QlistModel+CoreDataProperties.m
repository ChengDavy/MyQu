//
//  QlistModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QlistModel+CoreDataProperties.h"

@implementation QlistModel (CoreDataProperties)

+ (NSFetchRequest<QlistModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"QlistModel"];
}

@dynamic qID;
@dynamic qTittle;
@dynamic qDate;
@dynamic qNumber;
@dynamic qMessage;
@dynamic qIndex;

@end
