//
//  QanswerModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "QanswerModel.h"

@implementation QanswerModel (CoreDataProperties)

+ (NSFetchRequest<QanswerModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"QanswerModel"];
}

@dynamic qID;
@dynamic qIndex;
@dynamic qTittleID;
@dynamic qMessage;

@end
