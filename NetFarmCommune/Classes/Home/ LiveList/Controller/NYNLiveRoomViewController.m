//
//  NYNLiveRoomViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLiveRoomViewController.h"
#import "RCDLiveMessageCell.h"
#import "RCDLiveTextMessageCell.h"
#import "RCDLiveGiftMessageCell.h"
#import "RCDLiveGiftMessage.h"
#import "RCDLiveTipMessageCell.h"
#import "RCDLiveMessageModel.h"
#import "RCDLive.h"
#import "RCDLiveCollectionViewHeader.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "MBProgressHUD.h"
#import "RCDLivePortraitViewCell.h"
#import "Masonry.h"
#import "UIImage+Radius.h"
//云帆推流头文件
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "NYNPushStreamModel.h"
#import <YFMediaPlayerPushStreaming/YFMediaPlayerPushStreaming.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import <YFMediaPlayerPushStreaming/YfSessionCamera.h>
#import <YFMediaPlayerPushStreaming/XXManager.h>"

#import "NYNNetTool.h"
#import "NYNLiveInfoModel.h"
#import "ReceiveGiftView.h"
#import "NYNSetLiveView.h"
#import "PreviewView.h"
#import "UIImageView+WebCache.h"


#import "UIView+RCDDanmaku.h"
#import "RCDDanmaku.h"
#import "RCDDanmakuManager.h"
#import "StopSpeakView.h"
#import "clarityView.h"

#import "LianmaiListView.h"
#import "BeautyView.h"
#import "NYNMessageContent.h"
#import "NYNLiveGiftMessege.h"

#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"
#import "NYNTextMessage.h"

#import <Photos/Photos.h>
#import <UShareUI/UShareUI.h>
#import "NYNGouMaiWangNongBiViewController.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
//输入框的高度
#define MinHeight_InputView 50.0f
#define kBounds [UIScreen mainScreen].bounds.size


@interface NYNLiveRoomViewController ()<RCConnectionStatusChangeDelegate,RCTKInputBarControlDelegate,YfSessionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,NYNSetLiveViewDelagate,clarityViewDelagate,BeautyClickDelagate,YfFFMoviePlayerControllerDelegate>
{
    UIView *toolBar;
    NSString * imageString;//选择图片的string
    NSTimer *timer;//刷新房间信息定时器
    BOOL danmuState;//是否发送弹幕
    BOOL goPickerImage;//是否跳转选择图片
}

//UI
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UIButton *switchCamera;
@property (strong,nonatomic) NSTimer *timer;//时间

@property (nonatomic, strong) UIImageView *imageView;//主播头像
@property(nonatomic,strong) UILabel *chatroomlabel ;//房间名
@property(nonatomic,strong)UILabel * renqiLabel; //人气

@property (nonatomic, strong) UIView * danmuView;//弹幕视图
@property(nonatomic,strong)UIImageView * sendDanmuImage;//发送弹幕者头像

@property(nonatomic,strong)UIButton  * beautyBtn1;//开始直播前的美颜按钮
@property(nonatomic,strong)UIButton  * modelBtn1;//开始直播前直播模式

//Func
//直播关键类
@property(nonatomic,strong) YfSession *yfSession;
//网络判断管理类
@property(nonatomic,strong) AFNetworkReachabilityManager *reachabilityMannger;
//推流状态
@property(nonatomic,assign) YfSessionState rtmpSessionState;
//是否手动点击关闭推流
@property(nonatomic,assign) BOOL isManualCloseLive;
//重推流的最大次数
@property (nonatomic, assign) NSInteger retryPushStreamCount;

@property (nonatomic, strong) NSMutableArray *registeredNotifications;

@property (nonatomic, assign) BOOL isPushed;
@property(nonatomic,strong)PreviewView * preview;//预览图


@property(nonatomic,strong)UIImageView * headImageView;//头像选择
@property (nonatomic, strong) NYNLiveInfoModel * liveInfoModel;//直播间参数

/**
 *  是否需要滚动到底部
 */
@property(nonatomic, assign) BOOL isNeedScrollToButtom;
/**
 *  滚动条不在底部的时候，接收到消息不滚动到底部，记录未读消息数
 */
@property (nonatomic, assign) NSInteger unreadNewMsgCount;

/**
 *  点击空白区域事件
 */
@property(nonatomic, strong) UITapGestureRecognizer *resetBottomTapGesture;

/**
 *  返回按钮
 */
@property (nonatomic, strong) UIButton *backBtn;

/**
 *  设置点赞按钮
 */
@property(nonatomic,strong)UIButton *clapBtn;

/**
 *  收到礼物按钮
 */
@property(nonatomic,strong)UIButton *flowerBtn;

/**
 *  摄像头转换按钮
 */
@property(nonatomic,strong)UIButton *switchBtn;
/**
 *  评论
 */
@property(nonatomic,strong)UIButton *commentBtn;

/**
 *  人气
 */
@property(nonatomic,strong)UIButton *peopleBtn;



@property(nonatomic,strong)UILabel * roomlabel;//房间号
@property(nonatomic,strong)UIView * topBackView;




//观看人员头像显示
@property(nonatomic,strong)UICollectionView *portraitsCollectionView;

@property(nonatomic,strong)NSMutableArray *userList;

@property(nonatomic,strong)UITextField * textField;//直播名输入

@property(nonatomic,strong) UIActionSheet *actionSheet;;


@property(nonatomic,strong)  NSString * giftName;//礼物名称

@property(nonatomic,strong)NYNSetLiveView * setView ;

@property(nonatomic,strong)UILabel * peopleLabel;//人数
@property(nonatomic,strong) UIView * guanzhongView;





@end
/**
 *  文本cell标示
 */
static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";

/**
 *  小灰条提示cell标示
 */
static NSString *const RCDLiveTipMessageCellIndentifier = @"RCDLiveTipMessageCellIndentifier";

@implementation NYNLiveRoomViewController


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self rcinit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self rcinit];
    }
    return self;
}

/**
 *  移除监听
 *
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"kRCPlayVoiceFinishNotification"object:nil];
    
    //    [self.conversationMessageCollectionView removeGestureRecognizer:_resetBottomTapGesture];
    //    [self.conversationMessageCollectionView addGestureRecognizer:_resetBottomTapGesture];
    
    //退出页面，弹幕停止
    //  [self.view stopDanmaku];
    //调用切换直播状态
    if (!goPickerImage) {
        [self liveStatus];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.view addGestureRecognizer:_resetBottomTapGesture];
    [self.conversationMessageCollectionView reloadData];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //加载直播名称输入框
    [self.view addSubview:self.textField];
    [self setHeadImageSelect];
    //加载直播预览
    [self.view addSubview:self.preview];
    [self.view addSubview:self.exitBtn];
    
    //开始直播按钮点击block回调
    __weak typeof(PreviewView*) preself = self.preview;
    __weak NYNLiveRoomViewController *weakSelf = self;
    
    self.preview.startClick =^(){
        preself.hidden  =YES;
        //初始化UI
        [weakSelf initializedSubViews];
        //创建直播间
        [weakSelf creatLiveRoom];
    };
    [self registerNotification];
    //视频播放初始化
    [self YunfanInitiaData];
    [_yfSession reSetBitarate:300000];
    [self.view addSubview:self.guanzhongView];
    
}


-(void)startLiveRoomData{
    __weak NYNLiveRoomViewController *weakSelf = self;
    
    self.defaultHistoryMessageCountOfChatRoom = 10;
    //聊天室类型进入时需要调用加入聊天室接口，退出时需要调用退出聊天室接口
    if (ConversationType_CHATROOM == self.conversationType) {
        [[RCIMClient sharedRCIMClient]
         joinChatRoom:self.targetId
         messageCount:10
         success:^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 ;
                 //                 @property(nonatomic, strong) NSString *message;//通知的内容
                 //
                 //                 /*!
                 //                  通知的附加信息
                 //                  */
                 //                 @property(nonatomic, strong) NSString *extra;//用户id
                 //                 RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                 //                 joinChatroomMessage.message = @"加入直播间";
                 //                 joinChatroomMessage.extra = _liveID;
                 //
                 //                 joinChatroomMessage.message = [NSString stringWithFormat: @"%@%@%@",userInfoModel.name, joinChatroomMessage.message,joinChatroomMessage.extra];
                 //                 [self sendMessage:joinChatroomMessage pushContent:nil];
             });
         }
         error:^(RCErrorCode status) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (status == KICKED_FROM_CHATROOM) {
                     [weakSelf loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomRejected", @"RongCloudKit", nil)];
                 } else {
                     [weakSelf loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomFailed", @"RongCloudKit", nil)];
                 }
             });
         }];
        
    }
}
/********************直播间数据请求*************************************************************************/

-(void)getLiveInfoData{
    [NYNNetTool GetInfoWithparams:@{@"id":_liveID} isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NYNLiveInfoModel *model = [NYNLiveInfoModel mj_objectWithKeyValues:success[@"data"]];
            //            [self.userList addObject:model];//这里哦数组是个model然后到下面调的房里
            self.liveInfoModel = model;
            
            [self initChatroomMemberInfo];
        }
    } failure:^(NSError *failure){
    }];
    
}

#pragma mark----NYNSetLiveViewDelagate

