//
//  GoodsTwoSectionViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/4.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsTwoSectionViewCell.h"
#import <Masonry/Masonry.h>


@interface GoodsTwoSectionViewCell()

@property(nonatomic,strong)UILabel * farmNameLabel;//农场名
@property(nonatomic,strong)UIButton * stateButton;//状态 类型（presell:预售；normal:开售）
@property(nonatomic,strong)UILabel * priceLabel;//价格
@property(nonatomic,strong)UILabel * timeLabel;//上架时间
@property(nonatomic,strong)UILabel * countLabel;//购买数量label
@property(nonatomic,strong)UILabel * weigthLabel;//重量label

@property(nonatomic,strong)UIButton * addButton;//数量加
@property(nonatomic,strong)UILabel * goumaiLabel;//购买数量


@property(nonatomic,strong)UIButton * jianButton;//数量减



@end


@implementation GoodsTwoSectionViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{
    [self.contentView addSubview:self.farmNameLabel];
    [self.contentView addSubview:self.stateButton];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.countLabel];
     [self.contentView addSubview:self.weigthLabel];
     [self.contentView addSubview:self.jianButton];
      [self.contentView addSubview:self.goumaiLabel];
     [self.contentView addSubview:self.addButton];
    
    [self.farmNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.width.mas_offset(180);
        make.height.mas_offset(30);
        
        
    }];

    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.farmNameLabel.mas_right).offset(5);
        make.top.mas_offset(10);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
        
        
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.farmNameLabel.mas_bottom).offset(-5);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
        
        
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.top.equalTo(self.farmNameLabel.mas_bottom).offset(5);
        make.width.mas_offset(120);
        make.height.mas_offset(30);
        
        
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
        
        
    }];
//
    [self.weigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.width.mas_offset(90);
        make.height.mas_offset(30);
        
        
    }];
    
    [self.jianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countLabel.mas_right).offset(5);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.width.mas_offset(35);
        make.height.mas_offset(35);
    }];
    
    [self.goumaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jianButton.mas_right).offset(5);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.width.mas_offset(60);
        make.height.mas_offset(35);
    }];
    
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goumaiLabel.mas_right).offset(5);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.width.mas_offset(35);
        make.height.mas_offset(35);
    }];
    
    
    
    
//
    
}


-(void)setModel:(NYNMarketListModel *)model{
    _model = model;
    _farmNameLabel.text = model.name;
    if ([model.type isEqualToString:@"normal"]) {
          [_stateButton setTitle:@"开售" forState:UIControlStateNormal];
    }else {
          [_stateButton setTitle:@"预售" forState:UIControlStateNormal];
    }

    _priceLabel.text = [NSString stringWithFormat:@"%@元/kg",model.price];
    _weigthLabel.text =  [NSString stringWithFormat:@"%@kg内包邮",model.shippingMethodId];
    
    _timeLabel.text = [NSString stringWithFormat:@"上架时间%@"];
    

    
}


-(void)addButtonClick:(UIButton*)sender{
      self.count++;
    if (self.selectClick) {
        self.selectClick(self.count);
    }
    self.goumaiLabel.text = [NSString stringWithFormat:@"%d",self.count];
}


-(void)jianButtonClick:(UIButton*)sender{
    self.count--;
    if (self.count < 1) {
        self.count = 1;
    }
    
    if (self.selectClick) {
        self.selectClick(self.count);
    }
    
    self.goumaiLabel.text = [NSString stringWithFormat:@"%d",self.count];
}
-(void)setCount:(int)count{
    _count = count;
    self.goumaiLabel.text = [NSString stringWithFormat:@"%d",self.count];
}

-(UILabel *)farmNameLabel{
    if (!_farmNameLabel) {
        _farmNameLabel = [[UILabel alloc]init];
        _farmNameLabel.textColor=[UIColor blackColor];
        _farmNameLabel.font = [UIFont systemFontOfSize:15];
        _farmNameLabel.text = @"饭好久安华高哈哈";
    }
    return _farmNameLabel;
    
}

-(UIButton *)stateButton{
    if (!_stateButton) {
        _stateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_stateButton setTitle:@"预售" forState:UIControlStateNormal];
        [_stateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _stateButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _stateButton.clipsToBounds = YES;
        _stateButton.layer.borderColor = [UIColor redColor].CGColor;
        _stateButton.layer.borderWidth = 1;
        
   
    }
    return _stateButton;
    
}

-(UILabel *)weigthLabel{
    if (!_weigthLabel) {
        _weigthLabel = [[UILabel alloc]init];
        _weigthLabel.textColor = [UIColor lightGrayColor];
        _weigthLabel.font=[UIFont systemFontOfSize:13];
        _weigthLabel.text =@"20kg内包邮";
        
    }
    return _weigthLabel;
    
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font=[UIFont systemFontOfSize:13];
         _timeLabel.text =@"上架时间:2017-5-1";
    }
    return _timeLabel;
    
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
         _priceLabel.font=[UIFont systemFontOfSize:18];
        _priceLabel.text  =@"8元/kg";
    }
    return _priceLabel;
    
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.textColor = [UIColor darkGrayColor];
        _countLabel.font=[UIFont systemFontOfSize:14];
      _countLabel.text  =@"购买数量";
    }
    return _countLabel;
    
}
-(UIButton *)jianButton{
    if (!_jianButton) {
        _jianButton = [[UIButton alloc]init];
        [_jianButton setImage:Imaged(@"farm_button_reduce") forState:UIControlStateNormal];
        [_jianButton addTarget:self action:@selector(jianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _jianButton;
    
}

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        [_addButton setImage:Imaged(@"farm_button_increase") forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addButton;
    
}

-(UILabel *)goumaiLabel{
    if (!_goumaiLabel) {
        _goumaiLabel = [[UILabel alloc]init];
        _goumaiLabel.textColor = [UIColor blackColor];
        _goumaiLabel.font = [UIFont systemFontOfSize:14];
         _goumaiLabel.text = @"0";
        _goumaiLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _goumaiLabel;
    
}

@end
