//
//  NYNChooseGuanJiaTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseGuanJiaTableViewCell.h"

@implementation NYNChooseGuanJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(void)setNameLabel:(UILabel *)nameLabel{
//    _nameLabel = nameLabel;
//    CGFloat nameLabelWith = [MyControl getTextWith:nameLabel.text andHeight:13 andFontSize:15] + 10;
//    self.nameWidth.constant = nameLabelWith;
//}
@end
