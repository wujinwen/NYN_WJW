//
//  NYNHelpTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNHelpTableViewCell.h"

@implementation NYNHelpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNHelpModel *)model{
//    _model = model;
//    self.questionLabel.text = model.questionStr;
//    self.questionLabel.
}
@end
