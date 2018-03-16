//
//  NYNNetTool.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNNetTool : NSObject
////查询所有业务类型
//+ (void)BusinessResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;



//分页查询农场接口
+ (void)FarmPageResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询农场详情接口
+ (void)FarmWisdomResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询农场主要产品分类
+ (void)ProductCatoryResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//分页查询农场产品接口
+ (void)PageCategoryResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//分页查询农场活动接口
+ (void)PageCategoryFramActiveResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//分页查询农场比赛接口
+ (void)PageCategoryMatchResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//分页查询农场娱乐（categoryId 74:餐饮；75：住宿；78：娱乐(包含棋牌、垂钓)）接口
+ (void)PageCategoryOtherResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//查询农场产品详情接口
+ (void)ProductQueryResquestWithparams:(NSString *)ID isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//分页查询农场产品接口
+ (void)SearchSeedResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//农场一级界面获取分类
+ (void)BusinessResquestWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//文件上传接口
+ (void)PostImageWithparams:(id )params andFile:(NSData *)file isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询种子默认方案接口
+ (void)GetMoRenFangAnWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询种子自定义方案数据接口
+ (void)GetZiDingYiFangAnWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询农场所有管家接口
+ (void)GetGuanJiasWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//分页查询农场标志牌接口
+ (void)GetBiaoShiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//分页查询种子加工方式接口
+ (void)GetJiaGongFangShiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//获取引导页接口
+ (void)GetYinDaoTuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//分页查询肥料
+ (void)FarmArtTuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//是否收藏
+ (void)ShiFouShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//增加收藏
+ (void)ZengJiaShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//取消收藏
+ (void)QuXiaoShouCangWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 查询用户所有收货地址
+ (void)GetMyAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 添加用户地址
+ (void)SearchAllAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 添加用户地址
+ (void)InitDataWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 删除用户收货地址
+ (void)DetelAddressWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 设置新的支付密码
+ (void)SetNewPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//用户中心模块 - 找回支付密码

+ (void)ForgetPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户中心模块 - 检验支付密码

+ (void)CheckWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//订单模块 - 添加种植/养殖订单
+ (void)AddDealWithYangZhiZhongZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块-专属土地订单
+ (void)AddEnterpriseWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块 - 添加集市,活动,娱乐（棋牌，住宿，餐饮等）,专属土地订单(!*)
+ (void)AddMarketSaveWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//订单模块(用户端) - 查询产品运费计算方式

+ (void)ShippingmethodWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//订单模块(用户端) - 订单收货

+ (void)ReceiveWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//土地/养殖场地模块 - 分页查询专属土地
+ (void)EnterpriseWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;



//溯源

+ (void)SourceWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//产品 - 查询农产品分页
+ (void)ProductQueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//订单支付模块 - 微信统一下单接口
+ (void)WeChatPayWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单支付模块 - 支付宝支付获取调用支付宝接口参数字符串
+ (void)AliPayWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户端 - 集市模块 - 查询集市分类
+ (void)GetJiShiCategoryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户端 - 集市模块 - 查询集市产品
+ (void)ChaXunMarketDataWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户端 - 集市模块 - 查看集市产品详情
+ (void)QueryInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//用户中心模块 - 获取用户默认收获地址

+ (void)DefaultqueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;



//购物车模块(用户端) - 查询购物车
+ (void)CartQueryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//用户中心模块 - 绑定手机号码
+ (void)BindPhoneWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//个人收藏 - 我的收藏
+ (void)GetCollectionWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//查询用户相片接口
+ (void)GetPicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//保存用户相片接口
+ (void)SavePicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//删除用户相片接口
+ (void)DetelPicsWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//修改登录用户信息接口
+ (void)ModifyUserInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

