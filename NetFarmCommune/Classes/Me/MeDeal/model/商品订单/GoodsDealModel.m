//
//  GoodsDealModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/3.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsDealModel.h"

@implementation GoodsDealModel


// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"createDate" : @"createDate",
             @"sn" : @"sn",
             @"farmId" : @"farmId",
             @"status" : @"status",
             @"amount" : @"amount",
             @"freight" : @"freight",
             @"type" : @"type",
             @"quantity" : @"quantity",
             @"farm" : @"farm",
             @"orderItems":@"orderItems",
           
             };
}


@end
