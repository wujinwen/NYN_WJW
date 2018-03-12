//
//  NYNDealListModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNDealListModel.h"

@implementation NYNDealListModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"cname" : @"cname",
             @"commentState" : @"commentState",
             @"countItemModels" : @"countItemModels",
             @"createDate" : @"createDate",
             @"delivery" : @"delivery",
             @"duration" : @"duration",
             @"executeDate" : @"executeDate",
             @"freight" : @"freight",
             @"ID" : @"id",
             @"interval" : @"interval",
             @"modifyDate" : @"modifyDate",
             @"name" : @"name",
             @"order" : @"order",
             @"orderId" : @"orderId",
             @"orderTempId" : @"orderTempId",
             @"planCount" : @"planCount",
             @"planDuration" : @"planDuration",
             @"planInterval" : @"planInterval",
             @"price" : @"price",
             @"productCategoryId" : @"productCategoryId",
             @"productId" : @"productId",
             @"productUnit" : @"productUnit",
             @"quantity" : @"quantity",
             @"rate" : @"rate",
             @"returnedQuantity" : @"returnedQuantity",
             @"shippedQuantity" : @"shippedQuantity",
             @"sn" : @"sn",
             @"thumbnail" : @"thumbnail",
             @"type" : @"type",
             @"weight" : @"weight",
             @"count":@"count"
             };
}
@end
