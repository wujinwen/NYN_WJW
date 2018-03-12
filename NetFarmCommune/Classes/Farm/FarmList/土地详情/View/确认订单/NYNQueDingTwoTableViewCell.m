//
//  NYNQueDingTwoTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNQueDingTwoTableViewCell.h"

@implementation NYNQueDingTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
