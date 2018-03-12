//
//  ShopCartHeadTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/7.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ShopCartHeadTableViewCell.h"

@implementation ShopCartHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ShopCartModel *)model{
    _model=model;
    
    _farmLabel.text = model.farmName;
      [_farImage sd_setImageWithURL:[NSURL URLWithString:model.farmLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
}


- (IBAction)selectButton:(UIButton *)sender {
    _Selected = !_Selected;
    if(_Selected) {
        NSLog(@"选中");
        [_selectButton setImage:[UIImage imageNamed:@"farm_icon_selected"] forState:UIControlStateNormal];
        
        
        
    }else {
        NSLog(@"取消选中");
        [_selectButton setImage:[UIImage imageNamed:@"farm_icon_notselected3"] forState:UIControlStateNormal];
        
    }
    if (self.FarmTitleBlock) {
        self.FarmTitleBlock(_Selected,self.section);
    }
}

-(void)setCellSelect:(BOOL)select {
    _Selected = select;
    if(_Selected) {
        NSLog(@"选中");
        [_selectButton setImage:[UIImage imageNamed:@"farm_icon_selected"] forState:UIControlStateNormal];
        
        
        
    }else {
        NSLog(@"取消选中");
        [_selectButton setImage:[UIImage imageNamed:@"farm_icon_notselected3"] forState:UIControlStateNormal];
        
    }
}

@end
