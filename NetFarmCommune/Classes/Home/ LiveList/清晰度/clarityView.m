//
//  clarityView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "clarityView.h"
#import "Masonry.h"

@interface clarityView()

@property(nonatomic,strong)UIButton *BDBtn;//标清
@property(nonatomic,strong)UIButton * HDBtn;//高清
@property(nonatomic,strong)UIButton * SHBTN;//超清


@end

@implementation clarityView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        [self initiaInterface];
        UIColor * color = [UIColor blackColor];
        self.backgroundColor = [color colorWithAlphaComponent:0.7];
        
        
    }
    return self;
    
}

-(void)initiaInterface{
    
    UILabel * qingxiLabel = [[UILabel alloc]init];
    qingxiLabel.text = @"清晰度";
    qingxiLabel.textColor=[UIColor whiteColor];
    qingxiLabel.font =[UIFont systemFontOfSize:16];
    [self addSubview:qingxiLabel];
    [qingxiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.width.mas_offset(90);
        make.height.mas_offset(30);
        make.centerX.mas_equalTo(self);
    }];
    //退出
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"home_icon_delete_2.png"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_offset(10);
           make.height.width.mas_offset(20);
           make.right.mas_offset(-20);
        
        
    }];
    
    
    //标清
    _BDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_BDBtn setTitle:@"标清" forState:UIControlStateNormal];
    _BDBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_BDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_BDBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [_BDBtn addTarget:self action:@selector(BDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_BDBtn];
    [_BDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qingxiLabel.mas_bottom).offset(15);
        make.width.mas_offset(SCREENWIDTH/3);
        make.height.mas_offset(30);
        make.left.mas_offset(0);
        
    }];
    
    //高清
    _HDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_HDBtn setTitle:@"高清" forState:UIControlStateNormal];
    [_HDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _HDBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_HDBtn addTarget:self action:@selector(HDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_HDBtn];
    [_HDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qingxiLabel.mas_bottom).offset(15);
        make.width.mas_offset(SCREENWIDTH/3);
        make.height.mas_offset(30);
        make.left.mas_equalTo(SCREENWIDTH/3);
        
        
    }];
    //超清
    _SHBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [_SHBTN setTitle:@"超清" forState:UIControlStateNormal];
    [_SHBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _SHBTN.titleLabel.font = [UIFont systemFontOfSize:16];
    [_SHBTN addTarget:self action:@selector(SHBTNClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_SHBTN];
    [_SHBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qingxiLabel.mas_bottom).offset(15);
        make.width.mas_offset(SCREENWIDTH/3);
        make.height.mas_offset(30);
        make.left.mas_equalTo(SCREENWIDTH/3*2);

    }];
    
    

    
}
//删除
-(void)deleteBtnClick:(UIButton*)sender{
    self.hidden=YES;
    
    
}
//高清
-(void)HDBtnClick:(UIButton*)sender{

    sender.selected =!sender.selected;

    [_HDBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_HDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.delagate HDBtnClickEvent:sender];
    
    
    
}
//标清
-(void)BDBtnClick:(UIButton*)sender{
    sender.selected =!sender.selected;
    [_BDBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_BDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.delagate BDBtnClickEvent:sender];
    
    if (sender.selected) {
        
    }else{
        
    }
}
//超清
-(void)SHBTNClick:(UIButton*)sender{
    
    sender.selected =!sender.selected;
    [_SHBTN setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_SHBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.delagate SHBTNClickEvent:sender];
    
}









@end
