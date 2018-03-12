//
//  GiftTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "GiftTableViewCell.h"

@implementation GiftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfoModel:(NYNLiveInfoModel *)infoModel{
    _infoModel = infoModel;
    _userName.text = infoModel.userName;
    _giftCount.text = [NSString stringWithFormat:@"x%@",infoModel.count];
    
    
}


@end
