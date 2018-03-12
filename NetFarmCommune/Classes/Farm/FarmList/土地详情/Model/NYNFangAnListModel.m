//
//  NYNFangAnListModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNFangAnListModel.h"

@implementation NYNFangAnListModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"artProductId" : @"artProductId",
             @"categoryId":@"categoryId",
             @"categoryName" : @"categoryName",
             @"count":@"count",
             @"countTitle" : @"countTitle",
             @"ctype" : @"ctype",
             @"duration" : @"duration",
             @"durationTitle" : @"durationTitle",
             @"farmArtId" : @"farmArtId",
             @"farmArtName" : @"farmArtName",
             @"ftype" : @"ftype",
             @"interval" : @"interval",
             @"intervalTitle" : @"intervalTitle",
             @"intro" : @"intro",
             @"isCount" : @"isCount",
             @"isDefault" : @"isDefault",
             @"isDuration" : @"isDuration",
             @"isInterval" : @"isInterval",
             @"price" : @"price",
             @"unionTask" : @"unionTask",
             @"unionTitle" : @"unionTitle",
             @"unitName" : @"unitName"
             };
}

-(NSMutableArray *)subArr{
    if (!_subArr) {
        _subArr = [[NSMutableArray alloc]init];
    }
    return _subArr;
}
@end