-(void)keyboard{
    NSUInteger windowCount = [[[UIApplication sharedApplication] windows] count];
    if(windowCount < 2) {
        return;
    }
    if(windowCount == 3)//ios9以上，UIRemoteKeyboardWindow
    {
        UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:2];
        keyboardWindow.bounds =CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        keyboardWindow.center = CGPointMake([[UIScreen mainScreen] bounds].size.width*0.5f,[[UIScreen mainScreen] bounds].size.height*0.5f);
        keyboardWindow.transform = CGAffineTransformMakeRotation(0);
    }
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    keyboardWindow.bounds =CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    keyboardWindow.center = CGPointMake([[UIScreen mainScreen] bounds].size.width*0.5f,[[UIScreen mainScreen] bounds].size.height*0.5f);
    keyboardWindow.transform = CGAffineTransformMakeRotation(0);
}
#pragma mark--------码率调整
//清晰度
-(void)BDBtnClick:(UIButton *)sender{
    
    clarityView * clarityV = [[clarityView alloc]init];
    clarityV.delagate = self;
    [self.view addSubview:clarityV];
    [clarityV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(300);
    }];
}

-(void)screenSwitch:(UIButton *)sender{
    BeautyView * beautyV = [[BeautyView alloc]init];
        beautyV.delegate = self;
    [self.view addSubview:beautyV];
    [beautyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(JZHEIGHT(300));
    }];

}


#pragma mark--clarityViewDelagate
//标清
-(void)BDBtnClickEvent:(UIButton *)sender{
    //重新设置码率
    [_yfSession reSetBitarate:400*1000];
    
}
-(void)HDBtnClickEvent:(UIButton *)sender{
    //重新设置码率
    [_yfSession reSetBitarate:600*1000];
}
//超清
-(void)SHBTNClickEvent:(UIButton *)sender{
    //重新设置码率
    [_yfSession reSetBitarate:600*1000];
}

/********************推流视频初始化加载*************************************************************************/

- (void)zoom:(UIPinchGestureRecognizer *)ping{
    if (self.yfSession) {
        [self.yfSession.videoCamera SetVideoZoom:ping.scale];
    }
}

- (void)networkReachabilityStatusChange{
    __weak typeof(self) weakSelf = self;
    [self.reachabilityMannger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *result = @"";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                result = @"未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                result = @"无网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                result = @"WAN";
                [weakSelf.yfSession ShutErrorRtmpSession];
                
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                result = @"WIFI";
                break;
            default:
                break;
        }
        NSLog(@"--%s current network status:%@",__FUNCTION__,result);
        //[weakSelf restorePushStream:status];
    }];
}

-(void)YunfanInitiaData{
    //观看直播人员cell
    [self.portraitsCollectionView registerClass:[RCDLivePortraitViewCell class] forCellWithReuseIdentifier:@"portraitcell"];
    
    [self setParameter];
    
}

- (void)setParameter{
    if (self.kbps < 400) {
        self.kbps = 400;
    }
    if (self.fps < 10) {
        self.fps = 10;
    }
    if (!self.isVertical) {
        //横屏直播  旋转90度
        [self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"isVertical"];
    }else{
        [self.view setTransform:CGAffineTransformMakeRotation(0)];
        self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isVertical"];
    }
    self.isPushed = NO;
    
    self.registeredNotifications = [[NSMutableArray alloc] init];
    self.retryPushStreamCount = 5;
    
    self.reachabilityMannger = [AFNetworkReachabilityManager sharedManager];
    [self.reachabilityMannger startMonitoring];
    [self networkReachabilityStatusChange];
    [self setupYfSession];
    [self registerApplicationObservers];
    
    UIPinchGestureRecognizer *ping = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoom:)];
    [self.view addGestureRecognizer:ping];
    
}
- (void)setupYfSession{
    if (!_yfSession) {
        
        if (self.isVertical) {
            NSLog(@"竖屏推流");
            _yfSession = [[YfSession alloc] initWithVideoSize:CGSizeMake(540, 960) sessionPreset:AVCaptureSessionPresetiFrame960x540 frameRate:20 bitrate:400*1000 bufferTime:2 isUseUDP:self.transportStyle isDropFrame:YES YfOutPutImageOrientation:YfOutPutImageOrientationNormal isOnlyAudioPushBuffer:NO audioRecoderError:^(NSString *error, OSStatus status) {
                [self popMessageView:@"打开音频设备失败"];
                
            } isOpenAdaptBitrate:YES];
            
            
        }else{
            NSLog(@"横屏推流");
            _yfSession = [[YfSession alloc] initWithVideoSize:CGSizeMake(960, 540) sessionPreset:AVCaptureSessionPresetiFrame960x540 frameRate:20 bitrate:400*1000 bufferTime:2  isUseUDP:self.transportStyle isDropFrame:YES YfOutPutImageOrientation:YfOutPutImageOrientationLandLeftFullScreen isOnlyAudioPushBuffer:NO audioRecoderError:^(NSString *error, OSStatus status) {
                [self popMessageView:@"打开音频设备失败"];
            } isOpenAdaptBitrate:YES];
            
        }
        
        [self.view insertSubview:_yfSession.previewView atIndex:0];
        
        if (!self.isVertical) {
            //横屏
            __weak typeof(self)weakSelf = self;
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            [_yfSession.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(weakSelf.view);
                make.width.mas_equalTo(screenSize.width);
                make.height.mas_equalTo(screenSize.height);
                
            }];
            
            [_yfSession.previewView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
        }
        XXManager *manager = [XXManager sharedManager];
        // manager.open = YES;
        
        //设置心形手势的bundle文件名
        //        manager.heartName = @"heart_iloveu.bundle";
        _yfSession.delegate = self;
        //人脸检测和手势开始设置为NO，等预览层加载好后，再设为YES
        manager.is_facing_tracking = NO;
        manager.is_heartGesture = NO;
        _yfSession.isHeadPhonesPlay = NO;
        [_yfSession.videoCamera switchBeautyFilter:YfSessionCameraBeautifulFilterLocalSkinBeauty];
        //        [_yfSession setupFilter:YfSessionFilterFishEye];
        //        _yfSession.isBeautify = NO;
        //        _yfSession.isOnlyBeauty = YES;
        //默认为YES
        _yfSession.IsAudioOpen = YES;
        //加载水印logo，切换时仍然调用此方法 退出直播时需调用- (void)releaseImageTexture;释放
        //        NSString *png = [[NSBundle mainBundle] pathForResource:@"shuiyin1" ofType:@"png"];
        //        [_yfSession.videoCamera drawImageTexture:png PointSize:YfSessionCameraLogoPostitionrightUp];
        
    }
}

/**
 *  恢复推流
 *
 *  @param status 网络状态
 */
//e1b0a28155adaf79ac302cc1e097dc634c465879
- (void)restorePushStream:(AFNetworkReachabilityStatus)status{
    if (status == AFNetworkReachabilityStatusNotReachable) {
        NSLog(@"Network error. Please check your network connection.");
        //TODO 通知云帆sdk,当前网络无法连接
        if(self.yfSession && self.urlString){
            [self.yfSession ShutErrorRtmpSession];//立即收到推流错误的回调
            NSLog(@"%s ShutErrorRtmpSession",__FUNCTION__);
        }
    }else{
        NSLog(@"%s rtmpSessionState=%zd",__FUNCTION__ , _rtmpSessionState);
        //上一次推流错误，网络恢复的时候 重新推流
        if (self.urlString && self.yfSession && _rtmpSessionState == YfSessionStateError) {
            NSLog(@"%s 重新推流 startRtmpSessionWithRtmpURL",__FUNCTION__);
            [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
        }
    }
}
/**
 *  重试推流
 */
-(void)retryPushStream{
    self.retryPushStreamCount--;
    if (self.retryPushStreamCount <= 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:NSLocalizedString(@"There seems to be a problem! Kindly check your connection and restart your stream.", nil)
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_yfSession && self.urlString) {
                [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
            }
        });
    }
}
#pragma mark - 云帆推流连接回调通知