////我的农场 - 查询我的农场种植订单
+ (void)ZhongZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//我的农场 - 查询我的农场养殖订单
+ (void)YangZhiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//我的农场 - 查询土地专属列表
+ (void)MyFarmZhuanShuWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//我的农场 - 查询我的农场已完成订单
+ (void)MyFarmCompletWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//我的农场 - 查询土地/养殖资料
+ (void)MyFarmSearchTuDiZiLiaoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//种植养殖订单 - 查询种植/养殖计划
+ (void)PlantOrderJihuaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//我的农场 - 查询种植/养殖计划
+ (void)SearchYangZhongJiHuaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//农场模块 - 添加新任务时查询产品服务
+ (void)MyFarmNewTaskWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户端 - 新任务 - 查询订单任务记录
+ (void)MyFarmNewTaskHistoryWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户端 - 新任务 - 添加新任务
+ (void)MyFarmNewAddTaskWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块 - 删除订单
+ (void)MyFarmDetelDealWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块 - 添加评论
+ (void)MyFarmAddPingJiaWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//订单模块 - 查询消费订单分页

+ (void)ConsumeWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块 -添加购物车

+ (void)CartWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//订单模块 -余额支付

+ (void)CostBlanceWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//用户 - 是否有支付密码
+ (void)IsPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//用户 - 添加支付密码
+ (void)AddPayPasswdWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;



//监控直播 - 直播间列表
+ (void)PostLiveListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//监控直播 - 创建直播间
+ (void)CreateLivePushWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 - 切换直播状态
+ (void)SwitchStatusWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//直播间信息
+ (void)LiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  获取直播间收到的礼品列表
+ (void)GetGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  获取直播间信息
+ (void)GetInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  礼品列表
+ (void)GetSendGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 - 送礼
+ (void)GetGuanSendGiftListWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//监控直播 -  我的直播
+ (void)GetMyLiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//监控直播 - 获取设备id
+ (void)GetVisitorloginWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  查询被禁言聊天室成员方法
+ (void)GetGaglistInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  查询聊天室所有用户
+ (void)GetChatRoomInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 -  添加禁言
+ (void)GetgagInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//监控直播 -  移除禁言
+ (void)GetgagrollbackInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//监控直播 - 获取农场直播信息
+ (void)GetFarmLiveInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//请求连麦
+ (void)GetUnionInfoWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//接受连麦
+ (void)AcceptLianmaiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//请求连麦列表
+ (void)RequestLianmaiWithparams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


#pragma mark--社区
//查询我的好友
+ (void)GetFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//群组
+ (void)GetQunZunParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//新朋友
+ (void)GetNewFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//处理好友请求
+ (void)GetDealFriendParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//创建群组
+ (void)GreatGrounpParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//查询活动列表
+ (void)ActivityListParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//活动首页接口
+ (void)ActivityUserHomeParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark--首页
//查询首页集市产品
+ (void)HomeMarketParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


#pragma mark--拍卖

//分页查询农场拍卖品

+ (void)QuerySaleParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
#pragma mark--拍卖

//首页拍卖品展示

+ (void)QuerySaleHomeParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//拍卖 - 出价
+ (void)SaleBidParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;




//分页查询农场土地

+ (void)QueryPageParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark--比赛
//分页查询比赛列表
+ (void)MatchListParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//比赛分页接口

+ (void)MatchQueryPageParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark---物流
// 查询订单物流信息
+ (void)ShippingParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark---购物车
//删除购物车
+ (void)DeleteCartParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//购物车下单
+ (void)OrderCartaddParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark--退款模块
//提交退款申请
+ (void)AccountfundParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark--产品

//自己种时搜索种子

+ (void)SearchSeedParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

#pragma mark--支付
//支付宝充值

+ (void)AccountPayParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//微信充值接口

+ (void)AccountPayWXParams:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;


+ (void)ActiveDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)MatchDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)LogleRestaurantDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)SaleDeId:(NSString *)Id Params:(id )params isTestLogin:(BOOL)isTestLogin progress:(void (^)(NSProgress *))progress  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end



