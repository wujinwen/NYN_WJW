//
//  BuyPlayViewController.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/9.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketListModel.h"

@interface BuyPlayViewController : BaseViewController

@property(nonatomic,strong)NYNMarketListModel * lictModel;


@property(nonatomic,strong)NSString * farmId;


@property(nonatomic,strong)NSString * countString;

@property(nonatomic,assign)double yunfeiPrice;

@property(nonatomic,strong)NSString * cellCount;


@end
