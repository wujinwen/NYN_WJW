//
//  NYNCityModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCityModel.h"

@implementation NYNCityModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"name" : @"name",
             @"mergerName" : @"mergerName",
             @"countys":@"countys"
             };
}

// 这个方法对比上面的2个方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+ (NSDictionary *)objectClassInArray{
    return @{
             @"countys" : @"NYNMergerModel"
             };
}

-(NSMutableArray *)countys{
    if (!_countys) {
        _countys = [[NSMutableArray alloc]init];
    }
    return _countys;
}
@end
