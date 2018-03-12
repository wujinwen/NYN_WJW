//
//  NYNBangDingShouJiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNBangDingShouJiViewController.h"
#import "FTNetTool.h"
#import "FTLoginNetTool.h"

@interface NYNBangDingShouJiViewController ()
{
    NSTimer* time;
}
@property (nonatomic,strong) UIButton *getCodeButton;
@property (nonatomic,strong) UITextField *phoneNumTF;
@property (nonatomic,assign) int codeIndex;
@property (nonatomic,strong) UITextField *codeTF;
@end

@implementation NYNBangDingShouJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"绑定手机";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *shouJiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(38), JZHEIGHT(62), JZWITH(13), JZHEIGHT(21))];
    
    shouJiImageView.image = Imaged(@"login_icon_number");
    [self.view addSubview:shouJiImageView];
    
    UITextField *shoujiTF = [[UITextField alloc]initWithFrame:CGRectMake(shouJiImageView.right + JZWITH(22), shouJiImageView.top, JZWITH(183), shouJiImageView.height)];
    shoujiTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    shoujiTF.placeholder = @"请输入手机号";
    [self.view addSubview:shoujiTF];
    self.phoneNumTF = shoujiTF;
    
    UIButton *codeButton = [[UIButton alloc]initWithFrame:CGRectMake(shoujiTF.right + JZWITH(22), JZHEIGHT(62), JZWITH(61), JZHEIGHT(21))];
    [codeButton setTitle:@"获取验证码" forState:0];
    [codeButton setTitleColor:[UIColor whiteColor] forState:0];
    codeButton.layer.cornerRadius = 5;
    codeButton.layer.masksToBounds = YES;
    codeButton.backgroundColor = Color90b659;
    codeButton.titleLabel.font = JZFont(10);
    [self.view addSubview:codeButton];
    [codeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    self.getCodeButton = codeButton;
    
    UIView *lineOneView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(37), shouJiImageView.bottom + JZHEIGHT(5), JZWITH(301), .5)];
    lineOneView.backgroundColor = Colore3e3e3;
    [self.view addSubview:lineOneView];
    
    UIImageView *codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(38), lineOneView.bottom + JZHEIGHT(35) - JZWITH(7), JZWITH(15), JZHEIGHT(23))];
    codeImageView.image = Imaged(@"login_icon_vc");
    [self.view addSubview:codeImageView];
    
    UITextField *codeTF = [[UITextField alloc]initWithFrame:CGRectMake(codeImageView.right + JZWITH(21), codeImageView.top + JZHEIGHT(4), JZWITH(265), codeImageView.height-JZHEIGHT(4)) ];
    codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeTF.placeholder = @"请输入验证码";
    [self.view addSubview:codeTF];
    self.codeTF= codeTF;
    
    UIView *lineTwoView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(37), codeImageView.bottom + JZHEIGHT(5), JZWITH(301), .5)];
    lineTwoView.backgroundColor = Colore3e3e3;
    [self.view addSubview:lineTwoView];
    
    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(37), lineTwoView.bottom + JZHEIGHT(15), JZWITH(305), JZHEIGHT(60))];
    shuoMingLabel.text = @"收到验证码后，请在15分钟内在下方输入您收到的验证码， 如果未收到消息，请重新点击获取验证码";
    shuoMingLabel.font = JZFont(12);
    shuoMingLabel.textColor = Color888888;
    shuoMingLabel.numberOfLines = 0;
    [self.view addSubview:shuoMingLabel];
    
    UIButton *xiuGaiButton = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(37), shuoMingLabel.bottom + JZHEIGHT(30), JZWITH(301), JZHEIGHT(41))];
    xiuGaiButton.layer.cornerRadius = 5;
    xiuGaiButton.layer.masksToBounds = YES;
    [xiuGaiButton setTitle:@"确认绑定" forState:0];
    [xiuGaiButton setTitleColor:[UIColor whiteColor] forState:0];
    xiuGaiButton.backgroundColor = Color90b659;
    [self.view addSubview:xiuGaiButton];
    xiuGaiButton.titleLabel.font = JZFont(15);
    [xiuGaiButton addTarget:self action:@selector(xiugai) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)xiugai{
    JZLog(@"确认绑定");
    
//    if (![self isMobileNumber:self.phoneNumTF.text]) {
//        [self showTextProgressView:@"请输入正确的手机号码"];
//        [self hideLoadingView];
//        return;
//    }
//
    
    if (self.codeTF.text.length < 1) {
        [self showTextProgressView:@"请输入验证码"];
        [self hideLoadingView];
        return;
    }
    
    
    NSDictionary *dic = @{@"phone":self.phoneNumTF.text,@"captcha":self.codeTF.text};
    [self showLoadingView:@""];
    [NYNNetTool BindPhoneWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self showTextProgressView:@"修改成功"];
            NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
            [userDic setObject:self.phoneNumTF.text forKey:@"phone"];
            [ss setObject:userDic forKey:@"user"];
            JZSaveMyDefault(SET_USER, ss);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
    }];
}

- (void)getCode{
    [self showLoadingView:@""];
    
    
    if ([MyControl isPhoneNumber:self.phoneNumTF.text]) {
        [FTLoginNetTool ObtainCodeWithparams:@{@"account":self.phoneNumTF.text} isTestLogin:NO progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            [self showTextProgressView:VALID_STRING(success[@"msg"])];
            [self hideLoadingView];
            
            if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                //这里是验证码计时开始
                [self.getCodeButton setEnabled:NO];
                self.codeIndex = 60;
                [self.getCodeButton setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
                
                time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gogo) userInfo:nil repeats:YES];
            }else{
                
            }
        } failure:^(NSError *failure) {
            [self showTextProgressView:@"网络请求失败!"];
            [self hideLoadingView];
        }];
    }else{
        [self showTextProgressView:@"请输入正确的手机号码!"];
        [self hideLoadingView];
    }
}


- (void)gogo{
    self.codeIndex--;
    
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
    
    if (self.codeIndex<=0) {
        [self.getCodeButton setEnabled:YES];
        [self.getCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [time invalidate];
    }
}

@end
