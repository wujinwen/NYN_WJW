//
//  NYNEarthDetailTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthDetailTableViewCell.h"
#import "NYNStarsView.h"

@implementation NYNEarthDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
