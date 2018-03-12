//
//  NYNCategoryPageModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/16.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCategoryPageModel.h"

@implementation NYNCategoryPageModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"name":@"name",
             @"pImg":@"pImg",
             @"images":@"images",
             @"sn":@"sn",
             @"price":@"price",
             @"unitId":@"unitId",
             @"unitName":@"unitName",
             @"intro":@"intro",
             @"stock":@"stock",
             @"isStock":@"isStock",
             @"isSale":@"isSale",
             @"saleType":@"saleType",
             @"saleDate":@"saleDate",
             @"commentCount":@"commentCount",
             @"landStock":@"landStock",
             @"distance":@"distance",
             @"maxStock":@"maxStock",
             @"reviews":@"reviews",
             @"cycleTime":@"cycleTime",
             @"farm":@"farm",
             @"isRecommend":@"isRecommend",
             @"images":@"images",
             @"square":@"square",
             };
}

@end
