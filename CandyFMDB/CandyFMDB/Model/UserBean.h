//
//  UserBean.h
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "CarBean.h"

@interface UserBean : BaseBean

@property(assign,nonatomic)int userID;
@property(strong,nonatomic)NSString *userName;
@property(strong,nonatomic)NSString *password;
@property(strong,nonatomic)NSString *phoneNumber;//userID

@property(assign,nonatomic)int age;

@property(strong,nonatomic)CarBean *myCar;

@end
