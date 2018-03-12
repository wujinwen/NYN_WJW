//
//  NYNXiangXiShuoMingTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNXiangXiShuoMingTableViewCell.h"

@implementation NYNXiangXiShuoMingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textV.placehoder = @"输入您的信息以及想法或建议";
    
    self.textV.layer.borderWidth = .5;
    self.textV.layer.borderColor = Colore3e3e3.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
