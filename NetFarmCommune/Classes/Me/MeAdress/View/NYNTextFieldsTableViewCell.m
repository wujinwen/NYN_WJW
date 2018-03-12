//
//  NYNTextFieldsTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNTextFieldsTableViewCell.h"

@implementation NYNTextFieldsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.detailTextView.placehoder = @"请填写详细地址，不少于5个字";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
