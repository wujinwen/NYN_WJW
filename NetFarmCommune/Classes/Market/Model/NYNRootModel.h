//
//  NYNRootModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/23.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNRootModel : NSObject

@property(nonatomic,copy)NSString * ID;

@property(nonatomic,copy)NSString * productSn;
@property(nonatomic,copy)NSString * createDate;
@property(nonatomic,copy)NSString * productName;

@property(nonatomic,copy)NSString * farmName;
@property(nonatomic,copy)NSString *farmAddress;
@property(nonatomic,copy)NSString *farmManager;
@property(nonatomic,copy)NSArray *infos;

@end
