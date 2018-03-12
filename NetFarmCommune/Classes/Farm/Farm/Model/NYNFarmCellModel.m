//
//  NYNFarmCellModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNFarmCellModel.h"

@implementation NYNFarmCellModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
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
             @"businessScope":@"businessScope"
             };
}





@end
