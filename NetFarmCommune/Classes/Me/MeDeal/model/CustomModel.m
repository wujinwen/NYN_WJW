//
//  CustomModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"farmName" : @"farmName",
             @"orderSn":@"orderSn",
             @"orderAmount":@"orderAmount",
             @"farmId" : @"farmId",
             @"farmImg":@"farmImg",
             @"farmPhone" : @"farmPhone",
             @"address":@"address",
             @"majorProductName" : @"majorProductName",
             @"majorProductPrice" : @"majorProductPrice",
             @"majorProductQuantity" : @"majorProductQuantity",
             @"majorProductImg" : @"majorProductImg",
             @"minorProductName" : @"minorProductName",
             @"minorProductPrice" : @"minorProductPrice",
              @"minorProductQuantity" : @"minorProductQuantity",
              @"minorProductImg" : @"minorProductImg",
              @"startDate" : @"startDate",
             @"endDate" : @"endDate",
             @"orderId" : @"orderId",
             @"orderStatus" : @"orderStatus",
             @"orderType":@"orderType",
             
             
             };
}

@end
