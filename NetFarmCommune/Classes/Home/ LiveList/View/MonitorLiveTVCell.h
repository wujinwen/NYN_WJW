//
//  MonitorLiveTVCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GiftListModel.h"


@interface MonitorLiveTVCell : UITableViewCell


@property(nonatomic,strong)GiftListModel * listModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *liftNameLabel;


@property (weak, nonatomic) IBOutlet UIImageView *liftImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
