//
//  NYNEarthLocationViewTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthLocationViewTableViewCell.h"

@implementation NYNEarthLocationViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)callAction:(id)sender {
    if (self.callBlock) {
        self.callBlock(@"");
    }
}

@end
