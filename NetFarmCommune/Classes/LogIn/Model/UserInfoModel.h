//
//  UserInfoModel.h
//  WebFarmProgram
//
//  Created by 123 on 17/3/23.
//  Copyright © 2017年 贾云博. All rights reserved.
//

#import "FTBaseModel.h"

@interface UserInfoModel : FTBaseModel
//用户名称
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *attr;
@property (nonatomic,copy) NSString *authStatus;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *clientId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *lastLoginTime;
@property (nonatomic,copy) NSString *loginNum;
@property (nonatomic,copy) NSString *modifyTime;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *openId;
@property (nonatomic,copy) NSString *passwd;
@property (nonatomic,copy) NSString *paypwd;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *points;
@property (nonatomic,copy) NSString *qqOpenId;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *role;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *signature;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *userExtends;
@property (nonatomic,copy) NSString *wbOpenId;
@property (nonatomic,copy) NSString *wxOpenId;

@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *city;

//经纬度
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSDictionary *location;

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,copy) NSString *ip;
+ (UserInfoModel *)shareInstance;

//重新登录之后重构用户信息
- (void)configUserInfo;


//token = bff06f6f2a0f04f5a9b5a3cb3d7283a8b348699abaa00a6af1f0e13eed87719e;
//user =     {
//    account = 18384183553;
//    attr = "<null>";
//    authStatus = "<null>";
//    avatar = "<null>";
//    balance = 0;
//    clientId = "<null>";
//    createTime = 1493757356000;
//    id = 3;
//    lastLoginTime = 1494831406000;
//    loginNum = 25;
//    modifyTime = 1494831406000;
//    name = "<null>";
//    openId = "<null>";
//    passwd = "<null>";
//    paypwd = "<null>";
//    phone = 18384183553;
//    points = 0;
//    qqOpenId = "<null>";
//    remark = "<null>";
//    role = 2;
//    sex = "\U5173\U952e";
//    signature = "<null>";
//    state = 1;
//    userExtends = "<null>";
//    wbOpenId = "<null>";
//    wxOpenId = "<null>";
//};


@end
