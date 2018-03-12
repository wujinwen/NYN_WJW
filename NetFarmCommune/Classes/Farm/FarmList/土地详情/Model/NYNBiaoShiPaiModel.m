//
//  NYNBiaoShiPaiModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNBiaoShiPaiModel.h"

@implementation NYNBiaoShiPaiModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"categoryId" : @"categoryId",
             @"cname":@"cname",
             @"cycleTime" : @"cycleTime",
             @"farm":@"farm",
             @"farmId" : @"farmId",
             @"ID" : @"id",
             @"imgs" : @"imgs",
             @"intro" : @"intro",
             @"isHot" : @"isHot",
             @"intro" : @"isSale",
             @"isHot" : @"isStock",
             @"intro" : @"isTop",
             @"isHot" : @"maxRate",
             @"intro" : @"maxStock",
             @"isHot" : @"minRate",
             @"intro" : @"name",
             @"isHot" : @"orderBy",
             @"intro" : @"pImg",
             @"isHot" : @"price",
             @"intro" : @"productExtraValues",
             @"isHot" : @"saleDate",
             @"intro" : @"saleType",
             @"isHot" : @"sn",
             @"intro" : @"stock",
             @"isHot" : @"unitId",
             @"intro" : @"unitName",
             @"images":@"images"
             };
}
@end
