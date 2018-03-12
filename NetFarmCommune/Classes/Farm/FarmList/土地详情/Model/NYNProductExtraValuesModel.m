//
//  NYNProductExtraValuesModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNProductExtraValuesModel.h"

@implementation NYNProductExtraValuesModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"attributeId" : @"attributeId",
             @"productId":@"productId",
             @"ID" : @"id",
             @"value":@"value",
             @"attribute" : @"attribute"
             };
}
@end
