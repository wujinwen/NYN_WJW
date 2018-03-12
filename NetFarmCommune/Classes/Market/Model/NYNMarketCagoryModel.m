//
//  NYNMarketCagoryModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketCagoryModel.h"

@implementation NYNMarketCagoryModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"children":@"children",
             @"createDate":@"createDate",
             @"modifyDate":@"modifyDate",
             @"name":@"name",
             @"parentId":@"parentId",
             @"showType":@"showType",
             @"type":@"type",
            @"productCategories":@"productCategories"
             };
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"children":@"NYNMarketCagoryModel"};
}
@end
