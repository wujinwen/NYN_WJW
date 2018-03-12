//
//  NYNMeAddressModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeAddressModel.h"

@implementation NYNMeAddressModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"contactName":@"contactName",
             @"phone":@"phone",
             @"zipCode":@"zipCode",
             @"address":@"address",
             @"areaId":@"areaId",
             @"isDefault":@"isDefault",
             @"provinceId":@"provinceId",
             @"area":@"area"
           };
}
@end
