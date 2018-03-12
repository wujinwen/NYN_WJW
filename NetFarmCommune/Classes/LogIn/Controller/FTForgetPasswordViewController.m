//
//  FTForgetPasswordViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/5/3.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTForgetPasswordViewController.h"
#import "FTLoginNetTool.h"

#import<CommonCrypto/CommonDigest.h>
@interface FTForgetPasswordViewController ()<UITextFieldDelegate>
{
    NSTimer* time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *registButton;

@property (nonatomic,assign) int codeIndex;

@end

@implementation FTForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.title = @"忘记密码";
    self.registButton.layer.cornerRadius = 5;
    self.registButton.layer.masksToBounds = YES;
    
    [self.registButton setTitle:@"确定" forState:0];
    _passWordTF.returnKeyType = UIReturnKeyDone;
    _passWordTF.delegate=self;
    
}


- (IBAction)getCode:(id)sender {
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

- (IBAction)regist:(id)sender {
    if (![MyControl isPhoneNumber:self.phoneNumTF.text]) {
        [self showTipsView:@"请输入争取的手机号码!"];
        return;
    }
    
    if (!(self.codeTF.text.length > 0)) {
        [self showTipsView:@"请输入验证码!"];
        return;
    }
    
    if (!(self.passWordTF.text.length > 0)) {
        [self showTipsView:@"请输入密码!"];
        return;
    }
    
    [self showLoadingView:@""];
    
    NSDictionary *logInDic = @{@"account":VALID_STRING(self.phoneNumTF.text),@"passwd":[self md5:VALID_STRING(self.passWordTF.text)],@"captcha":self.codeTF.text,@"role":@"2"};
    [FTLoginNetTool ForgetPassWordWithparams:logInDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        [self showTextProgressView:VALID_STRING(success[@"msg"])];
        [self hideLoadingView];
        
        if ([VALID_STRING(success[@"code"]) isEqualToString:@"200"] ) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        NSLog(@"");
    } failure:^(NSError *failure) {
        [self showTextProgressView:@"网络请求失败"];
        [self hideLoadingView];
        
    }];

}

- (void)gogo{
    self.codeIndex--;
    
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
    
    if (self.codeIndex<=0) {
        [self.getCodeButton setEnabled:YES];
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [time invalidate];
    }
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
