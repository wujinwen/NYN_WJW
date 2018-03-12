//
//  GoodsDealModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/3.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDealModel : NSObject


@property(nonatomic,copy)NSString  * ID;

@property(nonatomic,copy)NSString  * createDate;


@property(nonatomic,copy)NSString  * validDate;
@property(nonatomic,copy)NSString  * sn;
@property(nonatomic,copy)NSString  * farmId;

//状态, 有如下值：pendingPayment-等待付款,pendingReview-等待审核,pendingShipment-等待发货,growing-种植,养殖中,shipped-已发货,received-已收货,completed-已完成,failed-已失败,canceled-已取消,denied-已拒绝

@property(nonatomic,copy)NSString  * status;
@property(nonatomic,copy)NSString  * amount;
@property(nonatomic,copy)NSString  * freight;
@property(nonatomic,copy)NSString  * type;
@property(nonatomic,copy)NSString  * quantity;//总数量（描述住宿时代表多少"晚"）

@property(nonatomic,copy)NSDictionary  * farm;

@property(nonatomic,copy)NSArray * orderItems;







@end
