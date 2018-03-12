//
//  leaseDealModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/2.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface leaseDealModel : NSObject

@property(nonatomic,copy)NSString * thumbnail;

@property(nonatomic,copy)NSString * landName;

@property(nonatomic,assign)int quantity;


@property(nonatomic,assign)double price;


@property (nonatomic,copy) NSString *validDate;//生效时间

@property (nonatomic,copy) NSString *expire;//过期时间


@property(nonatomic,copy)NSString * orderId;
@property(nonatomic,copy)NSString * status;//状态（pendingReview：待审核；growing:租赁中；cancel:取消）


@property(nonatomic,assign)int maxStock;

@property(nonatomic,copy)NSString * farmName;


@property(nonatomic,copy)NSString * farmLogo;

@property(nonatomic,copy)NSString * productType;//产品类型 general:集市 fun:娱乐相关



@end
