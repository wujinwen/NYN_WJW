//
//  CustomModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject

@property(nonatomic,copy)NSString *  farmName;

@property(nonatomic,copy)NSString * orderSn;//订单编号
@property(nonatomic,assign)long  orderAmount;
@property(nonatomic,assign)NSInteger  farmId;
@property(nonatomic,copy)NSString * farmImg;
@property(nonatomic,copy)NSString * farmPhone;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * majorProductName;
@property(nonatomic,assign)long  majorProductPrice;//主产品名称，eg:土地名称、禽畜名称
@property(nonatomic,assign)long  majorProductQuantity;//主产品购买数量

@property(nonatomic,copy)NSString*   majorProductImg;//主产品预览图
@property(nonatomic,copy)NSString*  minorProductName;//次产品名称，eg:土地名称、禽畜名称

@property(nonatomic,assign)long minorProductPrice;//次产品单价
@property(nonatomic,assign)NSInteger  minorProductQuantity;//次产品购买数量

@property(nonatomic,copy)NSString*  minorProductImg;//次产品预览图
@property(nonatomic,assign)long  startDate;//有效期开始时间

@property(nonatomic,assign)long  endDate;//有效期结束时间

@property(nonatomic,assign)NSInteger  orderId;

@property(nonatomic,copy)NSString * orderStatus;
//pendingPayment：等待付款,pendingReview：等待审核,pendingShipment：等待发货,growing：种植,养殖中,shipped：已发货,received：已收货,completed：已完成,failed：已失败,cancel：已取消,denied：已拒绝,consum：待消费
@property(nonnull,copy)NSString * orderType;


@end
