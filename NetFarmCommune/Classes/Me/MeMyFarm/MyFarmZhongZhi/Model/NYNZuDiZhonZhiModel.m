//
//  NYNZuDiZhonZhiModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZuDiZhonZhiModel.h"

@implementation NYNZuDiZhonZhiModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"cameraPrice" : @"cameraPrice",
             @"cycleTime" : @"cycleTime",
             @"freight" : @"freight",
             @"majorProductId" : @"majorProductId",
             @"majorProductName" : @"majorProductName",
             @"majorProductPrice" : @"majorProductPrice",
             @"majorProductQuantity" : @"majorProductQuantity",
             @"majorProductRate" : @"majorProductRate",
             @"majorProductUnit" : @"majorProductUnit",
             @"managerName" : @"managerName",
             @"minorProductId" : @"minorProductId",
             @"minorProductName" : @"minorProductName",
             @"minorProductPrice" : @"minorProductPrice",
             @"minorProductQuantity" : @"minorProductQuantity",
             @"minorProductUnit" : @"minorProductUnit",
             @"orderAmount" : @"orderAmount",
             @"orderName" : @"orderName",
             @"processName" : @"processName",
             @"processTotalPrice" : @"processTotalPrice",
             @"programTotalPrice" : @"programTotalPrice",
             @"shipAddress" : @"shipAddress",
             @"shipConsignee" : @"shipConsignee",
             @"shipConsigneeInfo" : @"shipConsigneeInfo",
             @"shipPhone" : @"shipPhone",
             @"signboardName" : @"signboardName",
             @"signboardPrice" : @"signboardPrice",
             @"monitorPrice":@"monitorPrice",
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        
        return  @"";
    }
    
    
    if ([property.name isEqualToString:@"majorProductPrice"]) {
        return @"0";
    }
    
    
    if ([property.name isEqualToString:@"minorProductPrice"]) {
        return @"0";
    }
    
    
    if ([property.name isEqualToString:@"processTotalPrice"]) {
        return @"0";
    }
    
    if ([property.name isEqualToString:@"programTotalPrice"]) {
        return @"0";
    }
    
    if ([property.name isEqualToString:@"cameraPrice"]) {
        return @"0";    }

    
    if ([property.name isEqualToString:@"signboardPrice"]) {
        return @"0";
    }

    return oldValue;
}
@end
