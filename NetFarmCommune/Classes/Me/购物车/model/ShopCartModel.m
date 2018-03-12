//
//  ShopCartModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ShopCartModel.h"

@implementation ShopCartModel


// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"quantity" : @"quantity",
             @"productId" : @"productId",
             @"farmId" : @"farmId",
             @"productName" : @"productName",
             @"productImg" : @"productImg",
             @"productPrice" : @"productPrice",
             @"productCname" : @"productCname",
             @"farmName" : @"farmName",
             @"farmLogo" : @"farmLogo",
             @"productType" : @"productType",
           
             };
}


@end
