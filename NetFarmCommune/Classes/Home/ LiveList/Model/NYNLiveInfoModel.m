//
//  NYNLiveInfoModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLiveInfoModel.h"

@implementation NYNLiveInfoModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"liveid" : @"id",
             @"title" : @"title",
             @"pimg" : @"pimg",
             @"farmTitle" : @"farmTitle",
             @"rtmpPush" : @"rtmpPush",
             @"rtmpPull":@"rtmpPull",
             @"intro":@"intro",
             @"farmId":@"farmId",
             @"type":@"type",
             @"currentMember":@"currentMember",
             @"popurlar":@"popurlar",
             @"userName":@"userName",
             @"hasCollection":@"hasCollection",
             @"hotFans":@"hotFans",
             
             @"giftId":@"giftId",
             @"giftName":@"giftName",
             @"giftImg":@"giftImg",
             @"count":@"count",
             
             
             
             };
}

@end
