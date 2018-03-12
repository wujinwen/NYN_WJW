//
//  GoodsThreeTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/8.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NYNMarketListModel.h"
@interface GoodsThreeTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * headLabel;

@property(nonatomic,strong)UILabel * titleLabel;


@property(nonatomic,strong)NYNMarketListModel * model;

@property(nonatomic,strong)NSString* indexpath;



@end
