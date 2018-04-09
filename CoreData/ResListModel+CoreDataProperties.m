//
//  ResListModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ResListModel+CoreDataProperties.h"

@implementation ResListModel (CoreDataProperties)

+ (NSFetchRequest<ResListModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ResListModel"];
}

@dynamic qID;
@dynamic qName;
@dynamic qSchoolTittle;
@dynamic qSchoolID;
@dynamic qBaseID;
@dynamic qBaseName;
@dynamic qQuTittle;
@dynamic qQuID;
@dynamic qTime;
@dynamic qClassID;
//@dynamic qClassName;
@dynamic qClassName;
@dynamic qObjectID;
@dynamic qObjectName;

@end
