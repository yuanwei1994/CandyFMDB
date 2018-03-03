//
//  ViewController.m
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDB.h>
#import "CandyDBObject.h"
#import <LKDBHelper/LKDBHelper.h>
#import "CarBean.h"
#import "UserBean.h"
@interface ViewController ()

@property (nonatomic,strong) FMDatabaseQueue *queue;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

#pragma mark *** 基本模式 ***
//    //1、沙盒路径
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
//    //2、数据库在沙盒中的路径
//    NSString *dbPath = [cachePath stringByAppendingString:@"CandyDB.sqlite"];
//    //3、根据路径创建数据库
//    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
//    //4、打开数据库
//    if ([db open]) {
//        NSLog(@"数据库打开成功！");
//    }
    
#pragma mark *** 单例模式***
//    //打开数据库(不存在则自动创建)
//    CandyDBObject *dbObject = [CandyDBObject sharedInstance];
//    [dbObject createDatabase];
//    //新建表
//    [dbObject createTable];
//    //
//    [dbObject insetTitle:@"霍霍" WithName:@"candy" WithPassWord:@"123456"];

#pragma mark *** ORM(映射)模式 ***
    //创建全局的
    LKDBHelper *globalHelper = [LKDBHelper getUsingLKDBHelper];
//    //删除所有的表
//    [globalHelper dropAllTable];
//    //清理所有数据
//    [LKDBHelper clearTableData:[UserBean class]];
    
    //先有人
    UserBean *user = [[UserBean alloc] init];
    user.phoneNumber = @"17608041383";
    user.userName = @"candy";
    user.password = @"123456";
    user.age = 10;
    //再有车
    CarBean *car = [[CarBean alloc] init];
    car.carNum = @"A99999";
    car.carWidth = 10.0;
    car.address = @"城投 · 下一站都市";
    //然后再有买车
    user.myCar = car;

    //插入数据 如果表不存在 它会自动创建再插入 实体实例化LKDBHelper 若是继承记得引用 否则会没有效果
    if ([user saveToDB]) {
        NSLog(@"数据插入成功1");
    }
    
    
//    car.carNum = @"A88888";
//    user.myCar = car;
//    user.phoneNumber = @"17608041381";
//    user.userName = @"candy Love";
//    if ([user saveToDB]) {
//        NSLog(@"数据插入成功2");
//    }
    
//
//      //异步插入
//    user.userName = @"异步插入2";
//    [globalHelper insertToDB:user callback:^(BOOL result) {
//        NSLog(@"异步插入是否成功：%@", result ? @"是" : @"否");
//    }];
    
//    //异步查询 | offset是跳过多少行 count是查询多少条
//    [globalHelper search:[UserBean class] where:@{@"userName":@"candy"} orderBy:nil offset:0 count:1000 callback:^(NSMutableArray *array) {
//        for (id obj in array) {
//            NSLog(@"异步查询：%@",[obj printAllPropertys]);
//        }
//    }];
    
    
    NSMutableArray *searchResultArray=nil;
    
    //使用对象对进查询操作 | offset是跳过多少行 count是查询多少条
    searchResultArray = [UserBean searchWithWhere:@"userName='candy'" orderBy:nil offset:0 count:100];
    NSLog(@"\n\n%@\n\n", [UserBean getCreateTableSQL]);
    for (id obj in searchResultArray) {
        UserBean *user = obj;
        CarBean *car = user.myCar;
        NSLog(@"userID = %d, phone = %@, username = %@ \t carID = %d, car = %@", user.userID, user.phoneNumber,user.userName, car.carID, car.carNum);
    }
    
    
    //使用对象对进查询操作 | offset是跳过多少行 count是查询多少条
    searchResultArray = [UserBean searchWithWhere:@"phoneNumber='17608041381'" orderBy:nil offset:0 count:100];
    NSLog(@"\n\n%@\n\n", [UserBean getCreateTableSQL]);
    for (id obj in searchResultArray) {
        UserBean *user = obj;
        CarBean *car = user.myCar;
        NSLog(@"userID = %d, phone = %@, username = %@ \t carID = %d, car = %@", user.userID, user.phoneNumber,user.userName, car.carID, car.carNum);
    }
    
    [UserBean updateToDBWithSet:@"userName='GGSmida'" where:@"phoneNumber='17608041383'"];
    
    
    //使用对象对进查询操作 | offset是跳过多少行 count是查询多少条
    searchResultArray = [UserBean searchWithWhere:@"phoneNumber='17608041383'" orderBy:nil offset:0 count:100];
    NSLog(@"\n\n%@\n\n", [UserBean getCreateTableSQL]);
    for (id obj in searchResultArray) {
        UserBean *user = obj;
        CarBean *car = user.myCar;
        NSLog(@"userID = %d, phone = %@, username = %@ \t carID = %d, car = %@", user.userID, user.phoneNumber,user.userName, car.carID, car.carNum);
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
