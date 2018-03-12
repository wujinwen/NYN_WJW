//
//  NYNYangZhiFangAnModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/3.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNYangZhiFangAnModel.h"

@implementation NYNYangZhiFangAnModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"artProductId" : @"artProductId",
             @"categoryId" : @"categoryId",
             @"categoryName" : @"categoryName",
             @"checked" : @"checked",
             @"count" : @"count",
             @"countTitle" : @"countTitle",
             @"ctype" : @"ctype",
             @"duration" : @"duration",
             @"durationTitle" : @"durationTitle",
             @"farmArtId" : @"farmArtId",
             @"farmArtName" : @"farmArtName",
             @"ftype" : @"ftype",
             @"interval" : @"interval",
             @"intervalTitle" : @"intervalTitle",
             @"isCount" : @"isCount",
             @"isDuration" : @"isDuration",
             @"isInterval" : @"isInterval",
             @"price" : @"price",
             @"unionTask" : @"unionTask",
             @"unionTitle" : @"unionTitle",
             @"unitName" : @"unitName"
             };
}


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {
        
        if ([property.name isEqualToString:@"interval"]) {
            return @"1";
        }
        
        if ([property.name isEqualToString:@"duration"]) {
            return @"1";
        }
        
        if ([property.name isEqualToString:@"executeDate"]) {
            return [NSDate date];
        }
        
        if ([property.name isEqualToString:@"subArr"]) {
            return [[NSMutableArray alloc]init];
        }
        
        if ([property.name isEqualToString:@"dateArr"]) {
            return [[NSMutableArray alloc]init];
        }
        
        if ([property.name isEqualToString:@"yiChuLiDataArr"]) {
            return [[NSMutableArray alloc]init];
        }
        
        if ([property.name isEqualToString:@"count"]) {
            return @"0";
        }
        
        
        
        //这里注意一下  管理端传null  这里统一为0  我这边自己判断的
        if ([property.name isEqualToString:@"ctype"]) {
            return @"0";
        }
        // 以字符串类型为例
        return  @"0.00";
    }
    
    return oldValue;
}

-(NSMutableArray *)subArr{
    if (!_subArr) {
        _subArr = [[NSMutableArray alloc]init];
    }
    return _subArr;
}

-(id)copyWithZone:(NSZone *)zone{
    NYNYangZhiFangAnModel *model = [[self class] allocWithZone:zone];
    model.artProductId = [_artProductId copy];
    model.categoryId = [_categoryId copy];
    model.categoryName = [_categoryName copy];
    model.checked = [_checked copy];
    model.count = [_count copy];
    model.countTitle = [_countTitle copy];
    model.ctype = [_ctype copy];
    model.duration = [_duration copy];
    model.durationTitle = [_durationTitle copy];
    model.farmArtId = [_farmArtId copy];
    model.farmArtName = [_farmArtName copy];
    model.ftype = [_ftype copy];
    model.interval = [_interval copy];
    model.intervalTitle = [_intervalTitle copy];
    model.isCount = [_isCount copy];
    model.isDuration = [_isDuration copy];
    model.isInterval = [_isInterval copy];
    model.price = [_price copy];
    model.unionTask = [_unionTask copy];
    model.unionTitle = [_unionTitle copy];
    model.unitName = [_unitName copy];
    model.chooseDate = [_chooseDate copy];
    model.executeDate = [_executeDate copy];
    
    model.subArr = [[NSMutableArray alloc]init];
    for (NYNYangZhiFangAnModel *subModel in _subArr) {
        [model.subArr addObject:[subModel copy]];
    }
    
    model.dateArr = [[NSMutableArray alloc]init];
    for (NSString *subModel in _dateArr) {
        [model.dateArr addObject:[subModel copy]];
    }
    
    model.yiChuLiDataArr = [[NSMutableArray alloc]init];
    for (NSDictionary *subModel in _yiChuLiDataArr) {
        [model.yiChuLiDataArr addObject:[subModel copy]];
    }
    
    return model;
}
@end
