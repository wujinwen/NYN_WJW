//
//  NYNTuDiXiangQingModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNTuDiXiangQingModel.h"

@implementation NYNTuDiXiangQingModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"categoryId" : @"categoryId",
             @"cname":@"cname",
             @"ID" : @"id",
             @"farmId":@"farmId",
             @"name" : @"name",
             @"pImg":@"pImg",
             @"imgs" : @"imgs",
             @"sn":@"sn",
             @"price" : @"price",
             @"unitId":@"unitId",
             @"unitName" : @"unitName",
             @"intro":@"intro",
             @"stock" : @"stock",
             @"isStock":@"isStock",
             @"isSale" : @"isSale",
             @"saleType":@"saleType",
             @"saleDate" : @"saleDate",
             @"farm":@"farm",
             @"productImages":@"productImages"
             };
}


+(NSDictionary *)mj_objectClassInArray{
    return @{@"productExtraValues":@"NYNProductExtraValuesModel"};
}
@end
