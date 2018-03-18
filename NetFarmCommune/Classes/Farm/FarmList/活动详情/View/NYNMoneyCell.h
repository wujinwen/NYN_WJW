//
//  NYNMoneyCell.h
//  NetFarmCommune
//
//  Created by ff on 2018/3/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNActivityModel.h"

@interface NYNMoneyCell : UITableViewCell

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) NYNActivityModel *model;

@end
