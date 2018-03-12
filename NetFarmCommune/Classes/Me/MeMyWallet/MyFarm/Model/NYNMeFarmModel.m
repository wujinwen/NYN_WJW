//
//  NYNMeFarmModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/15.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeFarmModel.h"

@implementation NYNMeFarmModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"address" : @"address",
             @"completedDate":@"completedDate",
             @"distance":@"distance",
             @"endDate":@"endDate",
             @"farmId":@"farmId",
             @"farmImg":@"farmImg",
             @"farmName":@"farmName",
             @"farmPhone":@"farmPhone",
             @"isShipping":@"isShipping",
             @"majorProductImg":@"majorProductImg",
             @"majorProductName":@"majorProductName",
             @"majorProductPrice":@"majorProductPrice",
             @"majorProductQuantity":@"majorProductQuantity",
             @"minorProductImg":@"minorProductImg",
             @"minorProductName":@"minorProductName",
             @"orderAmount":@"orderAmount",
             @"orderId":@"orderId",
             @"orderSn":@"orderSn",
             @"orderStatus":@"orderStatus",
             @"orderType":@"orderType",
             @"startDate":@"startDate"
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例

        return  @"";
    }
    return oldValue;
}
@end
