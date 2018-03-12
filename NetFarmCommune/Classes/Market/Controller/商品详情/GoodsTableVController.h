//
//  GoodsTableVController.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketListModel.h"

@interface GoodsTableVController : UITableViewController


@property(nonatomic,strong)NYNMarketListModel * model;
@property (nonatomic, assign) NSInteger index;

@end