- (void)connectionStatusChanged:(YfSessionState) state{
    switch(state) {
        case YfSessionStateNone: {
            _rtmpSessionState = YfSessionStateNone;
            NSLog(@"YfSessionStateNone");
        }
            break;
        case YfSessionStatePreviewStarted: {
            _rtmpSessionState = YfSessionStatePreviewStarted;
            
            [XXManager sharedManager].is_facing_tracking = YES;
            //            _yfSession.is_heartGesture = NO;
            //_yfSession.isHeadPhonesPlay = NO;
            //开始推流
            // [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
            NSLog(@"初始化完成");
        }
            break;
        case YfSessionStateStarting: {
            _rtmpSessionState = YfSessionStateStarting;
            NSLog(@"正在连接流服务器...");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.stateLabel.text = @"正在连接服务器..";
            });
        }
            break;
        case YfSessionStateStarted: {
            _rtmpSessionState = YfSessionStateStarted;
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.stateLabel.text = @"连接成功，推流开始";
            });
            NSLog(@"连接成功，推流开始");
            self.retryPushStreamCount = 5;
        }
            break;
        case YfSessionStateEnded: {
            _rtmpSessionState = YfSessionStateEnded;
        }
            break;
        case YfSessionStateError: {
            _rtmpSessionState = YfSessionStateError;
            NSLog(@"连接流服务器出错");
            if (self.isManualCloseLive) {
                if (_yfSession) {
                    [_yfSession releaseRtmpSession];//停止rtmp session，释放资源，不会触发rtmp session结束通知
                    NSLog(@"%s releaseRtmpSession",__FUNCTION__);
                }
            }else{
                if (self.yfSession && self.urlString) {
                    [self.yfSession shutdownRtmpSession]; //停止rtmp session，不释放资源
                    NSLog(@"%s shutdownRtmpSession",__FUNCTION__);
                }
            }
            if (self.reachabilityMannger.networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable && !self.isManualCloseLive) {
                NSLog(@"%s 继续重试推流 retryPushStream...",__FUNCTION__);
                //                [self retryPushStream];//继续重试推流（5次机会）
            }
        }
            break;
        default:
            break;
    }
}
- (void)popMessageView:(NSString *)meg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:meg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    // Add the actions.
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)unregisterApplicationObservers
{
    for (NSString *name in self.registeredNotifications) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:name
                                                      object:nil];
    }
}
- (void)registerApplicationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [self.registeredNotifications addObject:UIApplicationWillEnterForegroundNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [self.registeredNotifications addObject:UIApplicationDidBecomeActiveNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [self.registeredNotifications addObject:UIApplicationWillResignActiveNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [self.registeredNotifications addObject:UIApplicationDidEnterBackgroundNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    [self.registeredNotifications addObject:UIApplicationWillTerminateNotification];
}
- (void)applicationDidEnterBackground{
    NSLog(@"%s",__func__);
    self.isManualCloseLive = YES;
    //    [self.timer invalidate];
    //    self.timer = nil;
    [self.yfSession shutdownRtmpSession];
}

- (void)applicationWillTerminate{
    NSLog(@"%s",__func__);
}
- (void)applicationDidBecomeActive
{
    NSLog(@"%s",__func__);
    
}

- (void)applicationWillResignActive{
    NSLog(@"%s",__func__);
}
- (void)applicationWillEnterForeground
{
    self.isManualCloseLive = NO;
    //[self gainDisplayLink];
    [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
    
    NSLog(@"%s",__func__);
    
    
}
-(void)dealloc{
    
    [self unregisterApplicationObservers];
    [self.reachabilityMannger stopMonitoring];
    
}
- (void)switchCameraState:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
        self.yfSession.cameraState = YfCameraStateFront;
    }else{
        sender.selected = YES;
        self.yfSession.cameraState = YfCameraStateBack;
    }
}

//退出
- (void)exitLive:(UIButton *)sender{
    [self liveStatus];
    [self.navigationController popViewControllerAnimated:YES];

    
}
//切换直播状态
-(void)liveStatus{
    //切换直播状态
    NSDictionary *dic = @{@"status":@"OFFLINE",@"fansCount":@"10"};
    //切换直播状态到成功
    [NYNNetTool SwitchStatusWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"开启成功");
    } failure:^(NSError *failure) {
        NSLog(@"");
        
    }];
    
    
    //移除logo
    //    [self.timer invalidate];
    //    self.timer = nil;
    [self.yfSession.videoCamera removeLogo];
    [self.yfSession shutdownRtmpSession];
    [self.yfSession releaseRtmpSession];
    self.yfSession = nil;
    
}



- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-40, 15, 25, 25)];
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"fork-@2x"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (UIButton *)switchCamera{
    if (!_switchCamera) {
        _switchCamera = [[UIButton alloc] init];
        [_switchCamera setBackgroundImage:[UIImage imageNamed:@"camera1"] forState:UIControlStateNormal];
        [_switchCamera setBackgroundImage:[UIImage imageNamed:@"camera2"] forState:UIControlStateSelected];
        [_switchCamera addTarget:self action:@selector(switchCameraState:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_switchCamera];
    }
    return _switchCamera;
}
/********************视频结束*************************************************************************/
/**
 *  加入聊天室失败的提示
 *
 *  @param title 提示内容
 */
- (void)loadErrorAlert:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)rcinit {
    
    self.conversationDataRepository = [[NSMutableArray alloc] init];
    //        [[RCIMClient sharedRCIMClient]setRCConnectionStatusChangeDelegate:self];
    self.conversationMessageCollectionView = nil;
    self.userList = [[NSMutableArray alloc] init];
    
}

//创建直播间
-(void)creatLiveRoom{
    
    if (_textField.text == nil) {
        return;
    }
    //创建直播间http://192.168.9.200/l//live/create
    //@"pimg":@""_textField.text
    NSDictionary * ns =[[NSDictionary alloc]init];
    
    if (imageString ==nil ) {
         ns  = @{@"title":_textField.text,@"type":@"live",@"farmId":self.farmId};
    }else{
        ns = @{@"title":_textField.text,@"type":@"live",@"farmId":self.farmId,@"pimg":imageString};
    }
   
    [NYNNetTool CreateLivePushWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        self.preview.hidden = YES;
        self.textField.hidden = YES;
        self.headImageView.hidden = YES;
        self.modelBtn1.hidden=YES;
        self.beautyBtn1.hidden = YES;
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            //切换直播状态
            NSDictionary *dic = @{@"status":@"ONLINE",@"fansCount":@"0"};
            //切换直播状态到成功
            [NYNNetTool SwitchStatusWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                NSLog(@"开启成功");
            } failure:^(NSError *failure) {
                NSLog(@"");
                
            }];
            NYNPushStreamModel *model = [NYNPushStreamModel mj_objectWithKeyValues:success[@"data"]];
            _conversationType = ConversationType_CHATROOM;
            _targetId = model.ID;
            _liveID = model.ID;
            _urlString = model.rtmpPush;
            [self startLiveRoomData];
            //获取直播间信息
            [self getLiveInfoData];
            timer = [NSTimer scheduledTimerWithTimeInterval:20 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [self getLiveInfoData];
            }];
            [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
            
            //初始化主播信息
            [self initChatroomMemberInfo];
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            [self showLoadingView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            //跳转到首页
            self.tabBarController.selectedIndex = 0;
            [self hideLoadingView];

        }
    } failure:^(NSError *failure){
        
        
    }];
}
#pragma mark---接受连麦申请

-(void)accetepLianMai:(NSString*)string{
    NSDictionary * ns = @{@"token":userInfoModel.token,@"fromUserId":string};
    [NYNNetTool AcceptLianmaiWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            NSArray * liuArray=success[@"data"];
            NYNTextMessage * textMessege = [[NYNTextMessage alloc]init];
            //type为2表示同意连麦
            textMessege.type =2;
            textMessege.targetId= _targetId;
            textMessege.content = [liuArray componentsJoinedByString:@","];
            textMessege.time =[NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
            //主播端接收连麦请求后把流地址发送给用户端
            [[RCIMClient sharedRCIMClient]sendMessage:ConversationType_PRIVATE targetId:string content:textMessege pushContent:nil pushData:nil success:^(long messageId) {
                NSLog(@"发送成功。当前消息ID：%ld", messageId);
            } error:^(RCErrorCode nErrorCode, long messageId) {
                NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
            }];
            
            
        }
        
        
    } failure:^(NSError *failure){
        NSLog(@"%@",failure);
        
        
    }];
}



/**
 *  注册监听Notification
 */
- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCDLiveKitDispatchMessageNotification
     object:nil];
}

