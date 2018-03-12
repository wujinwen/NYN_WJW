//
//  NYNProductNameModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/15.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNProductNameModel.h"

@implementation NYNProductNameModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"categoryId",
             @"name":@"categoryName",
             @"children":@"children",
             @"showType":@"showType",
//             @"categoryId":@"categoryId",
             @"categoryName":@"categoryName",
             @"farmId":@"farmId",
             @"icon":@"icon",
             @"orderBy":@"orderBy",
             @"type":@"type",
             @"categoryId":@"categoryId",

             };
}

@end
