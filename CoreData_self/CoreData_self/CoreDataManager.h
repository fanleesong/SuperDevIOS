//
//  CoreDataManager.h
//  CoreData_self
//
//  Created by 范林松 on 14-3-25.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StuName.h"

@interface CoreDataManager : NSObject

@property(nonatomic,retain)NSManagedObjectContext *managerObjectContext;//管理器
@property(nonatomic,retain)NSPersistentStoreCoordinator *persistentStoreCoordinator;//链接器
@property(nonatomic,retain)NSManagedObjectModel *managerObjectModel;//模型器

//单例方法
+(instancetype)sharedCoreDataManager;
-(void)saveManagerContext;
//沙盒文件路径
-(NSURL *)applicationDocumentDirectory;
//查询单个
-(StuName *)findStuName;
//查询所有
-(NSArray *)findAllStuName;
//保存
-(void)saveStuName:(StuName *)name;
//删除
-(void)deleteStuName:(StuName *)name;

@end
