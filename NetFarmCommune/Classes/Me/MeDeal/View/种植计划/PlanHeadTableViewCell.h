//
//  PlanHeadTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/7.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end
