//
//  FreightModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/8.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "FreightModel.h"

@implementation FreightModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"freightType" : @"freightType",
             @"freeType" : @"freeType",
             @"quantity" : @"quantity",
             @"freight" : @"freight",
             @"addQuantity" : @"addQuantity",
             @"addFreight" : @"addFreight",
             @"conditionFreeType" : @"conditionFreeType",
             @"conditionQuantity" : @"conditionQuantity",
             @"conditionFreight" : @"conditionFreight",
             @"productId" : @"productId",
             
             };
}


@end
