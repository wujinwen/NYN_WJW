//
//  NYNiConModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNiConModel.h"

@implementation NYNiConModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"icon" : @"icon",
             @"ID" : @"id",
             @"key" : @"key",
             @"name" : @"name",
             @"orderBy" : @"orderBy",
             @"parentId" : @"parentId",
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        return  @"";
    }
    return oldValue;
}

@end
