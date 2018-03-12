//
//  TudiDealModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "TudiDealModel.h"

@implementation TudiDealModel

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
             @"imgUrl" : @"imgUrl",
             @"userId" : @"userId",
             @"phone" : @"phone",
            
             };
}

@end
