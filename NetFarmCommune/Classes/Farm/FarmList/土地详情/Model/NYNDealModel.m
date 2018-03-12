//
//  NYNDealModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNDealModel.h"

@implementation NYNDealModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
               @"farmDic":@"farm",
             @"address" : @"address",
             @"allocatedStock":@"allocatedStock",
             @"amount":@"amount",
             @"amountPaid" : @"amountPaid",
             @"area":@"area",
             @"areaName" : @"areaName",
             @"completeDate":@"completeDate",
             @"consignee" : @"consignee",
             @"consigneeInfo" : @"consigneeInfo",
             @"couponCode" : @"couponCode",
             @"couponDiscount" : @"couponDiscount",
             @"createDate" : @"createDate",
             @"cycleTime" : @"cycleTime",
             @"deliveryCorp" : @"deliveryCorp",
             @"deliveryCorpId" : @"deliveryCorpId",
             @"deniedReason" : @"deniedReason",
             @"exchangePoint" : @"exchangePoint",
             @"expire" : @"expire",
             @"farm" : @"farm",
             @"farmId" : @"farmId",
             @"farmManager" : @"farmManager",
             @"farmManagerId" : @"farmManagerId",
             @"fee" : @"fee",
             @"freight" : @"freight",
             @"ID" : @"id",
             @"isAllocatedStock" : @"isAllocatedStock",
             @"isExchangePoint" : @"isExchangePoint",
             @"isShipping" : @"isShipping",
             @"isUseCouponCode" : @"isUseCouponCode",
             @"logisticsNo" : @"logisticsNo",
             @"memo" : @"memo",
             @"modifyDate" : @"modifyDate",
             @"offsetAmount" : @"offsetAmount",
             @"orderName" : @"orderName",
             @"oriMember" : @"oriMember",
             @"paymentMethodId" : @"paymentMethodId",
             @"paymentMethodName" : @"paymentMethodName",
             @"paymentMethodType" : @"paymentMethodType",
             @"phone" : @"phone",
             @"price" : @"price",
             @"programTotalPrice" : @"programTotalPrice",
             @"promotionDiscount" : @"promotionDiscount",
             @"quantity" : @"quantity",
             @"refundAmount" : @"refundAmount",
             @"returnedQuantity" : @"returnedQuantity",
             @"rewardPoint" : @"rewardPoint",
             @"shippedQuantity" : @"shippedQuantity",
             @"shippingMethodId" : @"shippingMethodId",
             @"shippingMethodName" : @"shippingMethodName",
             @"sn" : @"sn",
             @"status" : @"status",
             @"tax" : @"tax",
             @"type" : @"type",
             @"validDate" : @"validDate",
             @"weight" : @"weight",
             @"zipCode" : @"zipCode",
             @"orderItems" : @"orderItems"
           
             };
}

// 这个方法对比上面的2个方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+ (NSDictionary *)objectClassInArray{
    return @{
             @"orderItems" : @"NYNDealListModel"
             };
}

- (NSMutableArray *)orderItems{
    if (!_orderItems) {
        _orderItems = [[NSMutableArray alloc]init];
    }
    return _orderItems;
}
@end
