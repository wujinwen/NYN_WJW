//
//  WuLiuModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WuLiuModel : NSObject

@property(nonatomic,copy)NSString * orderSn;//订单编号
@property(nonatomic,copy)NSString * createDate;//下单时间
@property(nonatomic,copy)NSString * expressName;//快递公司

@property(nonatomic,copy)NSString * expressNo;//货运单号

@property(nonatomic,copy)NSArray * expressItems;//物流跟踪集合
@end
