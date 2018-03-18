//
//  NYNActivityModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/13.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNActivityModel : NSObject

@property(nonatomic,copy)NSString * ID;

@property(nonatomic,copy)NSString * images;

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * maxStock;
@property(nonatomic,copy)NSString * stock;

@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * startDate;
@property(nonatomic,copy)NSString * endDate;
@property(nonatomic,copy)NSString * intro;

@property(nonatomic,copy)NSString * farmId;
@property(nonatomic,copy)NSString * categoryId;
@property(nonatomic,copy)NSString * distance;

@property(nonatomic,copy)NSString * sn;//土地编号
@property(nonatomic,copy)NSString * status;//土地状态(idle:闲置；rentOut:出租中)
@property(nonatomic,copy)NSString *minRate;//土地最小租赁周期
@property(nonatomic,copy)NSString *maxRate;//土地最大租赁周期
@property(nonatomic,copy)NSString *createDate;//土地创建时间

@property(nonatomic,copy)NSString *realAddress;//农场地址
@property(nonatomic,copy)NSString *breedWay;//养殖方式

@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, strong) NSDictionary *farm;
@property (nonatomic, strong) NSString *id;

@end
