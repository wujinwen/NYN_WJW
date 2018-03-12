//
//  LeaseTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LeaseTableViewCell.h"

@implementation LeaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//租赁档案
- (IBAction)achivesButtton:(UIButton *)sender {
}

-(void)setModel:(TudiDealModel *)model{
    _model = model;
    
}

@end
