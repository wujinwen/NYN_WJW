//
//  GoumaiOneTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoumaiOneTableViewCell.h"
@interface GoumaiOneTableViewCell()

@property(nonatomic,assign)float yunfeiMoeny;
@property(nonatomic,assign)float totalPrice;
@end

@implementation GoumaiOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_messegeTextView setEditable:NO];
    _farmImage.layer.cornerRadius=40/2;
    _farmImage.clipsToBounds=YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLictModel:(NYNMarketListModel *)lictModel{
    _lictModel = lictModel;
      _farmLabel.text = _lictModel.name;
     _messegeTextView.text =_lictModel.intro;
    _productLabel.text =_lictModel.farm[@"name"];
      _priceLabel.text =[NSString stringWithFormat:@"%@/%@",lictModel.price,lictModel.unitName];

    
    if ([_lictModel.panduanBool isEqualToString:@"1"]) {
         [_productImage sd_setImageWithURL:[NSURL URLWithString:_lictModel.images] placeholderImage:[UIImage imageNamed:@"占位图"]];
         [_farmImage sd_setImageWithURL:[NSURL URLWithString:_lictModel.farm[@"images"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
    }else{
        //后台返的是json数组，我也不晓得为啥，转json取第一张图
        
        NSData *jsonData = [_lictModel.images dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
        [_productImage sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        NSArray * arr =_lictModel.farm[@"images"] ;
        
        if (arr.count>0) {
            NSData *jsonData1 = [_lictModel.farm[@"images"] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err1;
            NSArray *dic1 = [NSJSONSerialization JSONObjectWithData:jsonData1 options:NSJSONReadingMutableContainers error:&err1];
            
            [_farmImage sd_setImageWithURL:[NSURL URLWithString:dic1[0]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        }
    }
    
}
-(void)setShopModel:(ShopCartModel *)shopModel{
    _shopModel=shopModel;
      _farmLabel.text = shopModel.productName;
    _productLabel.text = shopModel.farmName;
    _priceLabel.text =shopModel.productPrice;
    
    _totallabel.text =[NSString stringWithFormat:@"合计：%.2f",[shopModel.productPrice floatValue]*[shopModel.quantity intValue] ] ;
    
     _messegeTextView.text =shopModel.productCname;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:shopModel.productImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
      [_farmImage sd_setImageWithURL:[NSURL URLWithString:shopModel.farmLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _totalPrice=[shopModel.productPrice doubleValue]*[shopModel.quantity doubleValue];
    
}

-(void)setFreightModel:(FreightModel *)freightModel{
    _freightModel = freightModel;
    if ([freightModel.freightType isEqualToString:@"free"]) {
        _yunfeiLabel.text = @"(运费：¥0.00)";
        _yunfeiMoeny =0.00;
        
    }else if ([freightModel.freightType isEqualToString:@"condition"]){
        //指定条件包邮
        if ([_shopModel.quantity intValue]<=[freightModel.quantity intValue] &&[_shopModel.quantity intValue]*[_shopModel.productPrice intValue]>=[freightModel.conditionFreight intValue]) {
              _yunfeiLabel.text = @"(运费：¥0.00)";
              _yunfeiMoeny =0.00;
        }else{
            //不包邮
            double a = [_shopModel.quantity intValue] /[freightModel.quantity intValue];
            if (a<=1) {
                _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",[freightModel.freight floatValue]];
                _yunfeiMoeny =[freightModel.freight floatValue];
                
            }else{
                int a =([_shopModel.quantity intValue] -[freightModel.quantity intValue])/ [freightModel.addQuantity intValue];
                int b = (a==0)?(a=1):a;
                float c = b*[freightModel.addFreight floatValue]+[freightModel.freight floatValue];
                _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",c];
                _yunfeiMoeny =c;
            }
            
        }
        
        
    }else{
        //不包邮
        double a = [_shopModel.quantity intValue] /[freightModel.quantity intValue];
        if (a<=1) {
            _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",[freightModel.freight floatValue]];
              _yunfeiMoeny =[freightModel.freight floatValue];
            
        }else{
            int a =([_shopModel.quantity intValue] -[freightModel.quantity intValue])/ [freightModel.addQuantity intValue];
            int b = (a==0)?(a=1):a;
            float c = b*[freightModel.addFreight floatValue]+[freightModel.freight floatValue];
              _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",c];
             _yunfeiMoeny =c;
        }
        
    }
 
    
    if (self.frieghtBlock) {
        self.frieghtBlock(_yunfeiMoeny,_totalPrice);
    }
   
    
}

@end
