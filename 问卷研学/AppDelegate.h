//
//  AppDelegate.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong) NSPersistentContainer *persistentContainer;

// 上下文对象
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型对象
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 持久性存储区
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
// 初始化CoreData使用的数据库
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//managedObjectContext的初始化赋值函数
- (NSManagedObjectContext *)managedObjectContext;

//managedObjectModel初始化赋值函数
- (NSManagedObjectModel *)managedObjectModel;

@end

