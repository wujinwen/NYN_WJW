//
//  ShopCartModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject

@property (nonatomic,copy) NSString *quantity;//数量
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *farmId;


@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *productImg;//产品图片
@property (nonatomic,copy) NSString *productPrice;//产品单价
@property (nonatomic,copy) NSString *productCname;//产品简介
@property (nonatomic,copy) NSString *farmName;
@property (nonatomic,copy) NSString *farmLogo;//农场logo

@property (nonatomic,copy) NSString *productType;//产品类型 general:集市 fun:娱乐相关
@end
