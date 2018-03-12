//
//  LiveMessegeBoomVIew.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LiveMessegeBoomVIew.h"

#import "Masonry.h"

@implementation LiveMessegeBoomVIew

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}
-(void)initiaInterface{
    UIColor * color= [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.2];
    
    _speakButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _speakButton.titleLabel.font =[UIFont systemFontOfSize:15];
    
    _speakButton.frame = CGRectMake(10, 0, SCREENWIDTH-170, 30);
    [_speakButton setTitle:@"说点什么" forState:UIControlStateNormal];
    [_speakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_speakButton addTarget:self action:@selector(showInputBar:) forControlEvents:UIControlEventTouchUpInside];
    _speakButton.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    [self addSubview:_speakButton];
    

    
    _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goodButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [_goodButton addTarget:self action:@selector(zanButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goodButton];
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.width.height.mas_offset(30);
    }];
    
    
    
    _giftButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [_giftButton setImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];
    [_giftButton addTarget:self action:@selector(flowerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_giftButton];
    [_giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_goodButton.mas_left).offset(-10);
        make.width.height.mas_offset(30);
        make.top.mas_offset(0);
    }];
    
    _lianmaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lianmaiButton setTitle:@"连麦" forState:UIControlStateNormal];
    [_lianmaiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lianmaiButton addTarget:self action:@selector(lianmaiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_lianmaiButton];
    [_lianmaiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_giftButton.mas_left).offset(-10);
        make.height.mas_offset(30);
        make.bottom.mas_offset(-2);
        make.width.mas_offset(60);
    }];
    
}
//评论
-(void)showInputBar:(UIButton*)sender{
    if (self.commentClick) {
        self.commentClick(sender);
        
    }
}
//点赞
-(void)zanButton:(UIButton*)sender{
    if (self.zanClick) {
        self.zanClick(sender);
        
    }
    
    
}
//连麦
-(void)lianmaiButtonClick:(UIButton*)sender{
    if (self.lianmaiClick) {
        self.lianmaiClick(sender);
        
    }
    
}
//礼物
-(void)flowerButtonPressed:(UIButton*)sender{
    if (self.liftClick) {
        self.liftClick(sender);
    }
    
}

@end
