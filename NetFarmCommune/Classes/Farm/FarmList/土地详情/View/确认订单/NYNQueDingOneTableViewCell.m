//
//  NYNQueDingOneTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNQueDingOneTableViewCell.h"

@implementation NYNQueDingOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 12;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
