//
//  NYNXuanZeZhongZiModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNXuanZeZhongZiModel : NSObject
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *cname;
@property (nonatomic,copy) NSString *farm;

@property (nonatomic,copy) NSString *farmId;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *imgs;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *isHot;
@property (nonatomic,copy) NSString *isSale;
@property (nonatomic,copy) NSString *isStock;
@property (nonatomic,copy) NSString *isTop;
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
//@property (nonatomic,strong) NSDictionary *productExtraValues;
@property (nonatomic,strong) NSArray *productExtraValues;
@property (nonatomic,copy) NSString *cycleTime;

@property(nonatomic,strong)NSString * images;

@property(nonatomic,strong)NSString * maxStock;


@property (nonatomic,assign) BOOL isChoose;
@property (nonatomic,assign) int selectCount;
@end
