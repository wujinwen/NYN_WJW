//
//  NYNMeAddressModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNMergerModel.h"

@interface NYNMeAddressModel : NSObject
@property (nonatomic,copy) NSString *shouHuoRenStr;
@property (nonatomic,copy) NSString *dianhuaStr;
@property (nonatomic,copy) NSString *youbianStr;
@property (nonatomic,copy) NSString *diqutr;
@property (nonatomic,copy) NSString *diquDetailStr;
@property (nonatomic,assign) BOOL isChoose;


@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *contactName;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *zipCode;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *areaId;
@property (nonatomic,copy) NSString *isDefault;
@property (nonatomic,copy) NSString *provinceId;
@property (nonatomic,strong) NSDictionary *area;


@property (nonatomic,assign) BOOL dingDanIsChoose;
@property (nonatomic,strong) NYNMergerModel *areaAddressModel;
@end
