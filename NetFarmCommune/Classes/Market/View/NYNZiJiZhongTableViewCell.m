//
//  NYNZiJiZhongTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZiJiZhongTableViewCell.h"

@implementation NYNZiJiZhongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NYNZiJiModel *)model{
    _model=model;
    
    _priceLabel.text =[NSString stringWithFormat:@"¥%@/%@",model.price,model.unitName] ;
    
    _productLabel.text =[NSString stringWithFormat:@"%@",model.name];
    _farmLabel.text = [NSString stringWithFormat:@"%@",model.farm[@"name"]];
   
    if (model.farm[@"distance"]==NULL) {
        _juliLabel.text = @"距离0m";
    }else{
         _juliLabel.text = [NSString stringWithFormat:@"距离%@m",model.farm[@"distance"]];
    }
    
    
    
}

@end
