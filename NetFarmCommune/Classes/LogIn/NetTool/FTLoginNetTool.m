//
//  FTLoginNetTool.m
//  FarmerTreasure
//
//  Created by 123 on 2017/5/12.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTLoginNetTool.h"


//修改后的接口
///sso/user/sms
///sso/user/login
///sso/user/register
///sso/user/update
///sso/user/update/pwd
///sso/user/update/forget_pwd
///sso/user/info
///sso/user/logout
///sso/user/third/login
///sso/user/qrcode/login
///sso/user/qrcode/login_info
///sso/user/qrcode/qr

//用户登录接口
//static NSString *loginSubUrl = @"sso/user/login";
static NSString *loginSubUrl = @"login2/user/login";
//用户注册接口
static NSString *registSubUrl = @"login2/user/register";
//注册或忘记密码发送短信接口
static NSString *codeTestSubUrl = @"login2/user/sms";
//修改登录用户信息接口
static NSString *modifyUserInfoSubUrl = @"login2/user/update";
//通过原密码修改密码接口
static NSString *updateUserPassWordSubUrl = @"login2/user/update/pwd";
//忘记密码修改密码接口
static NSString *forgetAndUpdateUserPassWordSubUrl = @"login2/user/update/forget_pwd";
//获取登录用户信息接口
//static NSString *getLoginUserInfoSubUrl = @"sso/user/info";
static NSString *getLoginUserInfoSubUrl = @"login2/user/info";
//第三方登录接口
//static NSString *thirdPartLogInSubUrl = @"sso/user/third/login";
static NSString *thirdPartLogInSubUrl = @"login2/user/third/login";
//退出登录接口
static NSString *outLogInSubUrl = @"login2/user/logout";

@implementation FTLoginNetTool


//登录接口
+ (void)LoginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:loginSubUrl params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//用户注册接口
+ (void)RigistWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:registSubUrl params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//注册或忘记密码发送短信接口
+ (void)ObtainCodeWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    [FTNetTool postNewUrl:codeTestSubUrl params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//忘记密码修改密码接口
+ (void)ForgetPassWordWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:forgetAndUpdateUserPassWordSubUrl params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//第三方登录接口
+ (void)ThirdPartLoginResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:thirdPartLogInSubUrl params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
@end
