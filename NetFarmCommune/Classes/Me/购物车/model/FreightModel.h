//
//  FreightModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/8.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreightModel : NSObject

@property(nonatomic,copy)NSString * freightType;

@property(nonatomic,copy)NSString * freeType;

@property(nonatomic,copy)NSString * quantity;//数量

@property(nonatomic,copy)NSString * freight;
@property(nonatomic,copy)NSString * addQuantity;
@property(nonatomic,copy)NSString * addFreight;
@property(nonatomic,copy)NSString * conditionFreeType;
@property(nonatomic,copy)NSString * conditionQuantity;
@property(nonatomic,copy)NSString * conditionFreight;
@property(nonatomic,copy)NSString * productId;
@end