/**
 *  接收到消息的回调
 *
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    __block RCMessage *rcMessage = notification.object;
    RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
    NSDictionary *leftDic = notification.userInfo;
    if (leftDic && [leftDic[@"left"] isEqual:@(0)]) {
        self.isNeedScrollToButtom = YES;
    }
    
    if (![rcMessage.content isKindOfClass:[NYNTextMessage class]]) {
        if (model.conversationType == self.conversationType &&
            [model.targetId isEqual:self.targetId]) {
            __weak typeof(&*self) __blockSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (rcMessage) {
                    [__blockSelf appendAndDisplayMessage:rcMessage];
                    UIMenuController *menu = [UIMenuController sharedMenuController];
                    menu.menuVisible=NO;
                    //如果消息不在最底部，收到消息之后不滚动到底部，加到列表中只记录未读数
                    if (![self isAtTheBottomOfTableView]) {
                        self.unreadNewMsgCount ++ ;
                        [self updateUnreadMsgCountLabel];
                    }
                }
            });
        }
    }
    //发送收到礼物的通知
    if ([rcMessage.content isKindOfClass:[NYNLiveGiftMessege class]]) {
        if([NSThread isMainThread]){
            //发送礼物
            // IM 消息
            GSPChatMessage *msg = [[GSPChatMessage alloc] init];
            //    msg.text = @"1个【鲜花】";
            // 模拟 n 个人在送礼物
            //    int x = arc4random() % 9;
            //    msg.senderChatID = [NSString stringWithFormat:@"%d",x];
            msg.senderName = rcMessage.content.senderUserInfo.name;
            
            // 礼物模型
            GiftModel *giftModel = [[GiftModel alloc] init];
            giftModel.headImage = rcMessage.content.senderUserInfo.portraitUri;
            giftModel.name = msg.senderName;
            //    [giftModel.giftImage sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
            
            giftModel.giftImage = [(NYNLiveGiftMessege*)rcMessage.content content];
            giftModel.giftName = [NSString stringWithFormat:@"%d个",[(NYNLiveGiftMessege*)rcMessage.content count]] ;
            giftModel.giftCount = 1;
            
            AnimOperationManager *manager = [AnimOperationManager sharedManager];
            manager.parentView = self.view;
            msg.senderChatID =[NSString stringWithFormat:@"%d",[(NYNLiveGiftMessege*)rcMessage.content ID]]  ;
            // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
            [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //发送礼物
                // IM 消息
                GSPChatMessage *msg = [[GSPChatMessage alloc] init];
                //    msg.text = @"1个【鲜花】";
                // 模拟 n 个人在送礼物
                //    int x = arc4random() % 9;
                //    msg.senderChatID = [NSString stringWithFormat:@"%d",x];
                msg.senderName = rcMessage.content.senderUserInfo.name;
                
                // 礼物模型
                GiftModel *giftModel = [[GiftModel alloc] init];
                giftModel.headImage = rcMessage.content.senderUserInfo.portraitUri;
                giftModel.name = msg.senderName;
                //    [giftModel.giftImage sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
                
                giftModel.giftImage = [(NYNLiveGiftMessege*)rcMessage.content content];
                giftModel.giftName = msg.text;
                giftModel.giftCount = 1;
                
                AnimOperationManager *manager = [AnimOperationManager sharedManager];
                manager.parentView = self.view;
                msg.senderChatID =[NSString stringWithFormat:@"%d",[(NYNLiveGiftMessege*)rcMessage.content ID]]  ;
                // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
                [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                    
                }];
                
            });
        }
    }
    //    if([NSThread isMainThread]){
    //       [self sendReceivedDanmaku:rcMessage.content];
    //    }else {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self sendReceivedDanmaku:rcMessage.content];
    //        });
    //    }
    //判断是否显示弹幕
    if ([rcMessage.content isKindOfClass:[NYNMessageContent class]]) {
        //弹幕显示
        if ([(NYNMessageContent*)rcMessage.content isDanmu] ==YES ) {
            if([NSThread isMainThread]){
                
                [self picuRL:rcMessage.content.senderUserInfo.portraitUri msg:[(NYNMessageContent*)rcMessage.content msg]];
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self picuRL:rcMessage.content.senderUserInfo.portraitUri msg:[(NYNMessageContent*)rcMessage.content msg]];
                });
            }
        }
    }
    //连麦消息接收
    if ([rcMessage.content isKindOfClass:[NYNTextMessage class]]) {
        if ([(NYNTextMessage*)rcMessage.content type] == 1) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户请求连麦" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //调用接受连麦请求接口
                [self accetepLianMai:rcMessage.content.senderUserInfo.userId];
                
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if ([(NYNTextMessage*)rcMessage.content type] == 3){
            //观众端同意连麦后接受连麦
            if([NSThread isMainThread]){
                self.guanzhongView.hidden = NO;
                
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.guanzhongView.hidden = NO;
                    
                });
            }
            
            
            [self.guanzhongView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-20);
                make.width.mas_offset(100);
                make.height.mas_offset(130);
                make.bottom.mas_offset(JZHEIGHT(-90));
                
            }];
            
            NSString * playURL = [(NYNTextMessage*)rcMessage.content content];
            _playerOne = [[YfFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:playURL] withOptions:NULL useDns:NO useSoftDecode:NO DNSIpCallBack:NULL appID:"" refer:"" bufferTime:3 display:YES isOpenSoundTouch:YES];
            _playerOne.delegate = self;
            _playerOne.shouldAutoplay = YES;
            _playerOne.view.frame = _guanzhongView.frame;
            [_guanzhongView addSubview:_playerOne.view];
            _playerOne.overalState = YfPLAYER_OVERAL_NORMAL;
            _playerOne.scalingMode = YfMPMovieScalingModeAspectFit;
            [self.guanzhongView addSubview:_playerOne.view];
            _playerOne.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_playerOne prepareToPlay];
            [_playerOne play];
        }
        
    }
    
}


//弹幕头像显示富文本
-(void)picuRL:(NSString*)picUrl msg:(NSString*)msg{
    
    NSURL *url = [NSURL URLWithString: picUrl];// 获取的图片地址
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片

    
 
         UIImage * img =   [image roundedCornerImageWithCornerRadius:image.size.width/2];
        //生成文本附件
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = img;
        //    attch.image = [UIImage imageNamed:@"占位图"];
        attch.bounds = CGRectMake(0, 0, 30, 30);
        
        // 创建带有图片的富文本
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:imageStr];
        NSString *localizedMessage =msg;
        
        NSString *str =[NSString stringWithFormat:@"%@",localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
        //拼接字符串
        [string appendAttributedString:attributedString];
        [self sendCenterDanmakuWithAttributedString:string];
   
    
}


//连麦消息接收
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object{
    
    
    
}


- (void)sendReceivedDanmaku:(RCMessageContent *)messageContent {
    if([messageContent isMemberOfClass:[RCInformationNotificationMessage class]]){
        RCInformationNotificationMessage *msg = (RCInformationNotificationMessage *)messageContent;
        //        [self sendDanmaku:msg.message];
        [self sendCenterDanmaku:msg.message];
        [self picuRL:msg.senderUserInfo.portraitUri msg:msg.message];
        
    }else if ([messageContent isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *msg = (RCTextMessage *)messageContent;
        //        [self sendDanmaku:msg.content];
        [self picuRL:msg.senderUserInfo.portraitUri msg:msg.content];
    }else if([messageContent isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *msg = (RCDLiveGiftMessage *)messageContent;
        NSString *tip = [msg.type isEqualToString:@"0"]?@"送了一个钻戒":@"为主播点了赞";
        NSString *text = [NSString stringWithFormat:@"%@ %@",msg.senderUserInfo.name,tip];
        //        [self sendDanmaku:text];
        
        [self picuRL:msg.senderUserInfo.portraitUri msg:text];
        
    }
}
/**
 *  未读消息View
 *
 */
- (UIView *)unreadButtonView {
    if (!_unreadButtonView) {
        _unreadButtonView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, self.view.frame.size.height - MinHeight_InputView - 30, 80, 30)];
        _unreadButtonView.userInteractionEnabled = YES;
        _unreadButtonView.backgroundColor = RCDLive_HEXCOLOR(0xffffff);
        _unreadButtonView.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabUnreadMsgCountIcon:)];
        [_unreadButtonView addGestureRecognizer:tap];
        _unreadButtonView.hidden = YES;
        [self.view addSubview:_unreadButtonView];
        _unreadButtonView.layer.cornerRadius = 4;
    }
    return _unreadButtonView;
}
/**
 *  点击未读提醒滚动到底部
 *
 *  @param gesture gesture description
 */
- (void)tabUnreadMsgCountIcon:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self scrollToBottomAnimated:YES];
    }
}
/**
 *  更新底部新消息提示显示状态
 */
- (void)updateUnreadMsgCountLabel{
    if (self.unreadNewMsgCount == 0) {
        self.unreadButtonView.hidden = YES;
    }
    else{
        self.unreadButtonView.hidden = NO;
        self.unReadNewMessageLabel.text = @"底部有新消息";
    }
}
/**
 *  底部新消息文字
 *
 *  @return return value description
 */
- (UILabel *)unReadNewMessageLabel {
    if (!_unReadNewMessageLabel) {
        _unReadNewMessageLabel = [[UILabel alloc]initWithFrame:_unreadButtonView.bounds];
        _unReadNewMessageLabel.backgroundColor = [UIColor clearColor];
        _unReadNewMessageLabel.font = [UIFont systemFontOfSize:12.0f];
        _unReadNewMessageLabel.textAlignment = NSTextAlignmentCenter;
        _unReadNewMessageLabel.textColor = RCDLive_HEXCOLOR(0xff4e00);
        [self.unreadButtonView addSubview:_unReadNewMessageLabel];
    }
    return _unReadNewMessageLabel;
    
}



/**
 *  将消息加入本地数组
 *
 */
- (void)appendAndDisplayMessage:(RCMessage *)rcMessage {
    if (!rcMessage) {
        return;
    }
    RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
    if([rcMessage.content isMemberOfClass:[RCDLiveGiftMessage class]]){
        model.messageId = -1;
    }
    if([rcMessage.content isMemberOfClass:[NYNLiveGiftMessege class]]){
        model.messageId = -1;
    }
    if ([self appendMessageModel:model]) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForItem:self.conversationDataRepository.count - 1
                            inSection:0];
        if ([self.conversationMessageCollectionView numberOfItemsInSection:0] !=
            self.conversationDataRepository.count - 1) {
            return;
        }
        
        [self.conversationMessageCollectionView
         insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        if ([self isAtTheBottomOfTableView] || self.isNeedScrollToButtom) {
            [self scrollToBottomAnimated:YES];
            self.isNeedScrollToButtom=NO;
        }
    }
}
/**
 *  如果当前会话没有这个消息id，把消息加入本地数组
 *
 */
- (BOOL)appendMessageModel:(RCDLiveMessageModel *)model {
    long newId = model.messageId;
    for (RCDLiveMessageModel *__item in self.conversationDataRepository) {
        /*
         * 当id为－1时，不检查是否重复，直接插入
         * 该场景用于插入临时提示。
         */
        if (newId == -1) {
            break;
        }
        if (newId == __item.messageId) {
            return NO;
        }
    }
    if (!model.content) {
        return NO;
    }
    //这里可以根据消息类型来决定是否显示，如果不希望显示直接return NO
    
    //数量不可能无限制的大，这里限制收到消息过多时，就对显示消息数量进行限制。
    //用户可以手动下拉更多消息，查看更多历史消息。
    if (self.conversationDataRepository.count>100) {
        //                NSRange range = NSMakeRange(0, 1);
        RCDLiveMessageModel *message = self.conversationDataRepository[0];
        [[RCIMClient sharedRCIMClient]deleteMessages:@[@(message.messageId)]];
        [self.conversationDataRepository removeObjectAtIndex:0];
        [self.conversationMessageCollectionView reloadData];
    }
    
    [self.conversationDataRepository addObject:model];
    return YES;
}

/**
 *  找出消息的位置
 *
 */
