//
//  NYNWisDomModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWisDomModel.h"

@implementation NYNWisDomModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"Id" : @"id",
             @"userId":@"userId",
             @"name":@"name",
             @"images":@"images",
             @"introduce":@"introduce",
             @"detail":@"detail",
             @"auditState":@"auditState",
             @"state":@"state",
             @"auditTime":@"auditTime",
             @"auditOpinion":@"auditOpinion",
             @"saleCount":@"saleCount",
             @"commentCount":@"commentCount",
             @"province":@"province",
             @"city":@"city",
             @"area":@"area",
             @"address":@"address",
             @"longitude":@"longitude",
             @"latitude":@"latitude",
             @"grade":@"grade",
             @"mainImage":@"mainImage",
             @"mainBusiness":@"mainBusiness",
             @"landStock":@"landStock",
             @"businessScope":@"businessScope",
             @"phone":@"phone",
             @"cycleTime":@"cycleTime",
             };
}

@end
