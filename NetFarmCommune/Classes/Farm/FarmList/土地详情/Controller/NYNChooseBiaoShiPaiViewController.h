//
//  NYNChooseBiaoShiPaiViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNBiaoShiPaiModel.h"

typedef void(^ChooseBlock) (NYNBiaoShiPaiModel *model);

@interface NYNChooseBiaoShiPaiViewController : BaseViewController
@property (nonatomic,copy) NSString *farmID;
@property (nonatomic,copy) ChooseBlock chooseBlock;
@property (nonatomic,copy) NSString *type;//0-种植，1-养殖
@end
