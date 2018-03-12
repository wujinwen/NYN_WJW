//
//  FTLoginViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/5/3.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTLoginViewController.h"
#import "FTRegistViewController.h"
#import "FTForgetPasswordViewController.h"
#import "FTLoginNetTool.h"
#import <UMSocialCore/UMSocialCore.h>
#import<CommonCrypto/CommonDigest.h>
#import "RCDLive.h"
#import "RCDLiveGiftMessage.h"
#import "NYNMessageContent.h"

@interface FTLoginViewController ()<UITextFieldDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (weak, nonatomic) IBOutlet UIButton *weChatLogButton;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboLogin;

@property (nonatomic,copy) NSString *useriCon;
@property (nonatomic,copy) NSString *userName;

@property (nonatomic, strong) CLLocationManager *locationManager;//定位服务
@end

@implementation FTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTF.returnKeyType = UIReturnKeyDone;
    self.phoneNumTF.delegate=self;
    
    self.passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTF.returnKeyType = UIReturnKeyDone;
      self.passWordTF.delegate=self;
    self.logInButton.layer.cornerRadius = 5;
    self.title = @"登录";
    self.passWordTF.secureTextEntry = YES;
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(20), JZHEIGHT(20))];
//    backButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *bt = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = bt;
}



//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}
#pragma 定位
- (void)starLocation{
    //这里给一个默认定位的位置
    
    //    NSDictionary *locationDic = [NSDictionary dictionaryWithDictionary:JZFetchMyDefault(@"location")];
    //
    //    if (locationDic.allKeys.count < 1) {
    //        NSDictionary *userLocation = @{@"lat":@"100.31",@"lon":@"30.01",@"province":@"四川省",@"city":@"成都市"};
    //        JZSaveMyDefault(@"location", userLocation);
    //    }
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
}

- (IBAction)logIn:(id)sender {
//    NSString *uuid = JZFetchMyDefault(@"uuid");
    
    if (![MyControl isPhoneNumber:self.phoneNumTF.text]) {
        [self showTipsView:@"请输入正确的手机号码!"];
        return;
    }
    
    if (!(self.passWordTF.text.length > 0)) {
        [self showTipsView:@"请输入密码!"];
        return;
    }
    
    [self showLoadingView:@""];
    
    
    NSDictionary *logInDic = @{@"account":self.phoneNumTF.text,@"passwd":[self md5:VALID_STRING(self.passWordTF.text)],@"role":@"2"};
    
    [FTLoginNetTool LoginWithparams:logInDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        [self showTextProgressView:VALID_STRING(success[@"msg"])];
        [self hideLoadingView];
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] ) {
            
            NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionaryWithDictionary:success[@"data"]];
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:userInfoDic[@"user"]];
            //重新生成user数据
            NSMutableDictionary *userSaveDic = [[NSMutableDictionary alloc]init];
            
            for (NSString* str in userDic.allKeys) {
                if (![[userDic valueForKey:str] isKindOfClass:[NSNull class]]) {
                    [userSaveDic setValue:[NSString stringWithFormat:@"%@",[userDic valueForKey:str]] forKey:str];
                }else{
                    NSLog(@"");
                }
            }
            [userInfoDic setValue:userSaveDic forKey:@"user"];
            
            JZSaveMyDefault(SET_USER, userInfoDic);
            
            POST_NTF(@"login", nil);
             [self rongyunLinet];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }else{
            NSLog(@"");

        }
        
    } failure:^(NSError *failure) {
        [self showTextProgressView:@"网络请求失败"];
        [self hideLoadingView];
    }];
    
}



- (IBAction)forgetPassword:(id)sender {
    FTForgetPasswordViewController *vc = [FTForgetPasswordViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)regist:(id)sender {
    FTRegistViewController *vc = [FTRegistViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)wechatLogin:(id)sender {
    [self showLoadingView:@""];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.gender);
//            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            [self showLoadingView:@""];
            
//            NSLog(@"uid=%@",user.uid);
//            NSLog(@"%@",user.credential);
//            NSLog(@"token=%@",user.credential.token);
//            NSLog(@"nickname=%@",user.nickname);
//            
//            NSDictionary *userDic = @{@"userName":VALID_STRING(user.nickname),@"userIcon":VALID_STRING(user.icon),@"userGender":VALID_STRING(user.gender == SSDKGenderMale ? @"0":@"1"),@"uid":VALID_STRING(user.uid),@"type":@"2"};
//            NSDictionary *userDic = @{};
            NSDictionary *userDic = @{@"name":VALID_STRING(resp.name),
                                      @"avatar":VALID_STRING(resp.iconurl),
                                      @"sex":VALID_STRING([resp.unionGender isEqualToString:@"男"] ? @"1":@"2"),
                                      @"openId":VALID_STRING(resp.openid),
                                      @"type":@"2"};
            
            [self thirdPartLogin:userDic];
        }
    }];
    [self hideLoadingView];


}

- (IBAction)qqLogin:(id)sender {
    [self showLoadingView:@""];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"QQ uid: %@", resp.uid);
