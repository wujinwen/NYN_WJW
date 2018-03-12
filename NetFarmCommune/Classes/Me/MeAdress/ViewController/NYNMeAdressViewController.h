//
//  NYNMeAdressViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNMeAddressModel.h"

typedef void(^AddressClickBlock)(NYNMeAddressModel *model);
@interface NYNMeAdressViewController : BaseViewController
@property (nonatomic,copy) AddressClickBlock addressClickBlock;
@end