- (NSInteger)findDataIndexFromMessageList:(RCDLiveMessageModel *)model {
    NSInteger index = 0;
    for (int i = 0; i < self.conversationDataRepository.count; i++) {
        RCDLiveMessageModel *msg = (self.conversationDataRepository)[i];
        if (msg.messageId == model.messageId) {
            index = i;
            break;
        }
    }
    return index;
}

/**
 *  判断消息是否在collectionView的底部
 *
 *  @return 是否在底部
 */
- (BOOL)isAtTheBottomOfTableView {
    if (self.conversationMessageCollectionView.contentSize.height <= self.conversationMessageCollectionView.frame.size.height) {
        return YES;
    }
    if(self.conversationMessageCollectionView.contentOffset.y +200 >= (self.conversationMessageCollectionView.contentSize.height - self.conversationMessageCollectionView.frame.size.height)) {
        return YES;
    }else{
        return NO;
    }
}
/**
 *  消息滚动到底部
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToBottomAnimated:(BOOL)animated {
    if ([self.conversationMessageCollectionView numberOfSections] == 0) {
        return;
    }
    NSUInteger finalRow = MAX(0, [self.conversationMessageCollectionView numberOfItemsInSection:0] - 1);
    if (0 == finalRow) {
        return;
    }
    NSIndexPath *finalIndexPath =
    [NSIndexPath indexPathForItem:finalRow inSection:0];
    [self.conversationMessageCollectionView scrollToItemAtIndexPath:finalIndexPath
                                                   atScrollPosition:UICollectionViewScrollPositionTop
                                                           animated:animated];
}
/**
 *  滚动条滚动时显示正在加载loading
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 是否显示右下未读icon
    if (self.unreadNewMsgCount != 0) {
        [self checkVisiableCell];
    }
    
    if (scrollView.contentOffset.y < -5.0f) {
        //        [self.collectionViewHeader startAnimating];
    } else {
        //        [self.collectionViewHeader stopAnimating];
        //        _isLoading = NO;
    }
}
/**
 *  检查是否更新新消息提醒
 */
- (void) checkVisiableCell{
    NSIndexPath *lastPath = [self getLastIndexPathForVisibleItems];
    if (lastPath.row >= self.conversationDataRepository.count - self.unreadNewMsgCount || lastPath == nil || [self isAtTheBottomOfTableView] ) {
        self.unreadNewMsgCount = 0;
        [self updateUnreadMsgCountLabel];
    }
}
/**
 *  获取显示的最后一条消息的indexPath
 *
 *  @return indexPath
 */
- (NSIndexPath *)getLastIndexPathForVisibleItems
{
    NSArray *visiblePaths = [self.conversationMessageCollectionView indexPathsForVisibleItems];
    if (visiblePaths.count == 0) {
        return nil;
    }else if(visiblePaths.count == 1) {
        return (NSIndexPath *)[visiblePaths firstObject];
    }
    NSArray *sortedIndexPaths = [visiblePaths sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)obj1;
        NSIndexPath *path2 = (NSIndexPath *)obj2;
        return [path1 compare:path2];
    }];
    return (NSIndexPath *)[sortedIndexPaths lastObject];
}
/**
 *  顶部插入历史消息
 *
 *  @param model 消息Model
 */
- (void)pushOldMessageModel:(RCDLiveMessageModel *)model {
    if (!(!model.content && model.messageId > 0)
        && !([[model.content class] persistentFlag] & MessagePersistent_ISPERSISTED)) {
        return;
    }
    long ne_wId = model.messageId;
    for (RCDLiveMessageModel *__item in self.conversationDataRepository) {
        if (ne_wId == __item.messageId) {
            return;
        }
    }
    [self.conversationDataRepository insertObject:model atIndex:0];
}
/**
 *  加载历史消息(暂时没有保存聊天室消息)
 */
- (void)loadMoreHistoryMessage {
    long lastMessageId = -1;
    if (self.conversationDataRepository.count > 0) {
        RCDLiveMessageModel *model = [self.conversationDataRepository objectAtIndex:0];
        lastMessageId = model.messageId;
    }
    
    
    NSArray *__messageArray =
    [[RCIMClient sharedRCIMClient] getHistoryMessages:_conversationType
                                             targetId:_targetId
                                      oldestMessageId:lastMessageId
                                                count:10];
    for (int i = 0; i < __messageArray.count; i++) {
        RCMessage *rcMsg = [__messageArray objectAtIndex:i];
        RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMsg];
        [self pushOldMessageModel:model];
    }
    [self.conversationMessageCollectionView reloadData];
    if (_conversationDataRepository != nil &&
        _conversationDataRepository.count > 0 &&
        [self.conversationMessageCollectionView numberOfItemsInSection:0] >=
        __messageArray.count - 1) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForRow:__messageArray.count - 1 inSection:0];
        [self.conversationMessageCollectionView scrollToItemAtIndexPath:indexPath
                                                       atScrollPosition:UICollectionViewScrollPositionTop
                                                               animated:NO];
    }
}


#pragma mark---连麦
-(void)callBtnClick:(UIButton*)sender{
    _setView.height = YES;
    LianmaiListView * listView = [[LianmaiListView alloc]init];
    [listView getDataWith:_targetId];
    [self.view addSubview:listView];
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(250);
        
    }];
    
    
}

//是否发送弹幕
-(void)catchSwitchDanm:(BOOL)state{
    danmuState = state;
    
}

/**
 *  初始化页面控件
 */
- (void)initializedSubViews {
    _exitBtn.hidden = YES;
    
    //聊天区
    if(self.contentView == nil){
        CGRect contentViewFrame = CGRectMake(0, self.view.bounds.size.height-237-60, self.view.bounds.size.width,237);
        self.contentView.backgroundColor =[UIColor colorWithRed:235 green:235 blue:235 alpha:1] ;
        self.contentView = [[UIView alloc]initWithFrame:contentViewFrame];
        [self.view addSubview:self.contentView];
    }
    //聊天消息区
    if (nil == self.conversationMessageCollectionView) {
        UICollectionViewFlowLayout *customFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        customFlowLayout.minimumLineSpacing = 0;
        customFlowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 0.0f,5.0f, 0.0f);
        customFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGRect _conversationViewFrame = self.contentView.bounds;
        _conversationViewFrame.origin.y = 0;
        _conversationViewFrame.size.height = self.contentView.bounds.size.height - 50;
        _conversationViewFrame.size.width = 240;
        self.conversationMessageCollectionView =
        [[UICollectionView alloc] initWithFrame:_conversationViewFrame
                           collectionViewLayout:customFlowLayout];
        [self.conversationMessageCollectionView
         setBackgroundColor:[UIColor clearColor]];
        self.conversationMessageCollectionView.showsHorizontalScrollIndicator = NO;
        self.conversationMessageCollectionView.alwaysBounceVertical = YES;
        self.conversationMessageCollectionView.dataSource = self;
        self.conversationMessageCollectionView.delegate = self;
        //注册头部视图
        [self.conversationMessageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
        [self.contentView addSubview:self.conversationMessageCollectionView];
        
    }
    //输入区
    if(self.inputBar == nil){
        float inputBarOriginY = self.conversationMessageCollectionView.bounds.size.height +30+20;
        float inputBarOriginX = self.conversationMessageCollectionView.frame.origin.x;
        float inputBarSizeWidth = self.contentView.frame.size.width;
        float inputBarSizeHeight = MinHeight_InputView;
        self.inputBar = [[RCDLiveInputBar alloc]initWithFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
        self.inputBar.delegate = self;
        self.inputBar.backgroundColor = [UIColor clearColor];
        self.inputBar.hidden = YES;
        [self.contentView addSubview:self.inputBar];
        
    }
    
    _resetBottomTapGesture =[[UITapGestureRecognizer alloc]
                             initWithTarget:self
                             action:@selector(tap4ResetDefaultBottomBarStatus:)];
    [_resetBottomTapGesture setDelegate:self];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 35, 72, 25);
    [_backBtn setImage:[UIImage imageNamed:@"fork-@2x.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(leftBarButtonItemPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_offset(40);
        make.width.height.mas_offset(30);
    }];
    //下方背景图
    UIView * boomBackView = [[UIView alloc]init];
    boomBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //    boomBackView.frame = CGRectMake(0, SCREENHEIGHT - 60, SCREENWIDTH, 60);
    [self.view addSubview:boomBackView];
    [boomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(60);
        
    }];
    //设置
    _clapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _clapBtn.frame = CGRectMake(self.view.frame.size.width-45, SCREENHEIGHT - 45, 35, 35);
    [_clapBtn setImage:[UIImage imageNamed:@"Set"] forState:UIControlStateNormal];
    [_clapBtn addTarget:self action:@selector(clapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clapBtn];
    [_clapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
    }];
    
    
    
    //礼物
    _flowerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _flowerBtn.frame = CGRectMake(self.view.frame.size.width-90, SCREENHEIGHT - 45, 35, 35);
    [_flowerBtn setImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];
    [_flowerBtn addTarget:self action:@selector(flowerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_flowerBtn];
    [_flowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-75);
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
    }];
    
    
    //评论
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _commentBtn.frame = CGRectMake(10, SCREENHEIGHT - 45, 35, 35);
    [_commentBtn setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(showInputBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
    }];
    
 
    
    //美颜
