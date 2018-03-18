//
//  NYNEarthDataTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthDataTableViewCell.h"

@implementation NYNEarthDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NYNActivityModel *)model{
    self.nameLabel.text = model.name;
    self.kucunLabel.text = [NSString stringWithFormat:@"比赛日期%@至%@",[MyControl timeWithTimeIntervalString:model.startDate],[MyControl timeWithTimeIntervalString:model.endDate]];
    self.updateTimeLabel.text = [NSString stringWithFormat:@"人数%@/%@",model.stock,model.maxStock];
    self.pricelabel.hidden = YES;
}

@end
