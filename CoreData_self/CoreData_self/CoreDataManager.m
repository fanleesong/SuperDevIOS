//
//  CoreDataManager.m
//  CoreData_self
//
//  Created by 范林松 on 14-3-25.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager
#pragma mark-
#pragma mark--单例方法
+(instancetype)sharedCoreDataManager{
    
    static CoreDataManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        instance = [[self alloc] init];
        
    });
//    if ( instance == nil) {
//        instance = [[self alloc] init];
//    }
    
    return instance;
}


#pragma mark-
#pragma mark----处理的方法
-(NSArray *)findAllStuName{

    //实例化一个实体的检索请求
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"StuName"] autorelease];
    //设置检索请求的关键字和排序方式、谓词等
    NSArray *infoList = [self.managerObjectContext executeFetchRequest:request error:nil];
    return infoList;
    
}
-(void)saveStuName:(StuName *)name{

    //判断管理器是否发生过变化
    if ([self.managerObjectContext hasChanges]) {
        //保存
        [self.managerObjectContext save:nil];
    }

}
-(void)deleteStuName:(StuName *)name{

    [self.managerObjectContext delete:name];

}
#pragma mark-
#pragma mark--
-(StuName *)findStuName{
    
    //1.实例化实体对象
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"StuName" inManagedObjectContext:self.managerObjectContext];
    
    //2.根据实体描述对象实例化StuName对象
    StuName *info = [[[StuName alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managerObjectContext] autorelease];
    
    return info;
    
}

#pragma mark--变种的setter和Getter方法
#pragma mark-
#pragma mark--管理器
-(NSManagedObjectContext *)managerObjectContext{
    
    if (_managerObjectContext == nil) {
        //使用主线程初始化管理器
        _managerObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        //使用链接器设置管理器
        [_managerObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        
    }
    return _managerObjectContext;
}
#pragma mark--
#pragma mark---链接器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    if (_persistentStoreCoordinator == nil) {
        //初始化链接器
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managerObjectModel];
        //设置链接器的实体对象的链接方式
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.applicationDocumentDirectory options:nil error:nil];
    }
    
    return _persistentStoreCoordinator;
}


#pragma mark-
#pragma mark---模型器
-(NSManagedObjectModel *)managerObjectModel{
    
    
    if (_managerObjectModel == nil) {
        //始化模型器-合并
        _managerObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managerObjectModel;
}

-(void)saveManagerContext{
    
//    NSError *error = nil;
//    if (self.managerObjectContext != nil) {
//        if ([self.managerObjectContext hasChanges] && ![self.managerObjectContext save:&error]) {
//            NSLog(@"未处理的错误信息%@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
    if ([self.managerObjectContext hasChanges]) {
        [self.managerObjectContext save:nil];
    }
    
}

#pragma mark-
#pragma mark--重写初始化方法
-(instancetype)init{
    
    if (self = [super init]) {
        //调用一下管理器
        [self managerObjectContext];
        //设置实时通知中心，一旦数据发生变化就及时处理
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveStuName:) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
        
    }
    return self;
    
}
#pragma mark-
#pragma mark-----初始化沙盒文件路径
-(NSURL *)applicationDocumentDirectory{
    
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSLog(@"%@",stringPath);
    NSString *sandBoxPath = [stringPath stringByAppendingString:@"/stuName.sqlite"];
    NSURL *sandBoxUrl = [NSURL fileURLWithPath:sandBoxPath];
    return sandBoxUrl;
//    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSLog(@"%@",sandBoxPath);
//    NSString *sqliteString = [sandBoxPath stringByAppendingString:@"/coredate.sqlite"];
//    
//    return [NSURL fileURLWithPath:sqliteString];
    
}

-(void)dealloc{
    [_managerObjectContext release],_managerObjectContext = nil;
    [_managerObjectModel release],_managerObjectModel = nil;
    [_persistentStoreCoordinator release],_persistentStoreCoordinator = nil;
    [super dealloc];
}

@end
