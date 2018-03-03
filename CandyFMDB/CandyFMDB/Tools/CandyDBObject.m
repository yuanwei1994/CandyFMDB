//
//  CandyDBObject.m
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import "CandyDBObject.h"

@implementation CandyDBObject

+ (instancetype)sharedInstance {
    
    static CandyDBObject *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sql = [[CandyDBObject alloc]init];
    });
    return sql;
}


/**
 *  初始化字典
 *
 *  @return params
 */
- (NSMutableDictionary *)params {
    
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

/**
 *  初始化数组(查找全部)
 *
 *  @return Array
 */
- (NSMutableArray *)Array {
    
    if (!_Array) {
        _Array = [NSMutableArray array];
    }
    return _Array;
}


/**
 *  新建数据库
 */
- (void)createDatabase {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingString:@"CleverDB.sqlite"];
    NSLog(@"数据库路径:%@",filePath);
    //创建数据库,并加入到队列中,此时已经默认打开了数据库,无须手动打开,只需要从队列中去除数据库即可
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
}

/**
 *  新建表
 */
- (void)createTable {
    //取出数据库
    [self.queue inDatabase:^(FMDatabase *db) {
        //在数据库中建表
        BOOL createTable = [db executeUpdate:@"create table if not exists t_user (id integer primary key autoincrement,title text,name text,password text)"];
        if (createTable) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
    }];
}

/**
 *  新增
 */
- (void)insetTitle:(NSString *)title WithName:(NSString *)name  WithPassWord:(NSString *)password {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"insert into t_user (title,name,password) values (?,?,?)";
        BOOL flag = [db executeUpdate:sql, title, title, name, password];
        if (flag) {
            NSLog(@"新增数据成功");
        }
        else{
            NSLog(@"新增数据失败");
        }
    }];
}

/**
 *  删除
 */
- (void)deleteWithTitle:(NSString *)title{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"delete from t_user where title = ?",title];
        if (flag) {
            NSLog(@"删除数据成功");
        }
        else{
            NSLog(@"删除数据失败");
        }
    }];
}

/**
 *  更新数据
 */
- (void)updateWithNewName:(NSString *)newName WithTitle:(NSString *)title {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"update t_user set name = ? where title = ?",newName,title];
        if (flag) {
            NSLog(@"更新数据成功");
        }
        else{
            NSLog(@"更新数据失败");
        }
    }];
}

/**
 *  条件查询数据
 */
- (void)selectWithTitle:(NSString *)title {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from t_user where title = ?",title];
        while ([rs next]) {
            
            self.title = [rs stringForColumn:@"title"];
            self.name = [rs stringForColumn:@"name"];
            self.password = [rs stringForColumn:@"password"];
            NSLog(@"平台:%@---用户名:%@----密码:%@",self.title,self.name,self.password);
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.title forKey:@"dictTitle"];
            [dic setObject:self.name forKey:@"dictName"];
            [dic setObject:self.password forKey:@"dictPwd"];
            
            //然后将字典存放到数组
            [self.Array addObject:dic];
        }
        
        
    }];
}

/**
 *  查询所有数据
 *
 */
- (void)selectAllMethod {
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.Array removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from t_user"];
        while ([rs next]) {
            
            self.title = [rs stringForColumn:@"title"];
            self.name = [rs stringForColumn:@"name"];
            self.password = [rs stringForColumn:@"password"];
            NSLog(@"平台:%@---用户名:%@----密码:%@",self.title,self.name,self.password);
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.title forKey:@"dictTitle"];
            [dic setObject:self.name forKey:@"dictName"];
            [dic setObject:self.password forKey:@"dictPwd"];
            
            //然后将字典存放到数组
            [self.Array addObject:dic];
            
        }
        
        NSLog(@"存放的数组:%@==%ld",self.Array,self.Array.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.Array forKey:@"Arry"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}


/**
 *  事务回滚写法1: (如果要保证多个操作同时成功或者同时失败，用事务，即把多个操作放在同一个事务中。)
 */
- (void)updateFailure:(id)sender {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        [db executeUpdate:@"update t_user set name = 'jack' where password = ?",@"12"];
        [db executeUpdate:@"update t_user set name = 'tony' where password = ?",@"13"];
        //发现情况不对,主动回滚用下面语句.否则是根据commit结果,如成功就成功，如不成功才回滚
        [db rollback];
        [db executeUpdate:@"update t_user set name = '回滚' where password = ?",@"13"];
        [db commit];
    }];
}


/**
 *  事务回滚写法2:(直接利用队列进行事务操作,队列中的打开、关闭、回滚事务等都已经被封装好了)
 */
- (void)updateFailure02:(id)sender {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            [db executeUpdate:@"update t_user set name = 'jack' where password = ?",@"12"];
            [db executeUpdate:@"update t_user set name = 'tony' where password = ?",@"13"];
            //发现情况不对,主动回滚用下面语句
            *rollback = YES;
            [db executeUpdate:@"update t_user set name = '回滚' where password = ?",@"13"];
            
        }];
    }];
}


/**
 *  回滚的原生代码:
 [db executeUpdate:@"BEGIN TRANSACTION"];
 [db executeUpdate:@"ROLLBACK TRANSACTION"];
 [db executeUpdate:@"COMMIT TRANSACTION"];
 */


@end