//    UIButton * beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    beautyBtn.frame = CGRectMake(CGRectGetMaxX(_commentBtn.frame)+10, SCREENHEIGHT - 45, 35, 35);
//    [beautyBtn setImage:[UIImage imageNamed:@"Microphone"] forState:UIControlStateNormal];
//    [beautyBtn addTarget:self action:@selector(beautyBtnclick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:beautyBtn];
//    [beautyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_commentBtn.mas_right).offset(10);
//        make.width.height.mas_offset(35);
//        make.bottom.mas_offset(0);
//    }];
    
    
    //连麦
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    callBtn.frame =CGRectMake(CGRectGetMaxX(beautyBtn.frame)+10, SCREENHEIGHT-45, 35, 35);
    [callBtn setImage:[UIImage imageNamed:@"Microphone"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callBtn];
    [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(_commentBtn.mas_right).offset(10);
        
    }];
    
    
    //转换摄像头
    _switchCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    [_switchCamera setImage:[UIImage imageNamed:@"switch2"] forState:UIControlStateNormal];
    //    _switchCamera.frame = CGRectMake(CGRectGetMaxX(callBtn.frame)+10, SCREENHEIGHT - 45, 35, 35);
    [_switchCamera addTarget:self action:@selector(switchCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_switchCamera];
    [_switchCamera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(callBtn.mas_right).offset(10);
    }];
    //横竖屏
    UIButton* crossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [crossBtn setImage:[UIImage imageNamed:@"transverse"] forState:UIControlStateNormal];
    [crossBtn addTarget:self action:@selector(crossBtn :) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:crossBtn];
    [crossBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(35);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(_switchCamera.mas_right).offset(10);
    }];
    //禁言列表
    UIButton* stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    stopButton.frame=CGRectMake(CGRectGetMaxX(_shareButton.frame), 40, wight, height);
    [stopButton setImage:[UIImage imageNamed:@"Microphone2"] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    [stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(32);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(crossBtn.mas_right).offset(10);
    }];
    //分享
   UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(32);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(stopButton.mas_right).offset(10);
    }];
    [self registerClass:[RCDLiveTipMessageCell class]forCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier];
    

    
}
//分享
-(void)shareButtonclick:(UIButton*)sender{
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        NSString * str =[NSString stringWithFormat:@"http://help.dawangkeji.com/farm-live/index.html?farmId=%@&liveId=%@",self.farmId,_farmId];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"网农公社直播" descr:nil thumImage:nil];
        
        shareObject.webpageUrl = str;
        
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                    
                }
            }
            
        }];
        
    }];
}

//禁言列表
-(void)stopButtonClick:(UIButton*)sender{
    _setView.hidden = YES;
    
    StopSpeakView * stopView = [[StopSpeakView alloc]init];
    [stopView getDataWith:_targetId];
    [self.view addSubview:stopView];
    [stopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(300);
    }];
}
//横竖屏
-(void)crossBtn:(UIButton*)sender{
    _setView.hidden = YES;
    [self.yfSession.videoCamera removeLogo];
    [self.yfSession shutdownRtmpSession];
    [self.yfSession releaseRtmpSession];
    [self.yfSession.previewView removeFromSuperview];
    self.yfSession = nil;
    self.isVertical = !self.isVertical;//换推流方向
    
    [self YunfanInitiaData];
    //开始推流
    [self.yfSession startRtmpSessionWithRtmpURL:self.urlString];
    
    [self initChatroomMemberInfo];
    [self changeCrossOrVerticalscreen:self.isVertical];
}
//美颜
-(void)beautyBtnclick:(UIButton*)sender{
    
    BeautyView * beautyV = [[BeautyView alloc]init];
    beautyV.delegate = self;
    
    //滤镜
    //    self.yfSession.videoCamera =
    [self.view addSubview:beautyV];
    [beautyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(300);
        
        
    }];
}
//滤镜效果协议
-(void)beautyButtonClick:(NSInteger)tag{
    //@"哈哈镜",@"漩涡 ",@"漫画效果",@"鱼 眼 ",@"浮雕 ",@"晕影",@"水晶球",特效滤镜
    //风格滤镜[_yfsession.videoCamera switchFilter:YFINSTCamera_SIERRA_FILTER];
    
//    switch (tag) {
//        case 300:
//            [self.yfSession.videoCamera  switchFilter:YFINSTCamera_SIERRA_FILTER];
//            break;
//        case 301:
//            [self.yfSession.videoCamera  switchFilter:YFINSTCamera_SIERRA_FILTER];
//            break;
//        case 302:
//            [self.yfSession.videoCamera  setupFilter:YfSessionCameraFilterCartoon];
//            break;
//        case 303:
//            [self.yfSession.videoCamera  setupFilter:YfSessionCameraFilterFishEye];
//            break;
//        case 304:
//            [self.yfSession.videoCamera  setupFilter:YfSessionCameraFilterGlassSphere];
//            break;
//        case 305:
//            [self.yfSession.videoCamera  setupFilter:YfSessionCameraFilterVignette];
//            break;
//        case 306:
//            [self.yfSession.videoCamera  setupFilter:YfSessionCameraFilterCameo];
//            break;
//
//        default:
//            break;
//    }
    
}

//转换摄像头
-(void)switchCamera:(UIButton*)sender{
    if (sender.selected) {
        sender.selected = NO;
        self.yfSession.cameraState = YfCameraStateFront;
    }else{
        sender.selected = YES;
        self.yfSession.cameraState = YfCameraStateBack;
    }
    
}
//设置点击
-(void)clapBtn:(UIButton*)sender{
    
    _setView = [[NYNSetLiveView alloc]init];//WithFrame:CGRectMake(0, SCREENHEIGHT-200, SCREENWIDTH, 200)];
    _setView.delagate = self;
    
    [self.view addSubview:_setView];
    [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(200);
        make.bottom.left.right.mas_offset(0);
    }];
    
    
    __weak typeof(NYNSetLiveView*) weakSelf = _setView;
    _setView.backClick=^(){
        weakSelf.hidden = YES;
        
    };
    
}

/**
 *  发送礼物按钮
 *
 *  @param sender sender description
 */
-(void)flowerButtonPressed:(id)sender{
    
    ReceiveGiftView * receiveV = [[ReceiveGiftView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-200, SCREENWIDTH, 200) liveId:_targetId];
    
    [self.view addSubview:receiveV ];
    
    __weak typeof(ReceiveGiftView*) weakSelf = receiveV;
    receiveV.backClick=^(){
        weakSelf.hidden = YES;
        
    };
    
}

/**
 *  全屏和半屏模式切换
 *
 *  @param isFullScreen 全屏或者半屏
 */
- (void)changeModel:(BOOL)isFullScreen {
    _titleView.hidden = YES;
    
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    CGRect contentViewFrame = CGRectMake(0, self.view.bounds.size.height-237, self.view.bounds.size.width,237);
    self.contentView.frame = contentViewFrame;
    
    //    _topBackView.frame = CGRectMake(10, 30, CGFloat width, <#CGFloat height#>)
    float inputBarOriginY = self.conversationMessageCollectionView.bounds.size.height + 30;
    float inputBarOriginX = self.conversationMessageCollectionView.frame.origin.x;
    float inputBarSizeWidth = self.contentView.frame.size.width;
    float inputBarSizeHeight = MinHeight_InputView;
    //添加输入框
    [self.inputBar changeInputBarFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
    [self.conversationMessageCollectionView reloadData];
    [self.unreadButtonView setFrame:CGRectMake((self.view.frame.size.width - 80)/2, self.view.frame.size.height - MinHeight_InputView - 30, 80, 30)];
}


/**
 *  横竖屏切换
 *
 *  @param isVertical isVertical description
 */
-(void)changeCrossOrVerticalscreen:(BOOL)isVertical{
    float inputBarOriginY = self.conversationMessageCollectionView.bounds.size.height + 30;
    float inputBarOriginX = self.conversationMessageCollectionView.frame.origin.x;
    float inputBarSizeWidth = self.contentView.frame.size.width;
    float inputBarSizeHeight = MinHeight_InputView;
    //添加输入框
    [self.inputBar changeInputBarFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
    for (RCDLiveMessageModel *__item in self.conversationDataRepository) {
        __item.cellSize = CGSizeZero;
    }
    [self changeModel:YES];
    [self.view bringSubviewToFront:self.backBtn];
    [self.inputBar setHidden:YES];
    
    
}


#pragma mark--YfFFMoviePlayerControllerDelegate

#pragma mark === 播放器回调
- (void)playerStatusCallBackBufferingEnd:(YfFFMoviePlayerController *)player {
    NSLog(@"缓冲结束");
}

- (void)playerStatusCallBackBufferingStart:(YfFFMoviePlayerController *)player {
    NSLog(@"缓冲开始");
}

- (void)playerStatusCallBackLoading:(YfFFMoviePlayerController *)player {
    NSLog(@"开始加载");
}

- (void)playerStatusCallBackLoadingSuccess:(YfFFMoviePlayerController *)player {
    NSLog(@"加载成功");
}

- (void)playerStatusCallBackPlayerPlayEnd:(YfFFMoviePlayerController *)player {
    NSLog(@"播放结束");
}



/**
 *  点击返回的时候消耗播放器和退出聊天室
 *
 *  @param sender sender description
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"退出聊天室？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self quitConversationViewAndClear];
        
    }else{
        
    }
}


// 清理环境（退出聊天室并断开融云连接）
- (void)quitConversationViewAndClear {
    if (self.conversationType == ConversationType_CHATROOM) {
        //退出聊天室
        [[RCIMClient sharedRCIMClient] quitChatRoom:self.targetId
                                            success:^{
                                                
                                                [[NSNotificationCenter defaultCenter] removeObserver:self];
                                                
                                                //断开融云连接，如果你退出聊天室后还有融云的其他通讯功能操作，可以不用断开融云连接，否则断开连接后需要重新connectWithToken才能使用融云的功能
                                                //                                                [[RCDLive sharedRCDLive]logoutRongCloud];
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    self.conversationMessageCollectionView.dataSource = nil;
                                                    self.conversationMessageCollectionView.delegate = nil;
                                                });
                                                
                                            } error:^(RCErrorCode status) {
                                                
                                            }];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 *  注册cell
 *
 *  @param cellClass  cell类型
 *  @param identifier cell标示
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.conversationMessageCollectionView registerClass:cellClass
                               forCellWithReuseIdentifier:identifier];
}
-(void)showInputBar:(id)sender{
    //键盘转屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO] ;
    [self keyboard];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
    
    
    
}

/*!
 发送消息(除图片消息外的所有消息)
 
 @param messageContent 消息的内容
 @param pushContent    接收方离线时需要显示的远程推送内容
 
 @discussion 当接收方离线并允许远程推送时，会收到远程推送。
 远程推送中包含两部分内容，一是pushContent，用于显示；二是pushData，用于携带不显示的数据。
 
 SDK内置的消息类型，如果您将pushContent置为nil，会使用默认的推送格式进行远程推送。
 自定义类型的消息，需要您自己设置pushContent来定义推送内容，否则将不会进行远程推送。
 
 如果您需要设置发送的pushData，可以使用RCIM的发送消息接口。
 */
- (void)sendMessage:(RCMessageContent *)messageContent
        pushContent:(NSString *)pushContent {
    if (_targetId == nil) {
        return;
    }
    messageContent.senderUserInfo = [RCDLive sharedRCDLive].currentUserInfo;
    messageContent.senderUserInfo.name = userInfoModel.name;
    messageContent.senderUserInfo.portraitUri = userInfoModel.avatar;
    if (messageContent == nil) {
        return;
    }
    
    [[RCDLive sharedRCDLive] sendMessage:self.conversationType
                                targetId:self.targetId
                                 content:messageContent
                             pushContent:pushContent
                                pushData:nil
                                 success:^(long messageId) {
                                     __weak typeof(&*self) __weakself = self;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         RCMessage *message = [[RCMessage alloc] initWithType:__weakself.conversationType
                                                                                     targetId:__weakself.targetId
                                                                                    direction:MessageDirection_SEND
                                                                                    messageId:messageId
                                                                                      content:messageContent];
                                         //                                         if ([message.content isMemberOfClass:[RCDLiveGiftMessage class]] ) {
                                         //                                             message.messageId = -1;//插入消息时如果id是-1不判断是否存在
                                         //                                         }
                                         [__weakself appendAndDisplayMessage:message];
                                         [__weakself.inputBar clearInputView];
                                     });
                                 } error:^(RCErrorCode nErrorCode, long messageId) {
                                     [[RCIMClient sharedRCIMClient]deleteMessages:@[ @(messageId) ]];
                                 }];
}
/**
 *  计算不同消息的具体尺寸
 *
 */
