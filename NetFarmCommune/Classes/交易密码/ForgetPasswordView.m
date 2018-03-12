//
//  ForgetPasswordView.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/12.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ForgetPasswordView.h"
#import <Masonry/Masonry.h>

@interface ForgetPasswordView()<UITextFieldDelegate>


@end

@implementation ForgetPasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
    
}

-(void)initiaInterface{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREENWIDTH-40, 200)];
    view.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2-40);
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];

    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, SCREENWIDTH-40, 40)];
    label.text=@"找回密码手机验证";
    label.textAlignment=NSTextAlignmentCenter;
    
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:15];
    [view addSubview:label];
    
   [view addSubview:self.phonetextField];
    [view addSubview:self.yantextField];
    [view addSubview:self.yanzhengBtn];
    [view addSubview:self.tijiaoBtn];
    
    [self.phonetextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(8);
        make.centerX.equalTo(self);
        make.width.mas_offset(JZWITH(160));
        make.height.mas_offset(30);
    }];
    self.phonetextField.layer.cornerRadius =10;
    self.phonetextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.phonetextField.layer.borderWidth =1;
    
    [self.yantextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phonetextField.mas_bottom).offset(8);
          make.centerX.equalTo(self);
        make.width.mas_offset(JZWITH(160));
        make.height.mas_offset(30);
    }];
    
    self.yantextField.layer.cornerRadius =10;
    self.yantextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.yantextField.layer.borderWidth =1;
    
    
    
    [self.yanzhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(8);
        make.left.equalTo(_phonetextField.mas_right).offset(8);
        make.width.mas_offset(70);
        make.height.mas_offset(30);
        
    }];
    
    self.yanzhengBtn.layer.cornerRadius =10;
    self.yanzhengBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.yanzhengBtn.layer.borderWidth =1;
    
    [self.tijiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.centerX.equalTo(self);
        make.width.mas_offset(100);
        make.height.mas_offset(40);
        
    }];
    
    self.tijiaoBtn.layer.cornerRadius =10;
    self.tijiaoBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.tijiaoBtn.layer.borderWidth =1;
    
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"login_icon_delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(30);
        make.top.mas_offset(10);
        make.height.mas_offset(30);
    }];
    
    
}

//验证码按钮
-(void)yanzhengBtnClick:(UIButton*)sender{
    [self.delegate GetyanzhengmaClick:self.phonetextField.text];
    
    
    
}
//提交
-(void)tijiaoBtnClick:(UIButton*)sender{
    [self.delegate GetphoneNumber:_phonetextField.text yanzhengmaStr:_yantextField.text];
    
    
}
//删除按钮
-(void)deleteBtnClick:(UIButton*)sender{
    [self.delegate deletButton:sender];
    
    
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}


-(UITextField *)yantextField{
    if (!_yantextField) {
        _yantextField = [[UITextField alloc]init];
        _yantextField.placeholder = @"输入验证码";
         _yantextField.delegate=self;
         _yantextField.returnKeyType = UIReturnKeyDone;
    }
    return _yantextField;
    
}
-(UITextField *)phonetextField{
    if (!_phonetextField) {
        _phonetextField = [[UITextField alloc]init];
       _phonetextField.placeholder = @"输入手机号";
        _phonetextField.delegate=self;
        
        _phonetextField.returnKeyType = UIReturnKeyDone;
    }
    return _phonetextField;
    
    
}

-(UIButton *)yanzhengBtn{
    if (!_yanzhengBtn) {
        _yanzhengBtn =[[UIButton alloc]init];
        [_yanzhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_yanzhengBtn addTarget:self action:@selector(yanzhengBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_yanzhengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _yanzhengBtn.titleLabel.font=[UIFont systemFontOfSize:13 ];
        
        
    }
    return _yanzhengBtn;
    
}

-(UIButton *)tijiaoBtn{
    if (!_tijiaoBtn) {
        _tijiaoBtn =[[UIButton alloc]init];
        [_tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_tijiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _tijiaoBtn.titleLabel.font=[UIFont systemFontOfSize:14 ];
        [_tijiaoBtn addTarget:self action:@selector(tijiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _tijiaoBtn;
    
}
@end
