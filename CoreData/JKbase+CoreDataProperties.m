//
//  JKbase+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "JKbase+CoreDataProperties.h"

@implementation JKbase (CoreDataProperties)

+ (NSFetchRequest<JKbase *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"JKbase"];
}

@dynamic qID;
@dynamic baseName;
@dynamic baseNumber;
@dynamic baseNotice;

@end
