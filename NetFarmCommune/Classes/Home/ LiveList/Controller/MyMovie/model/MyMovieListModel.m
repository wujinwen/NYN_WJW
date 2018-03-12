//
//  MyMovieListModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyMovieListModel.h"

@implementation MyMovieListModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"avatar" : @"avatar",
             @"nickName" : @"nickName",
             @"fans" : @"fans",
             @"farmTitle" : @"farmTitle",
             @"age" : @"age",
             @"sex" : @"sex",
             @"level" : @"level",
             @"rtmpPull" : @"rtmpPull",
             @"birthday" : @"birthday",
            @"liveHistory" : @"liveHistory",
              @"avatar" : @"avatar",
             };
}

@end
