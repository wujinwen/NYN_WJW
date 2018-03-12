//
//  NYNMyFarmTaskHistoryModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/25.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmTaskHistoryModel.h"

@implementation NYNMyFarmTaskHistoryModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"title" : @"title",
             @"artProductName" : @"artProductName",
             @"artProductPrice" : @"artProductPrice",
             @"artProductUnit" : @"artProductUnit",
             @"completeExecuteDate" : @"completeExecuteDate",
             @"createDate" : @"createDate"
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        
        return  @"";
    }
    return oldValue;
}
@end
