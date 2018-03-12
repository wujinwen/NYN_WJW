//
//  AppDelegate.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "AppDelegate.h"
#import "FTTabarViewController.h"
#import "FTLoginViewController.h"
#import "FTNavigationViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "NYNLeadingViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "WXApi.h"
//#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
//融云
#import "RCDLive.h"
#import "RCDLiveGiftMessage.h"
#import "NYNMessageContent.h"

#import "NYNLiveGiftMessege.h"
//百度地图相关
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <RongIMLib/RongIMLib.h>
#import "NYNTextMessage.h"
#import "YfLisenceManger.h"
#define  WeChatApi @"wxbf8cec66f691fe6e"
//#define  AliPayAppID @"2017020905583126"
#define  BaiDuAK @"4SS9cSeKG3el45t0rRvr4uIPkEvxp9rB"
#import <CoreLocation/CoreLocation.h>
#import "TZLocationManager.h"

@interface AppDelegate ()<CLLocationManagerDelegate,WXApiDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapManager* _mapManager;
}
@property (nonatomic, strong) BMKLocationService* locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong) CLLocationManager *locationManager;//定位服务
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //融云appkey
//    [[RCIMClient sharedRCIMClient]initWithAppKey:@"sfci50a7so6ki"];
    [[RCDLive sharedRCDLive] initRongCloud:@"sfci50a7so6ki"];
    //注册自定义消息
    [[RCDLive sharedRCDLive] registerRongCloudMessageType:[NYNLiveGiftMessege class]];
    [[RCDLive sharedRCDLive] registerRongCloudMessageType:[NYNMessageContent class]];

     [[RCDLive sharedRCDLive] registerRongCloudMessageType:[NYNTextMessage class]];
    //云帆
    [YfLisenceManger LisenceWithAK:"9e7e8f20449079bb22311b028ee98685293831c3" Token:"d96f95206a0a7601437d9699d9d48108626864c0" YfAuthResult:^(int flag, NSString *description) {
        NSLog(@"鉴权=%@",description);
        
    }];
    
    NSLog(@"-----%@",JZFetchMyDefault(SET_USER)[@"rongToken"]);
    //当没有融云token的时候要获取设备的id并且使用设备id获取token
    
    if (JZFetchMyDefault(SET_USER)[@"rongToken"] ==NULL) {
        NSString *uuid = JZFetchMyDefault(@"uuid");
        
        NSDictionary * dic = @{@"deviceId":uuid};
        
        [NYNNetTool GetVisitorloginWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                //链接融云服务器,程序进来就链接  JZFetchMyDefault(SET_USER)[@"rongToken"]
                [[RCIMClient sharedRCIMClient] connectWithToken:success[@"data"][@"rongToken"] success:^(NSString *loginUserId) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        RCUserInfo *user = [[RCUserInfo alloc]init];
                        user.userId = JZFetchMyDefault(SET_USER)[@"id"];
                        user.portraitUri = @"";//头像
                        user.name = JZFetchMyDefault(SET_USER)[@"name"];
                        [RCIMClient sharedRCIMClient].currentUserInfo = user;
                        NSLog(@"连接成功");
                        
                        
                    });
                } error:^(RCConnectErrorCode status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                    
                } tokenIncorrect:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                }];
            }
            
            
        } failure:^(NSError *failure) {
            
            
        }];
        
    }else{
        //链接融云服务器,程序进来就链接
        [[RCIMClient sharedRCIMClient] connectWithToken:JZFetchMyDefault(SET_USER)[@"rongToken"]success:^(NSString *loginUserId) {
            dispatch_async(dispatch_get_main_queue(), ^{
                RCUserInfo *user = [[RCUserInfo alloc]init];
                user.userId = JZFetchMyDefault(SET_USER)[@"id"];
                user.portraitUri = @"";//头像
                user.name = JZFetchMyDefault(SET_USER)[@"name"];
                [RCIMClient sharedRCIMClient].currentUserInfo = user;
                NSLog(@"连接成功");
                
                
            });
        } error:^(RCConnectErrorCode status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
        } tokenIncorrect:^{
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
    }
    

    
    

//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
//        UserInfoModel * usermodel = usermodel;
//        NSLog(@"%@",location);
//
//    } failureBlock:^(NSError *error) {
//    }];
    //微信
    [self registWeChat];
    //传uuid和时间戳,md5加密转成字符串
    [self configUUID];
    //定位
    [self starLocation];
    
    [self registUM];
    
    //获取当前ip
    [self getCurrentLocalIP];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    

    
    
    
    
    
    
    //    利用NSUserDefaults实现
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"首次启动");
        //引导页
        NYNLeadingViewController *vc = [[NYNLeadingViewController alloc] init];
        __weak typeof(self)weakSelf = self;
        vc.Go = ^(NSString *s) {
            
            
            FTTabarViewController *tabar = [[FTTabarViewController alloc]init];
            
            weakSelf.window.rootViewController = tabar;
        };
        self.window.rootViewController = vc;
    }else {
        NSLog(@"非首次启动");
        FTTabarViewController *tabar = [[FTTabarViewController alloc]init];
        
        self.window.rootViewController = tabar;
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark---
#pragma 友盟
//注册UM
- (void)registUM{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"593522c0f5ade467f10015fd"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbf8cec66f691fe6e" appSecret:@"7948faaba463620e8e90456c8e34c99b" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    BOOL weChatResult = [WXApi handleOpenURL:url delegate:self];

    if (result) {
        return result;
    }
    else if (weChatResult) {
        return weChatResult;
    }
    else{
        return result;
    }
}

//仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
        return YES;

    }
    return result;
}

