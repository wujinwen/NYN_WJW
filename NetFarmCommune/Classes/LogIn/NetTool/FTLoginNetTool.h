//
//  FTLoginNetTool.h
//  FarmerTreasure
//
//  Created by 123 on 2017/5/12.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTNetTool.h"

@interface FTLoginNetTool : NSObject
//登录接口
+ (void)LoginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户注册接口
+ (void)RigistWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//注册或忘记密码发送短信接口
+ (void)ObtainCodeWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//忘记密码修改密码接口
+ (void)ForgetPassWordWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//第三方登录接口
+ (void)ThirdPartLoginResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
