//
//  ActivityTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNActivityModel *)model{
    _model = model;
    _productLabel.text = model.name;
    NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    if (model.distance == NULL) {
            _distanceLabel.text =@"距离0m";
    }else{
        _distanceLabel.text = [NSString stringWithFormat:@"距离%@m",model.distance];
    }
    
    
    
    _peopleLabel.text =[NSString stringWithFormat:@"当前人数：%@",model.stock];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元/人",model.price];
    _timeLabel.text = [NSString stringWithFormat:@"活动日期：%@ 至 %@",[MyControl timeWithTimeIntervalString:model.startDate],[MyControl timeWithTimeIntervalString:model.endDate]];
    
    
    
    
}
@end
