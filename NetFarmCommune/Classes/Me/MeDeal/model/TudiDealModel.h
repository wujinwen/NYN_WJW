//
//  TudiDealModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TudiDealModel : NSObject

@property(nonatomic,copy)NSString * thumbnail;//图片url

@property(nonatomic,copy)NSString * landName;

@property(nonatomic,assign)int  quantity;//租地面积

@property(nonatomic,assign)long  price;

@property(nonatomic,copy)NSString * validDate;//生效时间


@property(nonatomic,copy)NSString * expire;//过期时间

@property(nonatomic,assign)int  orderId;

@property(nonatomic,copy)NSString * status;

@property(nonatomic,copy)NSString * farmName;

@property(nonatomic,copy)NSString * imgUrl;

@property(nonatomic,copy)NSString * phone;

@property(nonatomic,assign)int  maxStock;

@property(nonatomic,assign)int  userId;

@end