//            NSLog(@"QQ openid: %@", resp.openid);
//            NSLog(@"QQ accessToken: %@", resp.accessToken);
//            NSLog(@"QQ expiration: %@", resp.expiration);
//
//            // 用户信息
//            NSLog(@"QQ name: %@", resp.name);
//            NSLog(@"QQ iconurl: %@", resp.iconurl);
//            NSLog(@"QQ gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            [self showLoadingView:@""];
            
//            NSLog(@"uid=%@",user.uid);
//            NSLog(@"%@",user.credential);
//            NSLog(@"token=%@",user.credential.token);
//            NSLog(@"nickname=%@",user.nickname);
            NSDictionary *userDic = @{@"name":VALID_STRING(resp.name),
                                      @"avatar":VALID_STRING(resp.iconurl),
                                      @"sex":VALID_STRING([resp.unionGender isEqualToString:@"男"] ? @"1":@"2"),
                                      @"openId":VALID_STRING(resp.openid),
                                      @"type":@"1"};
//            NSDictionary *userDic = @{};
            [self thirdPartLogin:userDic];
        }
    }];
    [self hideLoadingView];
}

- (IBAction)weiBoLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"Sina uid: %@", resp.uid);
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.gender);
//            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            
            [self showLoadingView:@""];
            
//            NSLog(@"uid=%@",user.uid);
//            NSLog(@"%@",user.credential);
//            NSLog(@"token=%@",user.credential.token);
//            NSLog(@"nickname=%@",user.nickname);
//            NSDictionary *userDic = @{@"userName":VALID_STRING(resp.nickname),
//                                      @"userIcon":VALID_STRING(user.icon),
//                                      @"userGender":VALID_STRING(user.gender == SSDKGenderMale ? @"0":@"1"),
//                                      @"uid":VALID_STRING(user.uid),@"type":@"1"};
            NSDictionary *userDic = @{@"name":VALID_STRING(resp.name),
                                      @"avatar":VALID_STRING(resp.iconurl),
                                      @"sex":VALID_STRING([resp.unionGender isEqualToString:@"男"] ? @"1":@"2"),
                                      @"openId":VALID_STRING(resp.openid),
                                      @"type":@"3"};
            [self thirdPartLogin:userDic];
        }
        
    }];
    [self hideLoadingView];

  }


- (void)backTo{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)thirdPartLogin:(NSDictionary *)dic{
    
    self.useriCon = VALID_STRING(dic[@"userIcon"]);
    self.userName = VALID_STRING(dic[@"userName"]);
    [FTLoginNetTool ThirdPartLoginResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {

            
            NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionaryWithDictionary:success[@"data"]];
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:userInfoDic[@"user"]];
            //重新生成user数据
            NSMutableDictionary *userSaveDic = [[NSMutableDictionary alloc]init];
            
            for (NSString* str in userDic.allKeys) {
                if (![[userDic valueForKey:str] isKindOfClass:[NSNull class]]) {
                    [userSaveDic setValue:[NSString stringWithFormat:@"%@",[userDic valueForKey:str]] forKey:str];
                }else{
                    NSLog(@"");
                }
            }
            [userInfoDic setValue:userSaveDic forKey:@"user"];
            
            JZSaveMyDefault(SET_USER, userInfoDic);
            
            POST_NTF(@"login", nil);
            [self rongyunLinet];
            
            
            [self hideLoadingView];

            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
            
            

            
        }else{
            [self showTipsView:VALID_STRING(success[@"errMsg"])];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
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


-(void)rongyunLinet{
    
    //链接融云服务器,程序进来就链接
    [[RCIMClient sharedRCIMClient] connectWithToken:JZFetchMyDefault(SET_USER)[@"rongToken"]success:^(NSString *loginUserId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCUserInfo *user = [[RCUserInfo alloc]init];
            user.userId = JZFetchMyDefault(SET_USER)[@"id"];
            user.portraitUri = @"";//头像
            user.name = JZFetchMyDefault(SET_USER)[@"name"];
            [RCIMClient sharedRCIMClient].currentUserInfo = user;
            NSLog(@"连接成功");
            
            
        });
    } error:^(RCConnectErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } tokenIncorrect:^{
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
}
//#pragma 三方登录最后的处理
//- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
//        
//        UMSocialUserInfoResponse *resp = result;
//        
//        // 第三方登录数据(为空表示平台未提供)
//        // 授权数据
//        NSLog(@" uid: %@", resp.uid);
//        NSLog(@" openid: %@", resp.openid);
//        NSLog(@" accessToken: %@", resp.accessToken);
//        NSLog(@" refreshToken: %@", resp.refreshToken);
//        NSLog(@" expiration: %@", resp.expiration);
//        
//        // 用户数据
//        NSLog(@" name: %@", resp.name);
//        NSLog(@" iconurl: %@", resp.iconurl);
//        NSLog(@" gender: %@", resp.gender);
//        
//        // 第三方平台SDK原始数据
//        NSLog(@" originalResponse: %@", resp.originalResponse);
//    }];
//}
@end
