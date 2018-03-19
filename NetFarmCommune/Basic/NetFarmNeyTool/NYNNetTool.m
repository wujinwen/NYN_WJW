//
//  NYNNetTool.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNNetTool.h"
//#define order order2

@implementation NYNNetTool
//分页查询农场接口
+ (void)FarmPageResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"merchant2/farm/page" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
    
    
    
    
}


//查询农场详情接口
+ (void)FarmWisdomResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *ID = [NSString stringWithFormat:@"%@",params[@"id"]];
    
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"merchant2/farm/query/%@",ID] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//查询农场主要产品分类
+ (void)ProductCatoryResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/product/category/root/query" params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//分页查询农场产品接口//user/product/page
+ (void)PageCategoryResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/farming/user/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询农场活动接口
+ (void)PageCategoryFramActiveResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"active/activity/user/queryFarmPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询农场比赛接口
+ (void)PageCategoryMatchResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"active/match/user/queryFarmPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询农场娱乐（categoryId 74:餐饮；75：住宿；78：娱乐(包含棋牌、垂钓)）接口
+ (void)PageCategoryOtherResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"pastime/pastime/user/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//查询农场产品详情接口
+ (void)ProductQueryResquestWithparams:(NSString *)ID isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"user/product/query/%@",ID];
    
    [FTNetTool postNewUrl:urlStr params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//product/seed/query

//分页查询农场产品接口
+ (void)SearchSeedResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/product/seed/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//农场一级界面获取分类
+ (void)BusinessResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"merchant2/farm/user/business" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//文件上传接口
+ (void)PostImageWithparams:(id )params andFile:(NSData *)file isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postImageUrl:@"upload/file/upload" andFile:file params:params isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);

    }];
    
}

