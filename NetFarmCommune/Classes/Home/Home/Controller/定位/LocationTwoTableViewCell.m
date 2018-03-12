//
//  LocationTwoTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LocationTwoTableViewCell.h"

@implementation LocationTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cityOneBtn.layer.borderWidth = 1;
    _cityOneBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _cityOneBtn.layer.masksToBounds = YES;
    _cityOneBtn.layer.cornerRadius = 5;
    _cityOneBtn.layer.borderWidth = 1;
    
    _cityTwoBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _cityTwoBtn.layer.masksToBounds = YES;
    _cityTwoBtn.layer.cornerRadius = 5;
    _cityTwoBtn.layer.borderWidth = 1;
    
    
    _cityThreeBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _cityThreeBtn.layer.masksToBounds = YES;
    _cityThreeBtn.layer.cornerRadius = 5;
        _cityThreeBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
