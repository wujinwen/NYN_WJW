//
//  NYNMyFarmZuZhongThreeTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNMyFarmZuZhongThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabels;
@property (weak, nonatomic) IBOutlet UILabel *countLabels;
@property (weak, nonatomic) IBOutlet UILabel *priceLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PriceLabelWith;

@end
