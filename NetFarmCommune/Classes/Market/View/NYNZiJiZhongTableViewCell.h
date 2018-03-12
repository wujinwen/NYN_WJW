//
//  NYNZiJiZhongTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNZiJiModel.h"
@interface NYNZiJiZhongTableViewCell : UITableViewCell
@property(nonatomic,strong) NYNZiJiModel *model;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *farmLabel;
@property (weak, nonatomic) IBOutlet UILabel *juliLabel;
@end
