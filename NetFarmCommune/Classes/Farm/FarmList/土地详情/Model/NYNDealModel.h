//
//  NYNDealModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNDealListModel.h"

@interface NYNDealModel : NSObject

@property(nonatomic,copy)NSDictionary  * farmDic;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *allocatedStock;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *amountPaid;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *areaName;
@property (nonatomic,copy) NSString *completeDate;
@property (nonatomic,copy) NSString *consignee;
@property (nonatomic,copy) NSString *consigneeInfo;
@property (nonatomic,copy) NSString *couponCode;
@property (nonatomic,copy) NSString *couponDiscount;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *cycleTime;
@property (nonatomic,copy) NSString *deliveryCorp;
@property (nonatomic,copy) NSString *deliveryCorpId;
@property (nonatomic,copy) NSString *deniedReason;
@property (nonatomic,copy) NSString *exchangePoint;
@property (nonatomic,copy) NSString *expire;
@property (nonatomic,copy) NSString *farm;
@property (nonatomic,copy) NSString *farmId;
@property (nonatomic,copy) NSString *farmManager;
@property (nonatomic,copy) NSString *farmManagerId;
@property (nonatomic,copy) NSString *fee;
@property (nonatomic,copy) NSString *freight;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *isAllocatedStock;
@property (nonatomic,copy) NSString *isExchangePoint;
@property (nonatomic,copy) NSString *isShipping;
@property (nonatomic,copy) NSString *isUseCouponCode;
@property (nonatomic,copy) NSString *logisticsNo;
@property (nonatomic,copy) NSString *memo;
@property (nonatomic,copy) NSString *modifyDate;
@property (nonatomic,copy) NSString *offsetAmount;
@property (nonatomic,copy) NSString *orderName;
@property (nonatomic,copy) NSString *oriMember;
@property (nonatomic,copy) NSString *paymentMethodId;
@property (nonatomic,copy) NSString *paymentMethodName;
@property (nonatomic,copy) NSString *paymentMethodType;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *programTotalPrice;
@property (nonatomic,copy) NSString *promotionDiscount;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *refundAmount;
@property (nonatomic,copy) NSString *returnedQuantity;
@property (nonatomic,copy) NSString *rewardPoint;
@property (nonatomic,copy) NSString *shippedQuantity;
@property (nonatomic,copy) NSString *shippingMethodId;
@property (nonatomic,copy) NSString *shippingMethodName;
@property (nonatomic,copy) NSString *sn;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *tax;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *validDate;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *zipCode;


@property (nonatomic,strong) NSMutableArray *orderItems;

@end
