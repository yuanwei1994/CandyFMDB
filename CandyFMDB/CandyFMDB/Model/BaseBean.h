//
//  BaseBean.h
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//
//这边可以放一些其它实体都公有的属性，及lkdbhelper数据库的地址；
//其中PrintSQL是对NSObject的扩展，可以查看创建表的sql语句；

#import <Foundation/Foundation.h>
#import <LKDBHelper/LKDBHelper.h>

@interface BaseBean : NSObject

@end


//这个NSOBJECT的扩展类 可以查看详细的建表sql语句
@interface NSObject(PrintSQL)

+(NSString*)getCreateTableSQL;

@end
