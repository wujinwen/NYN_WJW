//
//  ChooseLandTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ChooseLandTableViewCell.h"

@implementation ChooseLandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNXuanZeZhongZiModel *)model{
    _model = model;
//    NSString * str = model.images;
//    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    [_headImageView  sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    
    
    _landLabel.text = model.name;
    
    _priceLabel.text = [NSString stringWithFormat:@" %@/m²/天",model.price];
    _areaLabel.text = [NSString stringWithFormat:@"土地面积: %@",model.maxStock];
    _peopleLabel.text = [NSString stringWithFormat:@"种植人数: %@",model.maxStock];
}
@end
