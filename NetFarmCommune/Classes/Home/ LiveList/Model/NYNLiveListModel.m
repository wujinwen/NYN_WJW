//
//  NYNLiveListModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/9/25.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLiveListModel.h"

@implementation NYNLiveListModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"avatar" : @"avatar",
             @"currentMember" : @"currentMember",
             @"farmId" : @"farmId",
             @"farmTitle" : @"farmTitle",
             @"intro" : @"intro",
             @"pimg" : @"pimg",
             @"popurlar" : @"popurlar",
             @"rtmpPull" : @"rtmpPull",
             @"status" : @"status",
             @"title" : @"title",
             @"type" : @"type",
             @"userName" : @"userName",
              @"rtmpPush" : @"rtmpPush",
              @"userId" : @"userId"
             };
}

@end
