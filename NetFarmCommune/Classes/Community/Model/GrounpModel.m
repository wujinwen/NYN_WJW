//
//  GrounpModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "GrounpModel.h"

@implementation GrounpModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"name" : @"name",
             @"groupId":@"groupId",
             @"distance":@"distance",
             @"areaId":@"areaId",
             @"intro":@"intro",
             @"avatar":@"avatar",
             @"usersCount":@"usersCount",
             @"city":@"city",
            
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
