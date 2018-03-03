//
//  CarBean.h
//  CandyFMDB
//
//  Created by Candy on 2017/10/25.
//  Copyright © 2017年 com.zhiweism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

@interface CarBean : BaseBean

@property(assign,nonatomic)int carID;
@property(strong,nonatomic)NSString *carNum;
@property(strong,nonatomic)NSString *address;
@property(assign,nonatomic)float carWidth;

@end

