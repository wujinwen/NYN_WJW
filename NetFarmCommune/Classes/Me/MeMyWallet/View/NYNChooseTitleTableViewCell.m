//
//  NYNChooseTitleTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseTitleTableViewCell.h"

@implementation NYNChooseTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
