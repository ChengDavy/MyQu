//
//  QtittleModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QtittleModel+CoreDataProperties.h"

@implementation QtittleModel (CoreDataProperties)

+ (NSFetchRequest<QtittleModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"QtittleModel"];
}

@dynamic qID;
@dynamic qTittle;
@dynamic qNumber;
@dynamic qListID;
@dynamic qBOOL;
@dynamic qHidden;

@end
