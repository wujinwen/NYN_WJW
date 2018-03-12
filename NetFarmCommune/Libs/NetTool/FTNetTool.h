//
//  FTNetTool.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTNetTool : NSObject
//POST请求
+ (void)postNewUrl:(NSString *)urlStr params:(id)params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//Get请求
+ (void)getUrl:(NSString *)urlStr params:(NSDictionary *)params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//大文件上传
+ (void)postImageUrl:(NSString *)urlStr andFile:(NSData *)file params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
