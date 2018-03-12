//
//  NYNChoosePeiSongAddressTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChoosePeiSongAddressTableViewCell.h"

@implementation NYNChoosePeiSongAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (IBAction)dizhiLabel:(UIButton *)sender {
//    if (!self.block) {
//         self.block();
//    }
//   
     self.block();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
