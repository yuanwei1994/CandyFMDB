//
//  CandyDBObject.h
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


@interface CandyDBObject : NSObject

@property (nonatomic,strong) FMDatabaseQueue *queue;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *password;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *Array;

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  新建数据库
 */
- (void)createDatabase;

/**
 *  新建表
 */
- (void)createTable;

/**
 *  新增数据
 */
- (void)insetTitle:(NSString *)title WithName:(NSString *)name  WithPassWord:(NSString *)password;

/**
 *  删除数据
 */
- (void)deleteWithTitle:(NSString *)title;

/**
 *  更新数据
 */
- (void)updateWithNewName:(NSString *)newName WithTitle:(NSString *)title;

/**
 *  条件查询数据
 */
- (void)selectWithTitle:(NSString *)title;

/**
 *  查询所有数据
 *
 */
- (void)selectAllMethod;
@end
