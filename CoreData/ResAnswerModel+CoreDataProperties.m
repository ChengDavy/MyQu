//
//  ResAnswerModel+CoreDataProperties.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//
//

#import "ResAnswerModel+CoreDataProperties.h"

@implementation ResAnswerModel (CoreDataProperties)

+ (NSFetchRequest<ResAnswerModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ResAnswerModel"];
}

@dynamic qID;
@dynamic qIndex;
@dynamic qMessage;
@dynamic qTittleID;
@dynamic qSelect;
@dynamic qOldID;
@dynamic qListID;
@dynamic qOldlistID;

@end
