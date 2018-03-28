//
//  SchoolModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/8.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "SchoolModel+CoreDataProperties.h"

@implementation SchoolModel (CoreDataProperties)

+ (NSFetchRequest<SchoolModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SchoolModel"];
}

@dynamic qID;
@dynamic qShen;
@dynamic qShi;
@dynamic qQu;
@dynamic qSName;
@dynamic qBase;

@end
