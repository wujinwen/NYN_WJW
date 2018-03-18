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
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_offset(21);
    }];
    
    
    self.stateLable.layer.borderWidth = 1;
    self.stateLable.layer.borderColor = [UIColor greenColor].CGColor;
    self.stateLable.layer.cornerRadius = 3;
    self.stateLable.layer.masksToBounds = YES;
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_offset(21);
        make.width.mas_offset(70);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(NYNGameModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    [_farmImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _addressLabel.text = model.address;
    _timeLabel.text=[NSString stringWithFormat:@"比赛日期%@至%@",[MyControl timeWithTimeIntervalString:model.startDate],[MyControl timeWithTimeIntervalString:model.endDate]] ;
    _peopleLabel.text =[NSString stringWithFormat:@"人数%@/%@",model.stock,model.maxStock];
    _jubanfangLabel.text = [NSString stringWithFormat:@"主办方：%@",model.farm[@"name"]];
    _distanceLabel.text = [NSString stringWithFormat:@"距离%@km",model.distance];
}

@end
