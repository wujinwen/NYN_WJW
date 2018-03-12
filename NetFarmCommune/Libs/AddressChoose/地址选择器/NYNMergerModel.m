//
//  NYNMergerModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMergerModel.h"

@implementation NYNMergerModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"name" : @"name",
             @"zipCode" : @"zipCode",
             @"mergerName" : @"mergerName"
             };
}


@end
