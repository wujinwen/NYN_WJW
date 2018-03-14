//
//  PayViewTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PayViewTableViewCell.h"

@implementation PayViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(NYNGameModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    [_farmImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _addressLabel.text = model.address;
    _timeLabel.text=[NSString stringWithFormat:@"日期%@至%@",[MyControl timeWithTimeIntervalString:model.startDate],[MyControl timeWithTimeIntervalString:model.startDate]] ;
    _peopleLabel.text =[NSString stringWithFormat:@"人数%@/%@",model.stock,model.maxStock];
    _jubanfangLabel.text = [NSString stringWithFormat:@"主办方：%@",model.farm[@"name"]];
}

@end
