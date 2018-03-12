//
//  NYNGameModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/13.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNGameModel.h"

@implementation NYNGameModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"images":@"images",
             @"name":@"name",
             @"maxStock":@"maxStock",
             @"price":@"price",
             @"startDate":@"startDate",
             @"signUpStartDate":@"signUpStartDate",
             @"signUpEndDate":@"signUpEndDate",

             @"thumbnail":@"thumbnail",
             @"farm":@"farm",
             @"distance":@"distance",
             @"stock":@"stock",
             @"address":@"address"
             
             
             };
}


@end

