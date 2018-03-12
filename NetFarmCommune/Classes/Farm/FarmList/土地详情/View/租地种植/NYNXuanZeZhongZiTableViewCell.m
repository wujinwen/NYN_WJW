//
//  NYNXuanZeZhongZiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNXuanZeZhongZiTableViewCell.h"

@implementation NYNXuanZeZhongZiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.rowImageView.image = Imaged(@"mine_icon_more");
    self.zhanweiLabel.hidden = YES;
    self.cardLabel.hidden=NO;
    
    
}



-(void)setModel:(NYNZuDiZhonZhiModel *)model{
    _model=model;
    
    
    
 
    if (_indexpath == 0) {
         self.zhongziLabel.hidden=NO;
           _zhongziLabel.text = model.majorProductName;
        
    }else if (_indexpath==1){
        
        if (_indexpathRow ==0) {
            
        }else if (_indexpathRow==1){
            
        }else if (_indexpathRow==2){
            _contentLabel.hidden = NO;
            _contentLabel.text =model.majorProductName;
            
        }else if (_indexpathRow==3){
              _priceLabel.hidden = NO;
            _contentLabel.text =model.signboardName ;
            _priceLabel.text =[NSString stringWithFormat:@"%@",model.signboardPrice] ;
        }
        
    }else if (_indexpath==2){
        if (_indexpathRow==0) {
                 _priceLabel.hidden = NO;
               _priceLabel.text = model.processName;
        }else{
                _contentLabel.text=model.processTotalPrice;
        }
        
        
    }else if (_indexpath ==3){
          _zhongziLabel.text = model.shipAddress;
    }
    
}

@end
