//
//  GiftTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNLiveInfoModel.h"

@interface GiftTableViewCell : UITableViewCell

@property(nonatomic,strong)NYNLiveInfoModel * infoModel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *giftImage;

@property (weak, nonatomic) IBOutlet UILabel *giftCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
