//
//  NYNTuDiXiangQingModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNProductExtraValuesModel.h"

@interface NYNTuDiXiangQingModel : NSObject
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *cname;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *farmId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pImg;
@property (nonatomic,copy) NSString *imgs;
@property (nonatomic,copy) NSString *sn;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *unitId;
@property (nonatomic,copy) NSString *unitName;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *ssStock;
@property (nonatomic,copy) NSString *itock;
@property (nonatomic,copy) NSString *isSale;
@property (nonatomic,copy) NSString *saleType;
@property (nonatomic,copy) NSString *saleDate;
@property (nonatomic,copy) NSString *modifyDate;
@property (nonatomic,strong) NSDictionary *farm;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *maxStock;


@property (nonatomic,strong) NSMutableArray *productExtraValues;

@property (nonatomic,strong) NSMutableArray *productImages;

@end
