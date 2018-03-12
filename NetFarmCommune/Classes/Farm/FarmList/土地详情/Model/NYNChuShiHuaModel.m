//
//  NYNChuShiHuaModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChuShiHuaModel.h"

@implementation NYNChuShiHuaModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"artOrderItemResults" : @"artOrderItemResults",
             @"defaultSignboardId":@"defaultSignboardId",
             @"defaultSignboardName":@"defaultSignboardName",
             @"defaultSignboardPrice" : @"defaultSignboardPrice",
             @"defaultTemplateAmount":@"defaultTemplateAmount",
             @"defaultUserAddressId" : @"defaultUserAddressId",
             @"defaultUserAddressTitle":@"defaultUserAddressTitle",
             @"freight" : @"freight",
             @"defaultMonitor":@"defaultMonitor",
             @"price":   @"price",
             @"monitorId":@"monitorId",
             };
}

/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{

    
    if ([oldValue isEqual:[NSNull null]] || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {// 以字符串类型为例
        if ([property.name isEqualToString:@"fangAnArr"]) {
            return [NSMutableArray array];
        }

        
        if ([property.name isEqualToString:@"zhongMoArr"]) {
            return [NSMutableArray array];
        }
        
        if ([property.name isEqualToString:@"zhongZiMoArr"]) {
            return [NSMutableArray array];
        }

        if ([property.name isEqualToString:@"yangZhiBiaoZhiNameStr"]
            || [property.name isEqualToString:@"defaultSignboardName"]
            || [property.name isEqualToString:@"yangZhiJiaGongNameStr"]
            || [property.name isEqualToString:@"yangZhiBaoXianNameStr"]) {
            return @"请选择";
        }
        return  @"0.00";
    }
    return oldValue;
}

- (id)copyWithZone:(NSZone *)zone
{
    //实现自定义浅拷贝
    NYNChuShiHuaModel *model = [[self class] allocWithZone:zone];
    model.artOrderItemResults=[_artOrderItemResults copy];
    model.defaultMonitor = [_defaultMonitor copy];
    model.monitorId =[_monitorId copy];
    
    model.defaultSignboardId=[_defaultSignboardId copy];
    model.defaultSignboardName=[_defaultSignboardName copy];
    model.defaultSignboardPrice=[_defaultSignboardPrice copy];
    model.defaultTemplateAmount=[_defaultTemplateAmount copy];
    model.defaultUserAddressId=[_defaultUserAddressId copy];
    model.defaultUserAddressTitle=[_defaultUserAddressTitle copy];
    model.farmManagerId=[_farmManagerId copy];
    model.freight=[_freight copy];
    model.cycTime=_cycTime;
    model.isDefaultTemplate=_isDefaultTemplate;
    model.yangZhiCountStr=_yangZhiCountStr;
    model.yangZhiNameStr=[_yangZhiNameStr copy];
    model.yangZhiFangAnNameStr=[_yangZhiFangAnNameStr copy];
    model.yangZhiFangAnTotlePriceStr=_yangZhiFangAnTotlePriceStr;
    model.yangZhiFangAnTotlePriceIDStr=[_yangZhiFangAnTotlePriceIDStr copy];
    model.yangZhiGuanJiaNameStr=[_yangZhiGuanJiaNameStr copy];
    model.yangZhiGuanJiaIDStr=[_yangZhiGuanJiaIDStr copy];
    model.yangZhiBiaoZhiNameStr=[_yangZhiBiaoZhiNameStr copy];
    model.yangZhiBiaoZhiIDStr=[_yangZhiBiaoZhiIDStr copy];
    model.yangZhiBiaoZhiPriceStr=[_yangZhiBiaoZhiPriceStr copy];
    model.yangZhiJiaGongNameStr=[_yangZhiJiaGongNameStr copy];
    model.yangZhiJiaGongIDStr=[_yangZhiJiaGongIDStr copy];
    model.yangZhiJiaGongPriceStr=[_yangZhiJiaGongPriceStr copy];
    model.yangZhiBaoXianNameStr=[_yangZhiBaoXianNameStr copy];
    model.yangZhiBaoXianIDStr=[_yangZhiBaoXianIDStr copy];
    model.yangZhiBaoXianPriceStr=[_yangZhiBaoXianPriceStr copy];
    model.yangZhiPeiSongIsChoose=_yangZhiPeiSongIsChoose;
    model.peiSongDiZhiIsChoose=_peiSongDiZhiIsChoose;
    model.aiXinJuanZengIsChoose=_aiXinJuanZengIsChoose;
        model.price=[_price copy];
    model.yangzhiID = [_yangzhiID copy];
    
    model.yangZhiCycle =_yangZhiCycle ;
    
    model.fangAnArr = [[NSMutableArray alloc]init];
    for (NYNYangZhiFangAnModel *subModel in _fangAnArr) {
        [model.fangAnArr addObject:[subModel copy]];
    }
    
    model.zhongMoArr = [[NSMutableArray alloc]init];
    for (NYNYangZhiFangAnModel *subModel in _zhongMoArr) {
        [model.zhongMoArr addObject:[subModel copy]];
    }
    
    
    model.zhongZiMoArr = [[NSMutableArray alloc]init];
    for (NYNYangZhiFangAnModel *subModel in _zhongZiMoArr) {
        [model.zhongZiMoArr addObject:[subModel copy]];
    }

    model.zhongZhiJianKongPriceStr = _zhongZhiJianKongPriceStr;
    model.jianKongIsChoose=_jianKongIsChoose;
    model.chooseEarthCount=_chooseEarthCount;
    model.earthCycleCount=_earthCycleCount;

    
    return model;
}


@end
