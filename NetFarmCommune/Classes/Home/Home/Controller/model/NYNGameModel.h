//
//  NYNGameModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/13.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNGameModel : NSObject
@property(nonatomic,copy)NSString * ID;

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * images;

@property(nonatomic,copy)NSString * maxStock;//最大库存
@property(nonatomic,copy)NSString * price;

@property(nonatomic,copy)NSString * signUpStartDate;//报名时间

@property(nonatomic,copy)NSString * signUpEndDate;//报名截止时间

@property(nonatomic,copy)NSString * startDate;//比赛开始时间

@property(nonatomic,copy)NSString *endDate;//比赛结束时间

@property(nonatomic,copy)NSString * thumbnail;


@property(nonatomic,copy)NSDictionary * farm;
@property(nonatomic,copy)NSString *distance;

@property(nonatomic,copy)NSString *stock;//当前库存

@property(nonatomic,copy)NSString *address;

@end
