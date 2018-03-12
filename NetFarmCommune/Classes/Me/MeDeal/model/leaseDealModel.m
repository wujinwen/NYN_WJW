//
//  leaseDealModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/2.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "leaseDealModel.h"

@implementation leaseDealModel




+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"thumbnail" : @"thumbnail",
             @"landName":@"landName",
             @"quantity":@"quantity",
             @"price" : @"price",
             @"validDate":@"validDate",
             @"expire" : @"expire",
             @"orderId":@"orderId",
             @"status" : @"status",
             @"maxStock" : @"maxStock",
             @"farmName" : @"farmName",
             @"farmLogo" : @"farmLogo",
             @"productType" : @"productType",
          
             
             };
}

@end
