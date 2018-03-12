//
//  NYNDIYTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNDIYTableViewCell.h"

@implementation NYNDIYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickAction:(id)sender {
    if (self.cellClick) {
        self.cellClick(@"0");
    }
    
}


@end
