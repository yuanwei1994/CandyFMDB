//
//  UserBean.m
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import "UserBean.h"

@implementation UserBean


+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}

/**
 *  @brief  是否将父实体类的属性也映射到sqlite库表
 *  @return BOOL
 */
+(BOOL) isContainParent{
    return YES;
}
/**
 *  @brief  设定表名
 *  @return 返回表名
 */
+(NSString *)getTableName
{
    return @"userBean";
}
/**
 *  @brief  设定表的单个主键
 *  @return 返回主键表
 */
+(NSString *)getPrimaryKey
{
    return @"userID";
}
@end
