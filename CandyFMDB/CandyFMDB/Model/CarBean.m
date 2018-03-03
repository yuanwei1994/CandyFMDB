//
//  CarBean.m
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import "CarBean.h"

@implementation CarBean


+(void)initialize
{
    //单个要不显示时
    [self removePropertyWithColumnName:@"address"];
    //多列要不显示时
    //[self removePropertyWithColumnNameArray:];
    
    //修改列对应到表时 重命名新列名
    [self setTableColumnName:@"MyCarWidth" bindingPropertyName:@"carWidth"];
}

/**
 *  @brief  是否将父实体类的属性也映射到sqlite库表
 *  @return BOOL
 */
+(BOOL) isContainParent{
    return YES;
}
/**
 *
 *  @brief  设定表名
 *  @return 返回表名
 */
+(NSString *)getTableName
{
    return @"carbean";
}
/**
 *  @brief  设定表的单个主键
 *  @return 返回主键表
 */
+(NSString *)getPrimaryKey
{
    return @"carID";
}

/////复合主键  这个优先级最高
//+(NSArray *)getPrimaryKeyUnionArray
//{
//    return @[@"carID",@"carNum"];
//}

@end

