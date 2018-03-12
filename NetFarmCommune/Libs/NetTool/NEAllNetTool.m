//
//  NEAllNetTool.m
//  NetworkEngineer
//
//  Created by 123 on 2017/5/17.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import "NEAllNetTool.h"

////用户登录接口
//static NSString *loginSubUrl = @"phone!login";
////用户注册接口
//static NSString *registSubUrl = @"register.cs";
////注册或忘记密码发送短信接口
//static NSString *codeTestSubUrl = @"sms.cs";
////修改登录用户信息接口
//static NSString *modifyUserInfoSubUrl = @"update.cs";
////通过原密码修改密码接口
//static NSString *updateUserPassWordSubUrl = @"update/pwd.cs";
////忘记密码修改密码接口
//static NSString *forgetAndUpdateUserPassWordSubUrl = @"update/forget_pwd.cs";
////获取登录用户信息接口
//static NSString *getLoginUserInfoSubUrl = @"info.cs";
////第三方登录接口
//static NSString *thirdPartLogInSubUrl = @"third/login.cs";
////退出登录接口
//static NSString *outLogInSubUrl = @"logout.cs";

@implementation NEAllNetTool

//登录接口
+ (void)LoginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!login"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


//一次性获取考试题目的接口
+ (void)GetAllTestsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getExamList.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//一次性上传考试结果的接口
+ (void)PostTestsToBackparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!uploadExamResult.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


//一次性获取考试题目的接口
+ (void)GetAllTrainparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getTestList.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//一次性上传练习结果的接口
+ (void)PostTrainToBackparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!uploadTestResult.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


//您的累计总分
+ (void)PostTotleScoreparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getMainPageData"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//首页视频
+ (void)PostHomeVediosparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getAllVideoList"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取该用户所有错题类型节点接口
+ (void)GetAllWrongTitlesparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getAllWrongTree"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取该用户某类型节点下所有错题接口
+ (void)GetAllWrongDetailsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getAllWrongFromTree"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//首页名师接口
+ (void)GetMingShiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getVideoListByQuery"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//收藏接口
+ (void)GetCollectionsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getMyFavor"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取历史考试成绩的接口 userID
+ (void)GethistoryKaoshiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getHistoryExamList.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取之前的练习成绩的接口
+ (void)GethistoryLianXiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!getHistoryTestList.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//点赞
+ (void)GetDianZanParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!addFavor"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//取赞
+ (void)GetQuZanParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!deleteFavor"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//上传照片
+ (void)PostPicsParams:(id )params andFile:(NSData *)file isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postImageUrl:[BaseUrl stringByAppendingString:@"phone!picUpload"] andFile:file params:params isTestLogin:NO progress:^(NSProgress *progress) {

    } success:^(id response) {
        success(response);

    } failure:^(NSError *error) {
        failure(error);

    }];
}






//版本更新接口
+ (void)TestUpDateParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[BaseUrl stringByAppendingString:@"phone!appUpdate.action"] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
@end