//支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


#pragma 定位
- (void)starLocation{
    //这里给一个默认定位的位置
    
//    NSDictionary *locationDic = [NSDictionary dictionaryWithDictionary:JZFetchMyDefault(@"location")];
//
//    if (locationDic.allKeys.count < 1) {
//        NSDictionary *userLocation = @{@"lat":@"100.31",@"lon":@"30.01",@"province":@"四川省",@"city":@"成都市"};
//        JZSaveMyDefault(@"location", userLocation);
//    }

    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
//    NSLog(@"start gps");
//    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BaiDuAK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    //切换到百度地图
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


#pragma mark - BMK_LocationDelegate 百度地图
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"地图定位失败======%@",error);
 
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    
    //从manager获取左边
//    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;//位置坐标
    //存储经纬度
//   [self.userLocationInfoModel SaveLocationCoordinate2D:coordinate];
    
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0))
    {
        
        
        //发送反编码请求
        [self sendBMKReverseGeoCodeOptionRequest];
        
//        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
//        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
//        [self reverseGeoCodeWithLatitude:latitude withLongitude:longitude];
        
    }else{
        NSLog(@"位置为空");
    }
    
    //关闭坐标更新
//    [self.locService stopUserLocationService];
}

//地图定位
- (BMKLocationService *)locService
{
    if (!_locService)
    {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return _locService;
}

//检索对象
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch)
    {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}

#pragma mark ----反向地理编码
- (void)reverseGeoCodeWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    
    //发起反向地理编码检索
    
    CLLocationCoordinate2D coor;
    coor.latitude = [latitude doubleValue];
    coor.longitude = [longitude doubleValue];
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coor;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];;
    if (flag)
    {
        NSLog(@"反地理编码成功");//可注释
    }
    else
    {
        NSLog(@"反地理编码失败");//可注释
    }
}

//发送反编码请求
- (void)sendBMKReverseGeoCodeOptionRequest{
    
//    self.isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (_locService.userLocation.location.coordinate.longitude!= 0
        && _locService.userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){_locService.userLocation.location.coordinate.latitude,
            _locService.userLocation.location.coordinate.longitude};
    }
    
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
//    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
    
    // 1.获取用户位置的对象
    CLLocation *location = _locService.userLocation.location;
    CLLocationCoordinate2D coordinate = pt;

    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
