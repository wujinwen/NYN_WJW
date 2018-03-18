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

- (void)setModel:(NYNActivityModel *)model{
    self.juliLabel.text =[NSString stringWithFormat:@"距离%.0fkm",[model.distance floatValue]];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",model.farm[@"city"],model.farm[@"area"],model.farm[@"address"]];
}

- (IBAction)callAction:(id)sender {
    if (self.callBlock) {
        self.callBlock(@"");
    }
}

@end