- (CGSize)sizeForItem:(UICollectionView *)collectionView
          atIndexPath:(NSIndexPath *)indexPath {
    CGFloat __width = CGRectGetWidth(collectionView.frame);
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    CGFloat __height = 0.0f;
    NSString *localizedMessage;
    if ([messageContent isMemberOfClass:[RCInformationNotificationMessage class]]) {
        //        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)messageContent;
        //        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
    }else if ([messageContent isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *notification = (RCTextMessage *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",userInfoModel.name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[NYNMessageContent class]]){
        NYNMessageContent *notification = (NYNMessageContent *)messageContent;
        localizedMessage = notification.msg;
        
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[NYNLiveGiftMessege class]]){
        //        NYNLiveGiftMessege *notification = (NYNLiveGiftMessege *)messageContent;
        
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ 送了一个礼物占位服",name];
    }
    CGSize __labelSize = [RCDLiveTipMessageCell getTipMessageCellSize:localizedMessage];
    __height = __height + __labelSize.height;
    if ([messageContent isMemberOfClass:[NYNLiveGiftMessege class]]) {
        return CGSizeMake(__width+40, __height);
    }
    
    return CGSizeMake(__width, __height);
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([collectionView isEqual:self.conversationMessageCollectionView]) {
        return CGSizeMake(SCREENWIDTH, 50);
    }
    
    return CGSizeZero;
    
    
    
}

#pragma mark <UICollectionViewDataSource>
/**
 *  定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView  numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.portraitsCollectionView]) {
        return self.liveInfoModel.hotFans.count;
    }
    return self.conversationDataRepository.count;
}
/**
 *  每个UICollectionView展示的内容
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.portraitsCollectionView]) {
        RCDLivePortraitViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"portraitcell" forIndexPath:indexPath];
        //        RCUserInfo *user = self.userList[indexPath.row];
        //        NSString *str = user.portraitUri;
        [cell.portaitView sd_setImageWithURL:self.liveInfoModel.hotFans[indexPath.row][@"avatar"] placeholderImage:[UIImage imageNamed:@"占位图"]];
        return cell;
    }
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    
    RCDLiveMessageBaseCell *cell = nil;
    if ([messageContent isMemberOfClass:[NYNMessageContent class]] || [messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]] ||[messageContent isMemberOfClass:[NYNLiveGiftMessege class]]||[messageContent isMemberOfClass:[RCDLiveMessageModel class]]){
        RCDLiveTipMessageCell *__cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier forIndexPath:indexPath];
        __cell.isFullScreenMode = YES;
        [__cell setDataModel:model];
        //        [__cell setDelegate:self];
        cell = __cell;
    }
    
    //    }
    return cell;
}

//collectionview头部视图

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind   atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    if ([collectionView isEqual:self.conversationMessageCollectionView]) {
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 240, 50)];
        NSString * str = [NSString stringWithFormat:@"网农公社：欢迎来到我的直播间，你可以观看直播,还可以尽情选购哟"];
        titleLabel.textColor = [UIColor orangeColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(0, 5)];
        titleLabel.attributedText = string;
        //自动换行
        titleLabel.numberOfLines=0;
        titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [headView addSubview:titleLabel];
    }
    
    return headView;
}




#pragma mark <UICollectionViewDelegateFlowLayout>

/**
 *  cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.portraitsCollectionView]) {
        return CGSizeMake(35,35);
    }
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (model.cellSize.height > 0) {
        return model.cellSize;
    }
    RCMessageContent *messageContent = model.content;
    if ([messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCInformationNotificationMessage class]]|| [messageContent isMemberOfClass:[NYNMessageContent class]] ||[messageContent isMemberOfClass:[NYNLiveGiftMessege class]]) {
        model.cellSize = [self sizeForItem:collectionView atIndexPath:indexPath];
    } else {
        return CGSizeZero;
    }
    return model.cellSize;
}
/**
 *  定义展示的UICollectionViewCell的个数
 *
 */
- (void)tap4ResetDefaultBottomBarStatus:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.inputBar setInputBarStatus:RCDLiveBottomBarDefaultStatus];
        self.inputBar.hidden = YES;
    }
}
- (void)sendDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : kRandomColor}];
    [_danmuView sendDanmaku:danmaku];
    //    [self.view sendDanmaku:danmaku atPoint:<#(CGPoint)#>]
}



- (void)sendCenterDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    //    [self.view sendDanmaku:danmaku atPoint:(CGPoint)]
    
    //    danmaku.position = RCDDanmakuPositionNone;
    [_danmuView sendDanmaku:danmaku];
}


- (void)sendCenterDanmakuWithAttributedString:(NSAttributedString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = text;
    
    //    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    //    [self.view sendDanmaku:danmaku atPoint:(CGPoint)]
    
    //    danmaku.position = RCDDanmakuPositionNone;
    [_danmuView sendDanmaku:danmaku];
}




#pragma mark - 输入框事件
/**
 *  点击键盘回车或
 *
 *  @param text  输入框的内容
 */
- (void)onTouchSendButton:(NSString *)text{
    if (text.length<1) {
        [self showTextProgressView:@"发送内容不能为空"];
        [self.inputBar setHidden:YES];
        [self hideLoadingView];
        return;
        
        
    }

    
    NYNMessageContent * msgcontent = [[NYNMessageContent alloc]init];
    msgcontent.msg = text;
    msgcontent.isDanmu = _inputBar.allowDanMu;
    msgcontent.time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    msgcontent.targetName = self.targetId;
    [self sendMessage:msgcontent pushContent:nil];
    if (danmuState  == NO) {
        msgcontent.isDanmu = NO;
    }else{
        msgcontent.isDanmu = YES;
        //弹幕发送
        //[self sendDanmaku:msgcontent.msg];
        [self picuRL:[NSString stringWithFormat:@"%@",userInfoModel.avatar]msg:msgcontent.msg];
    }
    
    
    [self.inputBar setHidden:YES];
}


#pragma mark RCInputBarControlDelegate

/**
 *  根据inputBar 回调来修改页面布局，inputBar frame 变化会触发这个方法
 *
 *  @param frame    输入框即将占用的大小
 *  @param duration 时间
 */
