//
//  LeaseTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/22.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "LeaseTuTableViewCell.h"

@implementation LeaseTuTableViewCell

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
    NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    [_farmImage sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    
    _tudiLabel.text= model.name;
    _priceLabel.text = [NSString stringWithFormat:@"%.2f元/月", [model.price floatValue]];
    _distanceLabel.text = [NSString stringWithFormat:@"距离 %.2fkm",[model.distance floatValue]];
    _addressLabel.text = model.realAddress;
    _areaLabel.text = [NSString stringWithFormat:@"土地面积：%.0f㎡",[model.stock floatValue]];
    
}
@end
