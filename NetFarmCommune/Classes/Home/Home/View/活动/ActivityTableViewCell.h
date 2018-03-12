//
//  ActivityTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNActivityModel.h"
@interface ActivityTableViewCell : UITableViewCell
@property(nonatomic,copy) NYNActivityModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
