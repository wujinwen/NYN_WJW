//
//  NYNMarketListModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketListModel.h"

@implementation NYNMarketListModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"categoryId":@"categoryId",
             @"cname":@"cname",
             @"createDate":@"createDate",
             @"cycleTime":@"cycleTime",
             @"distance":@"distance",
             @"farmId":@"farmId",
             @"intro":@"intro",
             @"isHot":@"isHot",
             @"isSale":@"isSale",
             @"isStock":@"isStock",
             @"isTop":@"isTop",
             @"maxRate":@"maxRate",
             @"maxStock":@"maxStock",
             @"minRate":@"minRate",
             @"modifyDate":@"modifyDate",
             @"name":@"name",
             @"orderBy":@"orderBy",
             @"pImg":@"pImg",
             @"price":@"price",
             @"saleDate":@"saleDate",
             @"saleType":@"saleType",
             @"sn":@"sn",
             @"stock":@"stock",
             @"unitId":@"unitId",
             @"unitName":@"unitName",
             @"productImages":@"productImages",
             @"farm":@"farm",
              @"images":@"images",
             @"shippingMethodId":@"shippingMethodId",
             @"defaultUserAddressId":@"defaultUserAddressId",
             @"defaultUserAddressTitle":@"defaultUserAddressTitle",
             @"intros":@"intros",
             @"fullCategoryName":@"fullCategoryName",
             @"shippingMethod":@"shippingMethod",
             @"panduanBool":@"panduanBool",
             @"monthSales":@"monthSales"
             
             
             
             
             };
}

-(NSMutableDictionary *)farm{
    if (!_farm) {
        _farm=[[NSMutableDictionary alloc]init];
        
    }
    return _farm;
}
@end
