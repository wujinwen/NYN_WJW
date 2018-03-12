//
//  FTHeaderTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/25.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTHeaderTableViewCell.h"

@implementation FTHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headerImageV.layer.cornerRadius = 23;
    self.headerImageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
