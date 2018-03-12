//
//  NYNAuctionModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNAuctionModel.h"

@implementation NYNAuctionModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"auctionID" : @"auctionID",
             @"createDate" : @"createDate",
             @"sn" : @"sn",
             @"size" : @"size",
             @"unitId" : @"unitId",
             @"unitName":@"unitName",
             @"startPrice":@"startPrice",
             @"endPrice":@"endPrice",
             @"startTime":@"startTime",
             @"addPrice":@"addPrice",
             @"endTime":@"endTime",
             @"currentTime":@"currentTime",
             @"intro":@"intro",
             @"images":@"images",
             
             @"pImg":@"pImg",
             @"userCount":@"userCount",
             @"saleCount":@"saleCount",
             @"newPrice":@"newPrice",
             
              @"saleStatus":@"saleStatus",
             
             };
}



@end
