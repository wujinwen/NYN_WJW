//
//  NYNMarketListModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNMarketListModel : NSObject
@property (nonatomic,copy) NSString *defaultUserAddressId;
@property (nonatomic,copy) NSString *defaultUserAddressTitle;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *contactName;

@property(nonatomic,copy)NSString * panduanBool;


@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *cname;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *cycleTime;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *farmId;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *isHot;
@property (nonatomic,copy) NSString *isSale;
@property (nonatomic,copy) NSString *isStock;
@property (nonatomic,copy) NSString *isTop;
@property (nonatomic,copy) NSString *maxRate;
@property (nonatomic,copy) NSString *maxStock;
@property (nonatomic,copy) NSString *minRate;
@property (nonatomic,copy) NSString *modifyDate;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *orderBy;
@property (nonatomic,copy) NSString *pImg;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *saleDate;
@property (nonatomic,copy) NSString *saleType;
@property (nonatomic,copy) NSString *sn;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *unitId;
@property (nonatomic,copy) NSString *unitName;

@property (nonatomic,copy) NSDictionary *productImages;
@property (nonatomic,copy) NSMutableDictionary *farm;

@property (nonatomic,copy) NSString *type;//类型（presell:预售；normal:开售）

@property (nonatomic,copy) NSString *fullCategoryName;//分类全称

@property(nonatomic,copy)NSString * images;

@property(nonatomic,copy)NSString * shippingMethodId;

@property(nonatomic,copy)NSArray * intros;

@property(nonatomic,copy)NSString * monthSales;//月销量

@property(nonatomic,copy)NSDictionary* shippingMethod;

@end
