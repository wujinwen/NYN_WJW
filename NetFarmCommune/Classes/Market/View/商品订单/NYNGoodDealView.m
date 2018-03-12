//
//  NYNGoodDealView.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNGoodDealView.h"
#import <Masonry/Masonry.h>
@interface NYNGoodDealView()
@property(nonatomic,strong)UILabel * farmNameLabel;//农场名
@property(nonatomic,strong)UIButton * stateButton;//状态 类型（presell:预售；normal:开售）
@property(nonatomic,strong)UILabel * priceLabel;//价格
@property(nonatomic,strong)UILabel * timeLabel;//上架时间
@property(nonatomic,strong)UILabel * countLabel;//购买数量label
@property(nonatomic,strong)UILabel * weigthLabel;//重量label

@property(nonatomic,strong)UIButton * addButton;//数量加
@property(nonatomic,strong)UILabel * goumaiLabel;//购买数量


@property(nonatomic,strong)UIButton * jianButton;//数量减


@property(nonatomic,strong)UIButton * backButton;//返回

@end


@implementation NYNGoodDealView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(180)) delegate:self placeholderImage:PlaceImage];
    //    bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:_iamgeArr];
    self.bannerScrollView = bannerScrollView;
    bannerScrollView.delegate = self;
    [self addSubview:bannerScrollView];

    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerScrollView.frame), SCREENWIDTH, 110)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondView];
    
    
    [secondView addSubview:self.farmNameLabel];
    [secondView addSubview:self.stateButton];
    [secondView addSubview:self.priceLabel];
    [secondView addSubview:self.timeLabel];
    [secondView addSubview:self.countLabel];
    [secondView addSubview:self.weigthLabel];
    [secondView addSubview:self.jianButton];
    [secondView addSubview:self.goumaiLabel];
    [secondView addSubview:self.addButton];
    
    [self.farmNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.width.mas_offset(180);
        make.height.mas_offset(30);
        
        
    }];
    
    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
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
        make.width.mas_offset(70);
        make.height.mas_offset(30);
        
        
    }];
    //
    [self.weigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.width.mas_offset(110);
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
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(5);
        make.top.equalTo(self.addButton.mas_bottom).offset(JZWITH(10));
        make.left.right.mas_offset(0);
        
    }];
    
    
}

-(void)setModel:(NYNMarketListModel *)model{
    _model =model;
    NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    self.bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:dic];

    _farmNameLabel.text = model.name;
    if ([model.type isEqualToString:@"normal"]) {
        [_stateButton setTitle:@"开售" forState:UIControlStateNormal];
    }else {
        [_stateButton setTitle:@"预售" forState:UIControlStateNormal];
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"%@元/kg",model.price];
    _weigthLabel.text =  [NSString stringWithFormat:@"%@kg内包邮",model.shippingMethodId];
    _timeLabel.text = [NSString stringWithFormat:@"上架时间：%@",[MyControl timeWithTimeIntervalString:model.saleDate]];
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
        _stateButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _stateButton.clipsToBounds = YES;
        _stateButton.layer.borderColor = [UIColor redColor].CGColor;
        _stateButton.layer.borderWidth = 1;
        _stateButton.layer.cornerRadius=5;
        
        
    }
    return _stateButton;
    
}

-(UILabel *)weigthLabel{
    if (!_weigthLabel) {
        _weigthLabel = [[UILabel alloc]init];
        _weigthLabel.textColor = [UIColor lightGrayColor];
        _weigthLabel.font=[UIFont systemFontOfSize:11];
        _weigthLabel.text =@"20kg内包邮";
        
    }
    return _weigthLabel;
    
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font=[UIFont systemFontOfSize:11];
        _timeLabel.text =@"上架时间:2017-5-1";
    }
    return _timeLabel;
    
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font=[UIFont systemFontOfSize:12];
        _priceLabel.text  =@"8元/kg";
    }
    return _priceLabel;
    
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.font=[UIFont systemFontOfSize:16];
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
-(UIButton *)backButton{
    if (!_backButton) {
        
    }
    return _backButton;
    
}
@end
