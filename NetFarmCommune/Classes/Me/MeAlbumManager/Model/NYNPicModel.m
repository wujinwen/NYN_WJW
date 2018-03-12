//
//  NYNPicModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNPicModel.h"

@implementation NYNPicModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"createDate":@"createDate",
             @"createTime":@"createTime",
             @"modifyDate":@"modifyDate",
             @"url":@"url",
             @"userId":@"userId"
             };
}
@end