- (void)onInputBarControlContentSizeChanged:(CGRect)frame withAnimationDuration:(CGFloat)duration andAnimationCurve:(UIViewAnimationCurve)curve{
    CGRect collectionViewRect = self.contentView.frame;
    self.contentView.backgroundColor = [UIColor clearColor];
    collectionViewRect.origin.y = self.view.bounds.size.height - frame.size.height - 237 +50;
    
    collectionViewRect.size.height = 237;
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        [self.contentView setFrame:collectionViewRect];
        [UIView commitAnimations];
    }];
    CGRect inputbarRect = self.inputBar.frame;
    
    inputbarRect.origin.y = self.contentView.frame.size.height -50;
    [self.inputBar setFrame:inputbarRect];
    [self.view bringSubviewToFront:self.inputBar];
    [self scrollToBottomAnimated:NO];
}
//
#pragma MARK--主播间上方显示UI
-(void)initChatroomMemberInfo{
    [self.view addSubview:self.topBackView];
    //主播头像
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.liveInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [_topBackView addSubview:self.imageView];
    
    
    //主播姓名
    _chatroomlabel.text =self.liveInfoModel.userName;
    [_topBackView addSubview:self.chatroomlabel];
    
    //房间号
    _roomlabel.text = [NSString stringWithFormat:@"房间号:%d",self.liveInfoModel.farmId];
    [_topBackView addSubview:self.roomlabel];
    
    //人气
    _renqiLabel.text = [NSString stringWithFormat:@"人气：%d",self.liveInfoModel.popurlar];
    [self.view addSubview:self.renqiLabel];
    //人数
   
    
    _peopleLabel.text = [NSString stringWithFormat:@"人数：%d", [self.liveInfoModel.currentMember intValue] ];
    [self.view addSubview:self.peopleLabel];
    
    if (self.isVertical== NO) {
        [_renqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topBackView.mas_right).offset(5);
            make.width.mas_offset(100);
            make.height.mas_offset(30);
            make.top.mas_offset(15);
        }];
        [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topBackView.mas_right).offset(5);
            make.width.mas_offset(100);
            make.height.mas_offset(30);
            make.top.equalTo(_renqiLabel.mas_bottom).offset(5);
        }];
    }
    
    
    
    if (self.portraitsCollectionView) {
        [_portraitsCollectionView reloadData];
        return;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 16;
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat memberHeadListViewY = _topBackView.frame.origin.x + _topBackView.frame.size.width;
    self.portraitsCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(memberHeadListViewY,30,self.view.frame.size.width - memberHeadListViewY-50,35) collectionViewLayout:layout];
    self.portraitsCollectionView.delegate = self;
    self.portraitsCollectionView.dataSource = self;
    self.portraitsCollectionView.backgroundColor = [UIColor clearColor];
    [self.portraitsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.portraitsCollectionView];
    
    _danmuView  = [[UIView alloc]init];
    
    //    _danmuView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_danmuView];
    [_danmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.conversationMessageCollectionView.mas_top).offset(-10);
        make.top.equalTo(_peopleLabel.mas_bottom).offset(5);
    }];
    
    _sendDanmuImage = [[UIImageView alloc]init];
    [_danmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.conversationMessageCollectionView.mas_top).offset(-10);
        make.top.equalTo(_peopleLabel.mas_bottom).offset(5);
    }];
    
    
    
}
/*************************封面头像选择****************************************/
-(void)setHeadImageSelect{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 80, 80)];
    _headImageView.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2-50-10);
    _headImageView.image = [UIImage imageNamed:@"占位图"];
    _headImageView.userInteractionEnabled = YES;
    UILabel * imgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 80, 30)];
    imgeLabel.text =@"编辑封面";
    imgeLabel.textColor = [UIColor whiteColor];
    imgeLabel.font = [UIFont systemFontOfSize:14];
    imgeLabel.textAlignment = NSTextAlignmentCenter;
    UIColor * color= [UIColor blackColor];
    imgeLabel.backgroundColor = [color colorWithAlphaComponent:0.5];
    [self.view addSubview:_headImageView];
    [_headImageView addSubview:imgeLabel];
    UITapGestureRecognizer * headimageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageTap:)];
    [_headImageView addGestureRecognizer:headimageTap];
    
    
     _beautyBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _beautyBtn1.frame=CGRectMake(0,0, JZWITH(70), JZHEIGHT(90));
    _beautyBtn1.center = CGPointMake(SCREENWIDTH/2-70, CGRectGetMaxY(_textField.frame)+15);
    [_beautyBtn1 setImage:[UIImage imageNamed:@"beautiful"] forState:UIControlStateNormal];
    _beautyBtn1.imageEdgeInsets = UIEdgeInsetsMake(0,10,10,_beautyBtn1.titleLabel.bounds.size.width);
    [_beautyBtn1 setTitle:@"美颜" forState:UIControlStateNormal];
    _beautyBtn1.titleLabel.font=[UIFont systemFontOfSize:16];
    _beautyBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_beautyBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _beautyBtn1.titleEdgeInsets = UIEdgeInsetsMake(71, -_beautyBtn1.titleLabel.bounds.size.width-50, 0, 0);
    [_beautyBtn1 addTarget:self action:@selector(beautyBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beautyBtn1];
    
    _modelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _modelBtn1.frame=CGRectMake(0,0, JZWITH(70), JZHEIGHT(90));
    _modelBtn1.center = CGPointMake(SCREENWIDTH/2+70, CGRectGetMaxY(_textField.frame)+15);
    [_modelBtn1 setImage:[UIImage imageNamed:@"Pattern"] forState:UIControlStateNormal];
    _modelBtn1.imageEdgeInsets = UIEdgeInsetsMake(0,10,10,_modelBtn1.titleLabel.bounds.size.width);
    [_modelBtn1 setTitle:@"直播模式" forState:UIControlStateNormal];
    _modelBtn1.titleLabel.font=[UIFont systemFontOfSize:16];
    _modelBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_modelBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _modelBtn1.titleEdgeInsets = UIEdgeInsetsMake(71, -_modelBtn1.titleLabel.bounds.size.width-50, 0, 0);
//    [_modelBtn1 addTarget:self action:@selector(modelBtn1click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modelBtn1];
    
    
}

//头像点击手势
-(void)headImageTap:(UITapGestureRecognizer*)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    [self.actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    }
    else {
        if (buttonIndex == 2) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    goPickerImage = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
        
        
        
    }];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        goPickerImage = NO;
        UIImage *image;
        if (picker.allowsEditing) {
            image = info[UIImagePickerControllerEditedImage];
        } else {
            image = info[UIImagePickerControllerOriginalImage];
        }
        
        _headImageView.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        imageString =encodedImageStr;
        
        [NYNNetTool PostImageWithparams:@{@"folder":@"avatar"} andFile:data isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                JZLog(@"");
                imageString =success[@"data"];
              
                
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
            
        }];
        
    }];
}




-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        goPickerImage = NO;
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
    
}
-(PreviewView *)preview{
    if (!_preview) {
        _preview = [[PreviewView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-120, SCREENWIDTH, 120)];
    }
    return _preview;
    
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 70)];
        _textField.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
        _textField.placeholder= @"输入直播名称";
        _textField.textColor=[UIColor whiteColor];
        _textField.textAlignment=NSTextAlignmentCenter;
        
        
    }
    return _textField;
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(4, 5, 38, 38)];
        _imageView.layer.cornerRadius = 38/2;
        _imageView.layer.masksToBounds = YES;
        
    }
    return _imageView;
    
}

-(UILabel *)chatroomlabel{
    if (!_chatroomlabel) {
        _chatroomlabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 25)];
        _chatroomlabel.font = [UIFont systemFontOfSize:15.f];
        _chatroomlabel.textColor = [UIColor whiteColor];
    }
    return _chatroomlabel;
    
}
-(UILabel *)roomlabel{
    if (!_roomlabel) {
        _roomlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, CGRectGetMaxY(_chatroomlabel.frame), 80, 20)];
        _roomlabel.textColor = [UIColor whiteColor];
        _roomlabel.font = [UIFont systemFontOfSize:13];
    }
    return _roomlabel;
}

-(UILabel *)renqiLabel{
    if (!_renqiLabel) {
        _renqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_topBackView.frame)+10, 100, 30)];
        _renqiLabel.textColor = [UIColor whiteColor];
        _renqiLabel.textAlignment = NSTextAlignmentCenter;
        _renqiLabel.backgroundColor = [UIColor colorWithRed:0/250 green:0/250 blue:0/250 alpha:0.2];
        _renqiLabel.font=[UIFont systemFontOfSize:14];
        _renqiLabel.layer.cornerRadius=15;
        _renqiLabel.clipsToBounds = YES;
    }
    return _renqiLabel;
    
}

-(UIView *)topBackView{
    if (!_topBackView) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 150, 50)];
        UIColor * color = [UIColor blackColor];
        _topBackView.backgroundColor =[color colorWithAlphaComponent:0.2];
        _topBackView.layer.cornerRadius=50/2;
        _topBackView.clipsToBounds = YES;
    }
    return _topBackView;
    
}

-(UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_renqiLabel.frame)+5, 100, 30)];
        _peopleLabel.textColor = [UIColor whiteColor];
        _peopleLabel.backgroundColor = [UIColor colorWithRed:0/250 green:0/250 blue:0/250 alpha:0.2];
        _peopleLabel.font = [UIFont systemFontOfSize:14];
        _peopleLabel.layer.cornerRadius=15;
        _peopleLabel.clipsToBounds = YES;
        _peopleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _peopleLabel;
    
}
-(UIView *)guanzhongView{
    if (!_guanzhongView) {
        _guanzhongView = [[UIView alloc]init];
        _guanzhongView.backgroundColor = [UIColor redColor];
        _guanzhongView.hidden = YES;
        
        
    }
    return _guanzhongView;
    
}
@end

