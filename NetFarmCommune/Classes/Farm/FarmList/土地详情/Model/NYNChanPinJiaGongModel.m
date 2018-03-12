//
//  NYNChanPinJiaGongModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChanPinJiaGongModel.h"

@implementation NYNChanPinJiaGongModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"farmArt" : @"farmArt",
             @"farmArtId":@"farmArtId",
             @"farmArtName":@"farmArtName",
             @"ID":@"id",
             @"price" : @"price",
             @"productId":@"productId",
             @"unitId" : @"unitId",
             @"unitName":@"unitName",
             @"intro":@"intro"
             };
}
@end
