//
//  UserInfoModel.m
//  WebFarmProgram
//
//  Created by 123 on 17/3/23.
//  Copyright © 2017年 贾云博. All rights reserved.
//

#import "UserInfoModel.h"

static UserInfoModel *userInfo;

@implementation UserInfoModel

+ (UserInfoModel *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[self alloc] init];
    });
    
//    NSDictionary *ss = [NSDictionary dictionaryWithDictionary:JZUSERINFO[@"user"]];
    if ([JZUSERINFO isKindOfClass:[NSDictionary class]]) {
        userInfo.account = VALID_STRING(JZUSERINFO[@"user"][@"account"]);
        userInfo.attr = VALID_STRING(JZUSERINFO[@"user"][@"attr"]);
        userInfo.authStatus = VALID_STRING(JZUSERINFO[@"user"][@"authStatus"]);
        userInfo.avatar = VALID_STRING(JZUSERINFO[@"user"][@"avatar"]);
        userInfo.balance = VALID_STRING(JZUSERINFO[@"user"][@"balance"]);
        userInfo.clientId = VALID_STRING(JZUSERINFO[@"user"][@"clientId"]);
        userInfo.createTime = VALID_STRING(JZUSERINFO[@"user"][@"createTime"]);
        userInfo.ID = VALID_STRING(JZUSERINFO[@"user"][@"id"]);
        userInfo.lastLoginTime = VALID_STRING(JZUSERINFO[@"user"][@"lastLoginTime"]);
        userInfo.loginNum = VALID_STRING(JZUSERINFO[@"user"][@"loginNum"]);
        userInfo.modifyTime = VALID_STRING(JZUSERINFO[@"user"][@"modifyTime"]);
        userInfo.name = VALID_STRING(JZUSERINFO[@"user"][@"name"]);
        userInfo.openId = VALID_STRING(JZUSERINFO[@"user"][@"openId"]);
        userInfo.passwd = VALID_STRING(JZUSERINFO[@"user"][@"passwd"]);
        userInfo.paypwd = VALID_STRING(JZUSERINFO[@"user"][@"paypwd"]);
        userInfo.phone = VALID_STRING(JZUSERINFO[@"user"][@"phone"]);
        userInfo.points = VALID_STRING(JZUSERINFO[@"user"][@"points"]);
        userInfo.qqOpenId = VALID_STRING(JZUSERINFO[@"user"][@"qqOpenId"]);
        userInfo.remark = VALID_STRING(JZUSERINFO[@"user"][@"remark"]);
        userInfo.role = VALID_STRING(JZUSERINFO[@"user"][@"role"]);
        userInfo.sex = VALID_STRING(JZUSERINFO[@"user"][@"sex"]);
        userInfo.signature = VALID_STRING(JZUSERINFO[@"user"][@"signature"]);
        userInfo.state = VALID_STRING(JZUSERINFO[@"user"][@"state"]);
        userInfo.userExtends = VALID_STRING(JZUSERINFO[@"user"][@"userExtends"]);
        userInfo.wbOpenId = VALID_STRING(JZUSERINFO[@"user"][@"wbOpenId"]);
        userInfo.wxOpenId = VALID_STRING(JZUSERINFO[@"user"][@"wxOpenId"]);
        userInfo.birthday = VALID_STRING(JZUSERINFO[@"user"][@"birthday"]);
        userInfo.city = VALID_STRING(JZUSERINFO[@"user"][@"city"]);

        
        userInfo.token = VALID_STRING(JZUSERINFO[@"token"]);
        
         userInfo.latitude = VALID_STRING(JZUSERINFO[@"latitude"]);
        userInfo.location = VALID_DIC(JZUSERINFO[@"user"][@"location"]);
        
        userInfo.isLogin = YES;
    }else{
        userInfo.isLogin = NO;
    }
    
    return userInfo;
}

- (void)configUserInfo{
//    if ([JZUSERINFO isKindOfClass:[NSDictionary class]]) {
//        userInfo.name = VALID_STRING(JZUSERINFO[@"name"]);
//        userInfo.passWord = VALID_STRING(JZUSERINFO[@"passWord"]);
//        userInfo.isLogin = YES;
//    }else{
//        userInfo.isLogin = NO;
//    }
}
@end
