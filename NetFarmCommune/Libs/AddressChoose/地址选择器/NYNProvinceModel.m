//
//  NYNProvinceModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNProvinceModel.h"
#import "NYNCityModel.h"

@implementation NYNProvinceModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"name" : @"name",
             @"citys" : @"citys"
             };
}

// 这个方法对比上面的2个方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+ (NSDictionary *)objectClassInArray{
    return @{
             @"citys" : @"NYNCityModel"
             };
}

-(NSMutableArray *)citys{
    if (!_citys) {
        _citys = [[NSMutableArray alloc]init];
    }
    return _citys;
}
@end
