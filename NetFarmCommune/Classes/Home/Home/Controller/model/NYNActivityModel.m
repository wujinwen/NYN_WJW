//
//  NYNActivityModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/13.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNActivityModel.h"

@implementation NYNActivityModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"images":@"images",
             @"name":@"name",
             @"maxStock":@"maxStock",
             @"stock":@"stock",
             @"price":@"price",
             @"startDate":@"startDate",
             @"endDate":@"endDate",
             @"intro":@"intro",
             @"farmId":@"farmId",
             @"categoryId":@"categoryId",
             @"distance":@"distance",
             @"sn":@"sn",
              @"status":@"status",
              @"minRate":@"minRate",
              @"maxRate":@"maxRate",
              @"createDate":@"createDate",
              @"realAddress":@"realAddress",
             @"breedWay":@"breedWay"
             
             };
}

@end

