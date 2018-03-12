//
//  CustomProductTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "CustomProductTVCell.h"

@interface CustomProductTVCell()

@property(nonatomic,strong)NSString * stateString;
@property(nonatomic,assign)NSInteger  farmId;

@property(nonatomic,assign)NSString * farmPhone;

@end


@implementation CustomProductTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImage.layer.cornerRadius=20;
    _headImage.clipsToBounds=YES;
    
    _payBtn.layer.cornerRadius=5;
    _payBtn.clipsToBounds=YES;
    _payBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _payBtn.layer.borderWidth =1;
    
    _planButton.layer.cornerRadius=5;
    _planButton.clipsToBounds=YES;
    _planButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _planButton.layer.borderWidth =1;
    
    

}


-(void)setCustomModel:(CustomModel *)customModel{
    _customModel = customModel;
    _farmLabel.text = customModel.farmName;
    
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:customModel.farmImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if (customModel.majorProductImg != nil) {
        [_messegeImage sd_setImageWithURL:[NSURL URLWithString:customModel.farmImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    }
    
    
    _productLabel.text = customModel.minorProductName;
    if ([customModel.orderStatus isEqualToString:@"pendingPayment"]) {
        _stateLabel.text =@"待付款";
        
    }else if ([customModel.orderStatus isEqualToString:@"pendingReview"]){
          _stateLabel.text =@"待审核";
         _payBtn.hidden=YES;
        
        
    }else if ([customModel.orderStatus isEqualToString:@"pendingShipment"]){
         _stateLabel.text =@"待发货";
        
    }else if ([customModel.orderStatus isEqualToString:@"growing"]){

        NSString*str = [NSString stringWithFormat:@"%ld",customModel.startDate];
        NSString*str1 = [NSString stringWithFormat:@"%ld",customModel.endDate];
        _stateLabel.text = [NSString stringWithFormat:@"有效日期：%@ 至 %@",[MyControl timeWithTimeIntervalString:str],[MyControl timeWithTimeIntervalString:str1]];
        [_payBtn setTitle:@"查看进度" forState:UIControlStateNormal];
        

        
    }else if ([customModel.orderStatus isEqualToString:@"shipped"]){
        _stateLabel.text =@"已发货";
        
    }else if ([customModel.orderStatus isEqualToString:@"received"]){
        _stateLabel.text =@"已收货";
    }else if ([customModel.orderStatus isEqualToString:@"consum"]){
        _stateLabel.text =@"已拒绝";
    }else if ([customModel.orderStatus isEqualToString:@"denied"]){
        _stateLabel.text =@"已取消";
    }
    else{
         _stateLabel.text =@"待消费";
    }

    _garbageInteger = customModel.orderId;
    
    _stateString=customModel.orderStatus;
    
    if ([customModel.orderType isEqualToString:@"plant"]) {
        [_planButton setTitle:@"种植计划" forState:UIControlStateNormal];
        
        
    }else if ([customModel.orderType isEqualToString:@"grow"]){
          [_planButton setTitle:@"养殖计划" forState:UIControlStateNormal];
    }
    
    if (_selectInteger == 500) {
        
          _yangzhiCountLabel.text=[NSString stringWithFormat:@"种植面积:%ld㎡",customModel.majorProductQuantity];
        
    }else if (_selectInteger ==501){
        _yangzhiCountLabel.text=[NSString stringWithFormat:@"养殖数量:%ld",customModel.majorProductQuantity];
        
        
    }else{
        
    }
    
    
    _styleLabel.text =customModel.majorProductName;
    _farmId = customModel.farmId;
    
    _farmPhone = customModel.farmPhone;
    
    
}
//付款
- (IBAction)payButtonClick:(UIButton *)sender  {


      [self.delegate payMoneyClick:_farmId model:_customModel state:_stateString];
    
}
//养殖计划
- (IBAction)planButtonClick:(UIButton *)sender {
    if ([_stateString isEqualToString:@"growing"]) {
            [self.delegate planClickIndex:_planIndex orderId:[NSString stringWithFormat:@"%ld",(long)_garbageInteger]];
    }

    
    
}

//废纸篓
- (IBAction)lajiButtonClick:(UIButton *)sender {
 

    [self.delegate garbageClickInteger:_garbageInteger state:_stateString index:_planIndex];
    
}
- (IBAction)phoneButtonClick:(UIButton *)sender {
    [self.delegate plantClick:_farmPhone];
    
    
}

@end
