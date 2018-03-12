//
//  MonitorLiveTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MonitorLiveTVCell.h"

@implementation MonitorLiveTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headImage.layer.cornerRadius = 25;
    _headImage.clipsToBounds=YES;
    
  
}


-(void)setListModel:(GiftListModel *)listModel{
    _listModel = listModel;

    
        [self.liftImage sd_setImageWithURL:[NSURL URLWithString:listModel.giftImg]];
        self.liftNameLabel.text =listModel.giftName;
}

@end
