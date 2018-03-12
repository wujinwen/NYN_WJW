//
//  PayViewTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNGameModel.h"
@interface PayViewTableViewCell : UITableViewCell
@property(nonatomic,copy)  NYNGameModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *farmImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jubanfangLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
