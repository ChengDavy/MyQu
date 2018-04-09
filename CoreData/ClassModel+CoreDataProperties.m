//
//  ClassModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/2.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ClassModel+CoreDataProperties.h"

@implementation ClassModel (CoreDataProperties)

+ (NSFetchRequest<ClassModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ClassModel"];
}

@dynamic qID;
@dynamic sID;
@dynamic name;
@dynamic notice;
@dynamic manager;

@end
