//
//  DealPasswordSetView.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/12.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "DealPasswordSetView.h"
#import <Masonry/Masonry.h>

@interface DealPasswordSetView()<UITextFieldDelegate>

@property(nonatomic,strong)NSString * dataString;


@property(nonatomic,assign)int isBool;








@end

@implementation DealPasswordSetView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initiaInterface];
        
        
    }
    return self;
    
}

-(void)initiaInterface{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREENWIDTH-40, 180)];
    view.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2-40);
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];
    
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text =@"请输入交易密码";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor blackColor];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self);
        make.top.mas_offset(8);
        make.width.mas_offset(SCREENWIDTH-40);
        make.height.mas_offset(40);
    }];
    _titleLabel  =titleLabel;
    
    

    int W = 20;//框的宽度,自己看着定
    for (int i = 0; i < 6; i ++ ) {
        //宽高和y都不管了,只计算
        UITextField * textField = [[UITextField alloc]init];
        [view addSubview:textField];
        textField.layer.borderColor= [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth= 1.0f;
        textField.returnKeyType = UIReturnKeyDone;
        CGFloat FieldW = JZWITH(60)+SCREENWIDTH/2+(i-5)*W*2;
        CGRect FieldFrame = CGRectMake(FieldW, JZWITH(55), 2*W, 50);
        textField.frame =FieldFrame;
        textField.delegate=self;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.keyboardType= UIKeyboardTypeNumberPad;
         textField.tag = 100+i;
        textField.secureTextEntry =YES;
         [textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField = textField;
        
        
    }
    
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureButton addTarget:self action:@selector(sureButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.layer.cornerRadius =10;
    sureButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-8);
        make.width.mas_offset(80);
         make.height.mas_offset(30);
        make.centerX.equalTo(self);

    }];
    
    sureButton.layer.cornerRadius=5;
    sureButton.layer.borderColor=[UIColor blackColor].CGColor;
    sureButton.clipsToBounds = YES;
    sureButton.layer.borderWidth = 1;
    
    
    
    
 
    UIButton*forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
     forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(SCREENWIDTH/2);
        make.bottom.equalTo(sureButton.mas_top).offset(-9);
        make.height.mas_offset(30);
        
        
        
    }];
    
    _forgetBtn = forgetBtn;
    
    
    
    UIButton * amendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [amendBtn setTitle:@"修改交易密码" forState:UIControlStateNormal];
    [amendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    amendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [amendBtn addTarget:self action:@selector(amendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
     [view addSubview:amendBtn];
    [amendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(SCREENWIDTH/2);
        make.bottom.equalTo(sureButton.mas_top).offset(-9);
        make.height.mas_offset(30);
    }];
    _amendBtn = amendBtn;
    
    
    
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

//修改交易密码
-(void)amendBtnClick:(UIButton*)sender{

    [self.delegate amendBtnClick:sender];
    
    
}

//忘记密码
-(void)forgetBtnClick:(UIButton*)sender{
    [self.delegate setGetPassword:sender];
    
    
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}
//确定按钮
-(void)sureButtonclick:(UIButton*)sender{
    _dataString = @"";
    //把6个textfield内容拼接起来
    for (int i = 0; i < 6; i++) {
        _dataString = [_dataString stringByAppendingString:[(UITextField *)[self viewWithTag:100+i] text]];
    }
    
    [self.delegate SetTextFieldString:_dataString];
    
    [_textField resignFirstResponder];
    
}
-(void)setTitleNameStr:(UILabel *)nameLabel isBool:(int)isBool{
    if (isBool == 0) {
        _amendBtn.hidden=YES;
        _forgetBtn.hidden=YES;
    }else{
        _amendBtn.hidden=NO;
        _forgetBtn.hidden=NO;
    }
    
    
    
}
- (void)clear {
    //清空
    _dataString = @"";
    
    for (int i = 0; i < 6; i++) {
        [(UITextField *)[self viewWithTag:100+i] setText:@""];
    }
    [(UITextField *)[self viewWithTag:100] becomeFirstResponder];
}
- (void)textFieldEditChanged:(UITextField *)textField

{
    UIView *nextView = [self viewWithTag:textField.tag + 1];
    [nextView becomeFirstResponder];
//    _dataString=textField.text;


}

-(void)deleteBtnClick:(UIButton*)sender{
    [self.delegate deleteBtnClick:sender];
    
}

@end
