//
//  NYNZuDiZhonZhiModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNZuDiZhonZhiModel : NSObject

@property (nonatomic,copy) NSString *cameraPrice;
@property (nonatomic,copy) NSString *cycleTime;
@property (nonatomic,copy) NSString *freight;
@property (nonatomic,copy) NSString *majorProductId;
@property (nonatomic,copy) NSString *majorProductName;
@property (nonatomic,copy) NSString *majorProductPrice;
@property (nonatomic,copy) NSString *majorProductQuantity;
@property (nonatomic,copy) NSString *majorProductRate;
@property (nonatomic,copy) NSString *majorProductUnit;
@property (nonatomic,copy) NSString *managerName;
@property (nonatomic,copy) NSString *minorProductId;
@property (nonatomic,copy) NSString *minorProductName;
@property (nonatomic,copy) NSString *minorProductPrice;
@property (nonatomic,copy) NSString *minorProductQuantity;//次产品购买数量
@property (nonatomic,copy) NSString *minorProductUnit;
@property (nonatomic,copy) NSString *orderAmount;
@property (nonatomic,copy) NSString *orderName;
@property (nonatomic,copy) NSString *processName;
@property (nonatomic,copy) NSString *processTotalPrice;
@property (nonatomic,copy) NSString *programTotalPrice;
@property (nonatomic,copy) NSString *shipAddress;
@property (nonatomic,copy) NSString *shipConsignee;
@property (nonatomic,copy) NSString *shipConsigneeInfo;
@property (nonatomic,copy) NSString *shipPhone;
@property (nonatomic,copy) NSString *signboardName;//标志牌名称
@property (nonatomic,copy) NSString *signboardPrice;

@property (nonatomic,copy) NSString *monitorPrice;
@end
