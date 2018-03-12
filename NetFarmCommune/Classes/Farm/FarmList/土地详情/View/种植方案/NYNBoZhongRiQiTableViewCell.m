//
//  NYNBoZhongRiQiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNBoZhongRiQiTableViewCell.h"

@implementation NYNBoZhongRiQiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)CellClickAction:(id)sender {
    if (self.cellClick) {
        self.cellClick(@"1");
    }
    
}


@end
