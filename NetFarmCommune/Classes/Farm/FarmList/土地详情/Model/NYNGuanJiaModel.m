//
//  NYNGuanJiaModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGuanJiaModel.h"

@implementation NYNGuanJiaModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"age" : @"age",
             @"birthday":@"birthday",
             @"farmId" : @"farmId",
             @"ID":@"id",
             @"intro" : @"intro",
             @"name" : @"name",
             @"sex" : @"sex",
             @"skills" : @"skills",
             @"userId" : @"userId"
             };
}
@end