//        UserInfoModel *jzUserModel = userInfoModel;
//    jzUserModel.latitude =[NSString stringWithFormat:@"%f",coordinate.latitude] ;
//    jzUserModel.longitude =[NSString stringWithFormat:@"%f",coordinate.longitude] ;
    
    
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        if (error != nil) {
            JZLog(@"定位发生错误！！！！！");
            return ;
        }
        

        
        CLPlacemark *placeMark  = [placemarks lastObject];
        
        //        for (CLPlacemark *placeMark in placemarks)
        //        {
        NSDictionary *addressDic=placeMark.addressDictionary;
        
        NSString *state=[addressDic objectForKey:@"State"];
        NSString *city=[addressDic objectForKey:@"City"];
        NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
        NSString *street=[addressDic objectForKey:@"Street"];
        //存定位信息userdefault
        
        NSLog(@"当前位置就在:-%@-\n-%@-\n-%@",city,subLocality,street);
        
//        if (!([city rangeOfString:@"香港"].location == NSNotFound)) {
//
//            JZLog(@"定位失败");
//            
//            return;
//        }
        
        NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
        
        NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSDictionary *userLocation = @{@"lat":lat,@"lon":lon,@"province":[NSString stringWithFormat:@"%@",state],@"city":[NSString stringWithFormat:@"%@",city]};
//        JZSaveMyDefault(@"location", userLocation);
        
//        NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
//        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
//        [userDic setObject:userLocation forKey:@"location"];
//      [ss setObject:userDic forKey:@"user"];
        JZSaveMyDefault(SET_Location, userLocation);
        
        JZLog(@"定位%@",JZFetchMyDefault(SET_Location));
//
//        JZLog(@"%@", [NSString stringWithFormat:@"location city : %@",city]);
//        
//        //定位发生改变
//        POST_NTF(@"changeLocation", nil);
        //        }
        
        
//        if (<#condition#>) {
//            <#statements#>
//        }
        
        
        [self.locService stopUserLocationService];

        
    }];

    
}


//发送成功,百度将会返回东西给你
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                          result:(BMKReverseGeoCodeResult *)result
                       errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *address1 = result.address; // result.addressDetail ///层次化地址信息
        NSLog(@"我的位置在 %@",address1);
        
        //保存位置信息到模型
//        [self.userLocationInfoModel saveLocationInfoWithBMKReverseGeoCodeResult:result];
        
        //进行缓存处理，上传到服务器等操作
    }
    
}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"我的位置在 %u",error);

}


//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray *)locations
//{
//    // 1.获取用户位置的对象
//    CLLocation *location = [locations firstObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
//    
//    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
//    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {
//        
//        if (error != nil) {
//            JZLog(@"定位发生错误！！！！！");
//            return ;
//        }
//        
//        CLPlacemark *placeMark  = [placemarks lastObject];
//        
////        for (CLPlacemark *placeMark in placemarks)
////        {
//            NSDictionary *addressDic=placeMark.addressDictionary;
//            
//            NSString *state=[addressDic objectForKey:@"State"];
//            NSString *city=[addressDic objectForKey:@"City"];
//            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
//            NSString *street=[addressDic objectForKey:@"Street"];
//            
//            NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
//        
//            NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
//            NSDictionary *userLocation = @{@"lat":lat,@"lon":lon,@"province":[NSString stringWithFormat:@"%@",state],@"city":[NSString stringWithFormat:@"%@",city]};
//            JZSaveMyDefault(@"location", userLocation);
//
//        JZLog(@"%@", [NSString stringWithFormat:@"location city : %@",city]);
//        
//            //定位发生改变
//            POST_NTF(@"changeLocation", nil);
////        }
//        
//           JZSaveMyDefault(SET_USER, userInfoDic);
//        
//    }];
//
//    // 2.停止定位
//    [self.locationManager stopUpdatingLocation];
//
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error
//{
//    if (error.code == kCLErrorDenied) {
//        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
//    }
//}

- (void)configUUID{
    id uid = JZFetchMyDefault(@"uuid");
    BOOL is = [uid isKindOfClass:[NSString class]];
    if (!is) {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        JZSaveMyDefault(@"uuid", uuid);
    }
}

//初始化微信
- (void)registWeChat{
    [WXApi registerApp:WeChatApi];
}

//获取当前ip
- (void)getCurrentLocalIP
{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    UserInfoModel *model = userInfoModel;
    model.ip = address;
}
#pragma mark--全屏转换
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.isHengping) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
