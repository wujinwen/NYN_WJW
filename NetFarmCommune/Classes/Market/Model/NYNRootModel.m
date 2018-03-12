//
//  NYNRootModel.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/23.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNRootModel.h"

@implementation NYNRootModel


// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"createDate":@"createDate",
             @"productSn":@"productSn",
             @"productName":@"productName",
             @"farmName":@"farmName",
             @"farmAddress":@"farmAddress",
             @"farmManager":@"farmManager",
             @"infos":@"infos",
           
             };
}



@end
