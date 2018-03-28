//
//  RestittleModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "RestittleModel+CoreDataProperties.h"

@implementation RestittleModel (CoreDataProperties)

+ (NSFetchRequest<RestittleModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RestittleModel"];
}

@dynamic qBOOL;
@dynamic qHidden;
@dynamic qID;
@dynamic qListID;
@dynamic qNumber;
@dynamic qTittle;
@dynamic qOldID;
@dynamic qOldlistID;

@end
