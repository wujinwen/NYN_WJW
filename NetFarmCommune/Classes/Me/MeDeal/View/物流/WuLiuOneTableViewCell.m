//
//  WuLiuOneTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "WuLiuOneTableViewCell.h"

@implementation WuLiuOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WuLiuModel *)model{
    _model = model;
    
    _oderSn.text = [NSString stringWithFormat:@"订单编号:%@",model.orderSn];
    _oderTime.text = [NSString stringWithFormat:@"订单时间:%@",[MyControl timeWithTimeIntervalString:model.createDate]];
    _kuaidiTime.text=[NSString stringWithFormat:@"快递公司:%@",model.expressName];
      _huoyunLabel.text=[NSString stringWithFormat:@"货运单号:%@",model.expressNo];
}
@end
