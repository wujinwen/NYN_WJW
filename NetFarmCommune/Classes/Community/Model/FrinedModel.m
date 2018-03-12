//
//  FrinedModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FrinedModel.h"

@implementation FrinedModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"alias" : @"alias",
             @"friend1":@"friend",
             @"userId":@"userId",
             @"status":@"status",
             @"avatar":@"avatar",
  
             
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        
        return  @"";
    }
    
    if ([property.name isEqualToString:@"signboardPrice"]) {
        return @"0";
    }
    
    return oldValue;
}

@end
