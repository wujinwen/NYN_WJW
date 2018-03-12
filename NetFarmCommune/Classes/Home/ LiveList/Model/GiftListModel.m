//
//  GiftListModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "GiftListModel.h"

@implementation GiftListModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"giftId" : @"giftId",
             @"giftName" : @"giftName",
             @"giftImg" : @"giftImg",
             @"farmId" : @"farmId",
             @"count" : @"count",
             @"userName" : @"userName",
             
             
             @"liID" : @"id",
             @"price" : @"price",
             @"name" : @"name",
             @"img" : @"img",
             @"score" : @"score",
             @"type" : @"type",
          
             };
}

@end
