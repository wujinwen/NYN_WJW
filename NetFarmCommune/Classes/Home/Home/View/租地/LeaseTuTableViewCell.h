//
//  LeaseTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/22.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNActivityModel.h"

@interface LeaseTuTableViewCell : UITableViewCell
@property(nonatomic,strong) NYNActivityModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *farmImage;
@property (weak, nonatomic) IBOutlet UILabel *tudiLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
