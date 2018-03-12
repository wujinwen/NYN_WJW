//
//  FTRegistViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/5/3.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTRegistViewController.h"
#import "FTUserAgreementViewController.h"
#import "FTLoginNetTool.h"
#import<CommonCrypto/CommonDigest.h>
@interface FTRegistViewController ()
{
    NSTimer* time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *paaWordTF;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *needReadLB;
@property (weak, nonatomic) IBOutlet UIButton *getAuthCodeButton;

@property (nonatomic,assign) int codeIndex;

@end

@implementation FTRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.authCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.paaWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;

    self.getAuthCodeButton.layer.cornerRadius = 5;
    self.registButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer
                                   alloc]initWithTarget:self action:@selector(read)];
    [self.needReadLB addGestureRecognizer:tap];
    self.needReadLB.userInteractionEnabled = YES;
    
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)regist:(id)sender {
    [self didRegist];
}

- (IBAction)getAuthCode:(id)sender {
    
    [self getRegistCode];
}

- (void)gogo{
    self.codeIndex--;
    
    [self.getAuthCodeButton setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
    
    if (self.codeIndex<=0) {
        [self.getAuthCodeButton setEnabled:YES];
        [self.getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [time invalidate];
    }
}

- (void)read{
    FTUserAgreementViewController *vc = [FTUserAgreementViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 获取验证码
- (void)getRegistCode{
    
    [self showLoadingView:@""];
    if ([MyControl isPhoneNumber:self.phoneNumTF.text]) {
        
        
        [FTLoginNetTool ObtainCodeWithparams:@{@"account":self.phoneNumTF.text} isTestLogin:NO progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            [self showTextProgressView:VALID_STRING(success[@"msg"])];
            [self hideLoadingView];
            
            if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                //这里是验证码计时开始
                [self.getAuthCodeButton setEnabled:NO];
                self.codeIndex = 60;
                [self.getAuthCodeButton setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
                
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

#pragma 注册成功
- (void)didRegist{
    if (![MyControl isPhoneNumber:self.phoneNumTF.text]) {
        [self showTipsView:@"请输入正确的手机号码!"];
        return;
    }
    
    if (!(self.authCodeTF.text.length > 0)) {
        [self showTipsView:@"请输入验证码!"];
        return;
    }
    
    if (!(self.paaWordTF.text.length > 0)) {
        [self showTipsView:@"请输入密码!"];
        return;
    }
    
    [self showLoadingView:@""];
    
    NSDictionary *logInDic = @{@"account":VALID_STRING(self.phoneNumTF.text),@"passwd":[self md5:VALID_STRING(self.paaWordTF.text)],@"captcha":VALID_STRING(self.authCodeTF.text),@"role":@"2"};
    [FTLoginNetTool RigistWithparams:logInDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([VALID_STRING(success[@"code"]) isEqualToString:@"200"] ) {
            [self.navigationController popViewControllerAnimated:YES];
        }

        [self showTextProgressView:VALID_STRING(success[@"msg"])];
        [self hideLoadingView];
        
     
        NSLog(@"");
    } failure:^(NSError *failure) {
        [self showTextProgressView:@"网络请求失败"];
        [self hideLoadingView];

    }];
    
}
//md5加密
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
