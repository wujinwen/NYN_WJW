//
//  NYNShengWuFeiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNShengWuFeiTableViewCell.h"

@implementation NYNShengWuFeiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cellClick:(id)sender {
    
    if (self.cellClick) {
        self.cellClick(@"");
    }
}

@end
