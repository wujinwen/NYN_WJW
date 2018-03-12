//
//  ShopCartTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ShopCartTableViewCell.h"

@interface ShopCartTableViewCell()

@property(nonatomic,strong)NSString * productID;//产品id

@property(nonatomic,strong)NSString * productType;//产品类型
@end


@implementation ShopCartTableViewCell


-(void)setModel:(ShopCartModel *)model{
    _model = model;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.farmLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _farmLaebl.text =model.farmName;
    _messegeTextV.text = model.productCname;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.productPrice];
    _countLabel.text =[NSString stringWithFormat:@"X%@",model.quantity];
    _totalPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[model.productPrice doubleValue]*[model.quantity doubleValue]];
    _productID = model.productId;
    _productType = model.productType;
    [_productLogoImage sd_setImageWithURL:[NSURL URLWithString:model.productImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    
    
}


- (IBAction)garbageBtn:(UIButton *)sender {
    [self.delaget garbageProductId:_productID productType:_productType];
    
    
    
}

- (IBAction)smallSelectBtn:(UIButton *)sender {
    _smallSelected = !_smallSelected;
    if(_smallSelected) {
        [_smallButton setImage:[UIImage imageNamed:@"farm_icon_selected"] forState:UIControlStateNormal];
        
    }else {
        [_smallButton setImage:[UIImage imageNamed:@"farm_icon_notselected3"] forState:UIControlStateNormal];
        
    }
    
    if (self.block) {
        self.block(_smallButton, self.section, self.row);
    }
        
    
}

-(void)setCellSelect:(BOOL)select {
    _smallSelected = select;
    if(_smallSelected) {
        [_smallButton setImage:[UIImage imageNamed:@"farm_icon_selected"] forState:UIControlStateNormal];
        
    }else {
        [_smallButton setImage:[UIImage imageNamed:@"farm_icon_notselected3"] forState:UIControlStateNormal];
        
    }
}
@end
