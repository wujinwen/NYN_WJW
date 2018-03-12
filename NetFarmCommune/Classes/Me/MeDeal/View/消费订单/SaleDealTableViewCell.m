//
//  SaleDealTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleDealTableViewCell.h"

@implementation SaleDealTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(CustomModel *)model{
    _model =model;
    
    
    
}

@end
