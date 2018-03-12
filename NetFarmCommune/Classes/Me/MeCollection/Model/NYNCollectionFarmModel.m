//
//  NYNCollectionFarmModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCollectionFarmModel.h"

@implementation NYNCollectionFarmModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"address" : @"address",
             @"area":@"area",
             @"business":@"business",
             @"city" : @"city",
             @"ID":@"id",
             @"commentCount" : @"commentCount",
             @"grade":@"grade",
             @"img" : @"img",
             @"introduce":@"introduce",
             @"landStock":@"landStock",
             @"name" : @"name",
             @"province":@"province",
             @"saleCount" : @"saleCount"
             };
}

@end
