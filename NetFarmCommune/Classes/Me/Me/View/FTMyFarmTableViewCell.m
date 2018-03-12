//
//  FTMyFarmTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTMyFarmTableViewCell.h"

@implementation FTMyFarmTableViewCell

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
