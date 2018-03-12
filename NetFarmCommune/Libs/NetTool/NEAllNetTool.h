//
//  NEAllNetTool.h
//  NetworkEngineer
//
//  Created by 123 on 2017/5/17.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTNetTool.h"
#import <AFNetworking/AFNetworking.h>

@interface NEAllNetTool : NSObject
//登录接口
+ (void)LoginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//一次性获取考试题目的接口
+ (void)GetAllTestsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//一次性上传考试结果的接口
+ (void)PostTestsToBackparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//一次性获取考试题目的接口
+ (void)GetAllTrainparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//一次性上传练习结果的接口
+ (void)PostTrainToBackparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//您的累计总分
+ (void)PostTotleScoreparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//首页视频
+ (void)PostHomeVediosparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//获取该用户所有错题类型节点接口
+ (void)GetAllWrongTitlesparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//获取该用户某类型节点下所有错题接口
+ (void)GetAllWrongDetailsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//首页名师接口
+ (void)GetMingShiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//获取之前的练习成绩的接口
+ (void)GethistoryLianXiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//获取历史考试成绩的接口
+ (void)GethistoryKaoshiparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//收藏接口
+ (void)GetCollectionsparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//点赞
+ (void)GetDianZanParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//取赞
+ (void)GetQuZanParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//上传照片
+ (void)PostPicsParams:(id )params andFile:(NSData *)file isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//版本更新接口
+ (void)TestUpDateParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;






@end
