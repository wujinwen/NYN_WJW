//
//  NYNMyFarmTuDiZiLiaoModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmTuDiZiLiaoModel.h"

@implementation NYNMyFarmTuDiZiLiaoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"endDate" : @"endDate",
             @"farmAddress" : @"farmAddress",
             @"farmId" : @"farmId",
             @"farmName" : @"farmName",
             @"fitValue" : @"fitValue",
             @"majorProductName" : @"majorProductName",
             @"majorProductPrice" : @"majorProductPrice",
             @"majorProductQuantity" : @"majorProductQuantity",
             @"majorProductSn" : @"majorProductSn",
             @"majorProductUnit" : @"majorProductUnit",
             @"managerName" : @"managerName",
             @"meme" : @"meme",
             @"minorProductName" : @"minorProductName",
             @"minorProductQuantity" : @"minorProductQuantity",
             @"minorProductUnit" : @"minorProductUnit",
             @"orderName" : @"orderName",
             @"orderSn" : @"orderSn",
             @"startDate" : @"startDate"
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        
        return  @"";
    }
    return oldValue;
}
@end
