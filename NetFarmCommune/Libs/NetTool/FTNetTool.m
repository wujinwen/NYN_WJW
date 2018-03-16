//
//  FTNetTool.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTNetTool.h"
#import <AFNetworking/AFNetworking.h>
#import "UserInfoModel.h"
#import "FTMD5Tool.h"

@implementation FTNetTool
//POST请求
+ (void)postNewUrl:(NSString *)urlStr params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20;
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,urlStr];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    //timestamp获取毫秒时间戳
    NSString *second = [MyControl getNowTimeTimestampMillisecond];
    //deviceId
    NSString *uuid = JZFetchMyDefault(@"uuid");
    
    [dic setObject:second forKey:@"timestamp"];
    [dic setObject:uuid forKey:@"deviceId"];

    UserInfoModel *userModel = userInfoModel;
    if (userModel.token.length > 0) {
        [dic setObject:userModel.token forKey:@"token"];
    }
    
    NSArray *keys = [dic allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
//    NSMutableDictionary *misDic = [NSMutableDictionary dictionary];;
//    for (NSString *str in sortedArray) {
//        [misDic setObject:[dic valueForKey:str] forKey:str];
//    }
    
    NSString *sttt = @"";

    for (int i = 0; i < sortedArray.count; i++) {
        NSString *k = sortedArray[i];
        NSString *v = [dic valueForKey:sortedArray[i]];
        if (i == 0) {
            sttt = [sttt stringByAppendingString:[NSString stringWithFormat:@"%@=%@",k,v]];
        }else{
            sttt = [sttt stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",k,v]];
        }
    }
    
//    NSString *jsonStr = [MyControl dictionaryToJson:misDic];
    
    NSString *sign = [FTMD5Tool MD5ForLower32Bate:sttt];
    
    NSData *data = [sign dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    
    NSString *signStr = base64;
    
    [dic setObject:signStr forKey:@"sign"];
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            //json解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([[NSString stringWithFormat:@"%@",resultDic[@"code"]] isEqualToString:@"200"]) {
                JZLog(@"201获取数据成功");
            }else{
                JZLog(@"-----%@",dic);
                JZLog(@"-----%@",url);
                JZLog(@"获取数据失败");
            }
            success(resultDic);
            //JZLog(@"-----%@",resultDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getUrl:(NSString *)urlStr params:(NSDictionary *)params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20;
    NSString *url = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"%@",urlStr]];
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            //json解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(resultDic);
            if ([[NSString stringWithFormat:@"%@",resultDic[@"data"]] isEqualToString:@"success"]) {
                JZLog(@"201获取数据成功");
            }else{
                JZLog(@"获取数据失败");
            }
            JZLog(@"%@",resultDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


//大文件上传
+ (void)postImageUrl:(NSString *)urlStr andFile:(NSData *)file params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //    NSString *url = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"/%@",urlStr]];
    //  NSString *url = @"http://192.168.0.102:8080/farm-service-user/login";
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,urlStr];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    //timestamp获取毫秒时间戳
    NSString *second = [MyControl getNowTimeTimestampMillisecond];
    //deviceId
    NSString *uuid = JZFetchMyDefault(@"uuid");
    
    [dic setObject:second forKey:@"timestamp"];
    [dic setObject:uuid forKey:@"deviceId"];
    
    UserInfoModel *userModel = userInfoModel;
    if (userModel.token.length > 0) {
        [dic setObject:userModel.token forKey:@"token"];
    }
    
    NSArray *keys = [dic allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    //    NSMutableDictionary *misDic = [NSMutableDictionary dictionary];;
    //    for (NSString *str in sortedArray) {
    //        [misDic setObject:[dic valueForKey:str] forKey:str];
    //    }
    
    NSString *sttt = @"";
    
    for (int i = 0; i < sortedArray.count; i++) {
        NSString *k = sortedArray[i];
        NSString *v = [dic valueForKey:sortedArray[i]];
        if (i == 0) {
            sttt = [sttt stringByAppendingString:[NSString stringWithFormat:@"%@=%@",k,v]];
        }else{
            sttt = [sttt stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",k,v]];
        }
    }
    
    
    //    NSString *jsonStr = [MyControl dictionaryToJson:misDic];
    
    NSString *sign = [FTMD5Tool MD5ForLower32Bate:sttt];
    
    NSData *data = [sign dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    
    NSString *signStr = base64;
    
    [dic setObject:signStr forKey:@"sign"];

    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //            //image的分类方法
        UIImage* resizedImage = [UIImage imageWithData:file];
        NSData*  imgData = UIImageJPEGRepresentation(resizedImage, .5);
        //            //拼接data
        [formData appendPartWithFileData:imgData name:@"upload" fileName:@"avatar.png" mimeType:@"image/jpeg"];
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            //json解析
//            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *resultDic = responseObject;
            if ([[NSString stringWithFormat:@"%@",resultDic[@"ret"]] isEqualToString:@"1"]) {
                JZLog(@"获取数据成功");
            }else{
                JZLog(@"获取数据失败");
            }
            
            NSLog(@"%@",resultDic[@"msg"]);
            
            success(resultDic);
            JZLog(@"%@",resultDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


//+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress *)progress
//{
//    //1.创建管理者对象
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSUInteger i = 0 ;
//        /出于性能考虑,将上传图片进行压缩/
//        for (UIImage  image in imageArray) {
//            //image的分类方法
//            UIImage   resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
//            NSData  imgData = UIImageJPEGRepresentation(resizedImage, .5);
////            //拼接data
//            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
//            i++;
//        }
//    } progress:^(NSProgress  _Nonnull uploadProgress) {
//        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask  _Nonnull task, NSDictionary   _Nullable responseObject) {
//        successBlock(responseObject);
//    } failure:^(NSURLSessionDataTask  _Nullable task, NSError * _Nonnull error) {
//        failureBlock(error);
//    }];
//}
//转码方法

-(NSString *)URLDecodedString:(NSString *)str
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = str;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

-(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"";
    
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            value = [self stringWithDict:value];
            
        }
        
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@","];
            
        }
        
        str = [str stringByAppendingFormat:@"%@:%@",categoryId,value];
        
    }
    NSLog(@"str:%@",str);
    return str;
}
@end