//查询种子默认方案接口
+ (void)GetMoRenFangAnWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/template/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//查询种子自定义方案数据接口
+ (void)GetZiDingYiFangAnWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/template/art/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//查询农场所有管家接口
+ (void)GetGuanJiasWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/manager/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询农场标志牌接口
+ (void)GetBiaoShiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/farming/user/signboard/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询种子加工方式接口
+ (void)GetJiaGongFangShiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"farming/farming/user/process/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取引导页接口
+ (void)GetYinDaoTuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    
    [FTNetTool postNewUrl:@"config/init/ios" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//是否收藏
+ (void)ShiFouShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    
    [FTNetTool postNewUrl:@"collect/hascollected" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//增加收藏
+ (void)ZengJiaShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"collect/addcollect" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//取消收藏
+ (void)QuXiaoShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    
    [FTNetTool postNewUrl:@"user/canclecollect" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户中心模块 - 查询用户所有收货地址
+ (void)GetMyAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    
    [FTNetTool postNewUrl:@"user/user_address/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//用户中心模块 - 设置新的支付密码
+ (void)SetNewPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/user/setNewPasswd" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//用户中心模块 - 添加用户地址
+ (void)SearchAllAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    
    [FTNetTool postNewUrl:@"user/user_address/add" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户中心模块 - 找回支付密码

+ (void)ForgetPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"account/user/forgetPayPasswd" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//分页查询肥料
+ (void)FarmArtTuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"farming/farmArt/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//用户中心模块 - 删除用户收货地址
+ (void)DetelAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"user/user_address/delete/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//初始化产品
+ (void)InitDataWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //user/product/init
    
    [FTNetTool postNewUrl:@"farming/farming/user/init" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单模块 - 添加种植/养殖订单
+ (void)AddDealWithYangZhiZhongZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/order/plant/save" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//订单模块 - 添加集市,活动,娱乐（棋牌，住宿，餐饮等）,专属土地订单(!*)
+ (void)AddMarketSaveWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/order/market/save" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单支付模块 - 微信统一下单接口
+ (void)WeChatPayWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"account/pay/wxunified_order" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户中心模块 - 获取用户默认收获地址

+ (void)DefaultqueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"user/user_address/default/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}
//用户中心模块 - 检验支付密码

+ (void)CheckWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/user/check" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单支付模块 - 支付宝支付获取调用支付宝接口参数字符串
+ (void)AliPayWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/pay/alipay/payinfo" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//订单模块(用户端) - 订单收货

+ (void)ReceiveWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"order2/order/receive/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress)  {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//溯源

+ (void)SourceWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"comment/source/info/product/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单模块 -添加购物车

+ (void)CartWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/cart/item/add" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//用户端 - 集市模块 - 查询集市分类
+ (void)GetJiShiCategoryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"product/product/query/category" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户端 - 集市模块 - 查询集市产品
+ (void)ChaXunMarketDataWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"product/product/user/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//订单模块 -余额支付

+ (void)CostBlanceWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/pay/costBlance" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户端 - 集市模块 - 查看集市产品详情
+ (void)QueryInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"product/product/user/queryInfo" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//用户中心模块 - 绑定手机号码
+ (void)BindPhoneWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/user/bindphone" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//用户 - 是否有支付密码
+ (void)IsPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/user/isPayPasswd" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//用户 - 添加支付密码
+ (void)AddPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/user/addPayPasswd" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//个人收藏 - 我的收藏
+ (void)GetCollectionWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"collect/collectlist" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//查询用户相片接口
+ (void)GetPicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/user/photo/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//保存用户相片接口
+ (void)SavePicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/user/photo/add" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//删除用户相片接口
+ (void)DetelPicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"user/user/photo/delete/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//修改登录用户信息接口
+ (void)ModifyUserInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"login2/user/update" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

////我的农场 - 查询我的农场种植订单
//+ (void)ZhongZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//
//    [FTNetTool postNewUrl:@"order2/myfarm/plant/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
//
//    } success:^(id response) {
//        success(response);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

//我的农场 - 查询我的农场种植养殖订单
+ (void)YangZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/plantOrder/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//我的农场 - 查询土地专属列表
+ (void)MyFarmZhuanShuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"activity/lease/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//土地/养殖场地模块 - 分页查询专属土地
+ (void)EnterpriseWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"farming/land/customer/enterprise/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单模块 - 查询消费订单分页

+ (void)ConsumeWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/order/market/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//我的农场 - 查询我的农场已完成订单
+ (void)MyFarmCompletWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/myfarm/completed/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//我的农场 - 查询土地/养殖资料
+ (void)MyFarmSearchTuDiZiLiaoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"order2/myfarm/plant/query/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//我的农场 - 查询种植/养殖计划
+ (void)SearchYangZhongJiHuaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"order2/myfarm/plant/plan/query/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//种植养殖订单 - 查询种植/养殖计划
+ (void)PlantOrderJihuaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"order2/plantOrder/plan/query/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//农场模块 - 添加新任务时查询产品服务
+ (void)MyFarmNewTaskWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"user/product/newtask/art/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户端 - 新任务 - 查询订单任务记录
+ (void)MyFarmNewTaskHistoryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/task/newtask/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//用户端 - 新任务 - 添加新任务
+ (void)MyFarmNewAddTaskWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/task/newtask/append" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//订单模块 - 删除订单
+ (void)MyFarmDetelDealWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"order2/order/delete/%@",params] params:nil isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//购物车模块(用户端) - 查询购物车
+ (void)CartQueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/cart/item/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}





//订单模块-专属土地订单
+ (void)AddEnterpriseWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/enterprise/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//订单模块 - 添加评论
+ (void)MyFarmAddPingJiaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"order2/review/add" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//分页查询农场土地

+ (void)QueryPageParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"farming/land/customer/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



//监控直播 - 直播间列表
+ (void)PostLiveListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/list" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//监控直播 - 创建直播间
+ (void)CreateLivePushWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/create" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//直播间信息
+ (void)LiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//live/info" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//监控直播 - 获取农场直播信息
+ (void)GetFarmLiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//live/farm" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//监控直播 -  获取直播间收到的礼品列表
+ (void)GetGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/roomgift" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//监控直播 -  获取我的直播列表
+ (void)GetMyLiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/minfo" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



//监控直播 -  获取直播间信息
+ (void)GetInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/info" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
////监控直播 - 切换直播状态
//+ (void)SwitchStatusWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//    
//    [FTNetTool postNewUrl:@"l//live/start" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
//        
//    } success:^(id response) {
//        success(response);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

//监控直播 - 切换直播状态
+ (void)SwitchStatusWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//live/start" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//监控直播 -  添加禁言
+ (void)GetgagInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//chatroom/user/gag" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//监控直播 -  移除禁言
+ (void)GetgagrollbackInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//chatroom/user/gagrollback" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//监控直播 - 禁言聊天室
+ (void)GetGaglistInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [FTNetTool postNewUrl:@"l//chatroom/user/gaglist" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//监控直播 -  查询聊天室所有用户
+ (void)GetChatRoomInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//chatroom/user/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//监控直播 -  收到的礼品列表
+ (void)GetSendGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//gift/list" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//监控直播 - 送礼
+ (void)GetGuanSendGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//live/sendgift" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//连麦----请求连麦
+ (void)GetUnionInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//union/union_request" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}
//接受连麦
+ (void)AcceptLianmaiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//union/accept" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//请求连麦列表
+ (void)RequestLianmaiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"l//union/request_list" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//社区群组

+ (void)GetQunZunParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"sns/group/queryGroupByUserId" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//查询我的好友
+ (void)GetFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"sns/friend/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//新朋友
+ (void)GetNewFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"sns/friend/query/request" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//处理好友请求
+ (void)GetDealFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"sns/friend/request/handle" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//创建群组
+ (void)GreatGrounpParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"sns/group/create" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//查询活动列表  orderType:排序类型，time-时间，popularity-人气，position-距离   orderBy：排序规则， asc-顺序，desc-倒序
+ (void)ActivityListParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"active/activity/user/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//活动首页接口
+ (void)ActivityUserHomeParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"active/activity/user/home" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//查询首页集市产品
+ (void)HomeMarketParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"product/product/user/home" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark--拍卖

//分页查询农场拍卖品

+ (void)QuerySaleParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"user/sale/query/page" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//首页拍卖品展示

+ (void)QuerySaleHomeParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"user/sale/query/home" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//分页查询比赛列表
+ (void)MatchListParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"active/match/user/queryFarmPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark---产品 - 查询农产品分页
//产品 - 查询农产品分页
+ (void)ProductQueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"product/product/user/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 查询订单物流信息
+ (void)ShippingParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/shipping/express/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark---购物车
//删除购物车
+ (void)DeleteCartParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/cart/item/delete" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//购物车下单
+ (void)OrderCartaddParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/order/cart/add" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//订单模块(用户端) - 查询产品运费计算方式

+ (void)ShippingmethodWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"order2/order/shippingmethod/query" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark--退款模块
//提交退款申请
+ (void)AccountfundParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/refund/user/save" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark--产品

//自己种时搜索种子

+ (void)SearchSeedParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"product/product/user/seed/search" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//比赛分页接口

+ (void)MatchQueryPageParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"active/match/user/queryPage" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//监控直播 - 获取设备id
+ (void)GetVisitorloginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"login2/user/visitor/login" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark--支付
//支付宝充值

+ (void)AccountPayParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/pay/ali_recharge" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//微信充值接口

+ (void)AccountPayWXParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:@"account/pay/wx_recharge" params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//活动详情接口

+ (void)ActiveDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"%@%@",@"active/activity/user/info/",Id] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//比赛详情接口

+ (void)MatchDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"%@%@",@"active/match/user/info/",Id] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//餐饮、住宿详情接口
+ (void)LogleRestaurantDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"%@%@",@"pastime/pastime/user/info/",Id] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//拍卖详情接口
+ (void)aleDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"%@%@",@"user/sale/query/info/",Id] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//租地详情接口
+ (void)activeLeaseDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FTNetTool postNewUrl:[NSString stringWithFormat:@"%@%@",@"activity/lease/query/",Id] params:params isTestLogin:isTestLogin progress:^(NSProgress *progress) {
        
        
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
