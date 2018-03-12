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
    _priceLabel.text = model.price;
    _distanceLabel.text = [NSString stringWithFormat:@"距离 %@",model.distance];
    
    _addressLabel.text = model.realAddress;
    
    
    
}
@end
