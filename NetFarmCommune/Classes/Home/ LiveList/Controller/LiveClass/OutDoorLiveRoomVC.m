//
//  OutDoorLiveRoomVC.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "OutDoorLiveRoomVC.h"
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

//云帆推流头文件
#import "NYNPushStreamModel.h"
#import <CoreTelephony/CTCall.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

#import "NYNNetTool.h"
#import "NYNLiveInfoModel.h"
#import "ReceiveGiftView.h"
#import "NYNSetLiveView.h"
#import "UIImageView+WebCache.h"

#import "YFMediaPlayer/YFMediaPlayer.h"

#import "UIView+RCDDanmaku.h"
#import "RCDDanmaku.h"
#import "RCDDanmakuManager.h"
#import "LiveMessegeBoomVIew.h"

#import "SendGiftView.h"
#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
//输入框的高度
#define MinHeight_InputView 50.0f
#define kBounds [UIScreen mainScreen].bounds.size

@interface OutDoorLiveRoomVC ()<RCConnectionStatusChangeDelegate,RCTKInputBarControlDelegate,YfFFMoviePlayerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,SendGiftClickDelagate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
     SendGiftView * giftView;
    NSString * _giftName;
    
}

//UI
@property (nonatomic, strong) UIButton *exitBtn;
@property (strong,nonatomic) NSTimer *timer;//时间
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


@property(atomic, retain) id<YfMediaPlayback> player;
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
 *  点赞按钮
 */
@property(nonatomic,strong)UIButton *clapBtn;

/**
 *  礼物按钮
 */
@property(nonatomic,strong)UIButton *flowerBtn;
/**
 *  人数
 */
@property(nonatomic,strong)UIButton *numberBtn;
/**
 *  关注
 */
@property(nonatomic,strong)UIButton *attentionBtn;



//观看人员头像显示
@property(nonatomic,strong)UICollectionView *portraitsCollectionView;

@property(nonatomic,strong)NSMutableArray *userList;

@property(nonatomic,strong)LiveMessegeBoomVIew * liveView;//界面下方显示


@property(nonatomic,strong) UIActionSheet *actionSheet;;
@end
/**
 *  文本cell标示
 */
static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";

/**
 *  小灰条提示cell标示
 */
static NSString *const RCDLiveTipMessageCellIndentifier = @"RCDLiveTipMessageCellIndentifier";

@implementation OutDoorLiveRoomVC

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
- (void)rcinit {
    
    self.conversationDataRepository = [[NSMutableArray alloc] init];
    [[RCIMClient sharedRCIMClient]setRCConnectionStatusChangeDelegate:self];
    self.conversationMessageCollectionView = nil;
    self.userList = [[NSMutableArray alloc] init];
    
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
      [self.view stopDanmaku];
    
    
}

#pragma mark------发送弹幕
- (void)sendDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : kRandomColor}];
    [self.view sendDanmaku:danmaku];
}

- (void)sendCenterDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    danmaku.position = RCDDanmakuPositionCenterTop;
    [self.view sendDanmaku:danmaku];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.view addGestureRecognizer:_resetBottomTapGesture];
    [self.conversationMessageCollectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [self startLiveRoomData];
    //聊天区U
    [self initializedSubViews];
    
    
    
    NSString * str = @"rtmp://rtmp.nongyinong.cn/live/3";
    self.player = [[YfFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_playUrl] withOptions:NULL useDns:NO useSoftDecode:NO DNSIpCallBack:NULL appID:"" refer:"" bufferTime:3 display:YES isOpenSoundTouch:YES];
    self.player.shouldAutoplay = YES;
    self.player.overalState = YfPLAYER_OVERAL_NORMAL;
    self.player.delegate = self;
    self.player.view.frame = CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT);
    
    self.player.scalingMode = YfMPMovieScalingModeAspectFit;
    
    [backView addSubview:self.player.view];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.player prepareToPlay];
    [self.player play];
    //ui
    [self initChatroomMemberInfo];
    
    [self.view addSubview:self.liveView];
    __weak typeof(OutDoorLiveRoomVC*) weakSelf = self;
    //礼物按钮
    self.liveView.liftClick =^(){
        [weakSelf initSendGift];
        
    };
    
    //点赞按钮
    self.liveView.zanClick=^(){
        
    };
    //评论
    self.liveView.commentClick=^(){
        [weakSelf commentData];
        
    };
}
-(void)commentData{
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
}


#pragma mark <UICollectionViewDataSource>
/**
 *  定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView  numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.portraitsCollectionView]) {
        return self.userList.count;
    }
    return self.conversationDataRepository.count;
}
/**
 *  每个UICollectionView展示的内容
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.portraitsCollectionView]) {
        RCDLivePortraitViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"portraitcell" forIndexPath:indexPath];
        RCUserInfo *user = self.userList[indexPath.row];
        NSString *str = user.portraitUri;
        cell.portaitView.image = [UIImage imageNamed:str];
        return cell;
    }
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    RCDLiveMessageBaseCell *cell = nil;
    if ([messageContent isMemberOfClass:[RCInformationNotificationMessage class]] || [messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveTipMessageCell *__cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier forIndexPath:indexPath];
        __cell.isFullScreenMode = YES;
        [__cell setDataModel:model];
        //        [__cell setDelegate:self];
        cell = __cell;
    }
    
    return cell;
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
    if ([messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCInformationNotificationMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]]) {
        model.cellSize = [self sizeForItem:collectionView atIndexPath:indexPath];
    } else {
        return CGSizeZero;
    }
    return model.cellSize;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
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
//初始化发送礼物
-(void)initSendGift{
    giftView = [[SendGiftView alloc]init];
    giftView.delegate = self;
    
    [self.view addSubview:giftView];
    [giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_offset(300);
        make.bottom.mas_offset(-10);
        
    }];
}
#pragma mark ----SendGiftClickDelagate

-(void)SendGift:(UIButton *)btn giftID:(NSString *)giftID giftPic:(NSString *)giftPic giftName:(NSString *)giftName{
    [NYNNetTool GetGuanSendGiftListWithparams:@{@"liveId":_targetId,@"giftId":giftID,@"count":@"1"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        giftView.hidden= YES;
        [self.inputBar setHidden:YES];
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            UserInfoModel *jzUserModel = userInfoModel;
            
            if  ([success[@"data"]integerValue] ==1 ) {
                //                [self showLoadingView:@"发送成功"];
                RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                joinChatroomMessage.message = [NSString stringWithFormat: @"%@送给农场",jzUserModel.name];
                [self sendMessage:joinChatroomMessage pushContent:nil];
                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
                giftMessage.type = @"0";
                [self sendMessage:giftMessage pushContent:@""];

                UserInfoModel * usermodel = userInfoModel;
                
                // IM 消息
                GSPChatMessage *msg = [[GSPChatMessage alloc] init];
                //    msg.text = @"1个【鲜花】";
                // 模拟 n 个人在送礼物
                //    int x = arc4random() % 9;
                //    msg.senderChatID = [NSString stringWithFormat:@"%d",x];
                msg.senderName = usermodel.name;
                
                // 礼物模型
                GiftModel *giftModel = [[GiftModel alloc] init];
                giftModel.headImage = usermodel.avatar;
                giftModel.name = msg.senderName;
                //    [giftModel.giftImage sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
                
                giftModel.giftImage = giftPic;
                giftModel.giftName = msg.text;
                giftModel.giftCount = 1;
                
                AnimOperationManager *manager = [AnimOperationManager sharedManager];
                manager.parentView = self.view;
                // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
                [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                    
                }];
                
                
            }else if ([success[@"data"]integerValue] ==-1){
                //                [self showLoadingView:@"直播结束"];
                RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                joinChatroomMessage.message = [NSString stringWithFormat: @"%@送给农场",jzUserModel.name];
                [self sendMessage:joinChatroomMessage pushContent:nil];
                
            }else if ([success[@"data"]integerValue]==0){
                //                [self showLoadingView:@"余额不足"];
                _giftName = giftName;
                
                //                [self showLoadingView:@"发送成功"];
                RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                joinChatroomMessage.message = [NSString stringWithFormat: @"%@送给农场",jzUserModel.name];
                [self sendMessage:joinChatroomMessage pushContent:nil];
                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
                giftMessage.type = @"0";
                [self sendMessage:giftMessage pushContent:@""];
                
                UserInfoModel * usermodel = userInfoModel;
                
                // IM 消息
                GSPChatMessage *msg = [[GSPChatMessage alloc] init];
                //    msg.text = @"1个【鲜花】";
                // 模拟 n 个人在送礼物
                //    int x = arc4random() % 9;
                //    msg.senderChatID = [NSString stringWithFormat:@"%d",x];
                msg.senderName = usermodel.name;
                
                // 礼物模型
                GiftModel *giftModel = [[GiftModel alloc] init];
                giftModel.headImage = usermodel.avatar;
                giftModel.name = msg.senderName;
                //    [giftModel.giftImage sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
                
                giftModel.giftImage = giftPic;
                giftModel.giftName = msg.text;
                giftModel.giftCount = 1;
                
                AnimOperationManager *manager = [AnimOperationManager sharedManager];
                manager.parentView = self.view;
                // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
                [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                    
                }];
                
                
            }
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
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
        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
    }else if ([messageContent isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *notification = (RCTextMessage *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)messageContent;
        localizedMessage = [NSString stringWithFormat:@"送了一个%@",_giftName];
        if(notification && [notification.type isEqualToString:@"1"]){
            localizedMessage = @"为主播点了赞";
        }
        
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }
    CGSize __labelSize = [RCDLiveTipMessageCell getTipMessageCellSize:localizedMessage];
    __height = __height + __labelSize.height;
    
    return CGSizeMake(__width, __height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
#pragma mark - 输入框事件
/**
 *  点击键盘回车或
 *
 *  @param text  输入框的内容
 */
- (void)onTouchSendButton:(NSString *)text{
    RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:text];
    [self sendMessage:rcTextMessage pushContent:nil];
    [self sendDanmaku:rcTextMessage.content];
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
/*******************融云*************************/
-(void)startLiveRoomData{
    __weak OutDoorLiveRoomVC *weakSelf = self;
    
    self.defaultHistoryMessageCountOfChatRoom = 10;
    //聊天室类型进入时需要调用加入聊天室接口，退出时需要调用退出聊天室接口
    if (ConversationType_CHATROOM == self.conversationType) {
        [[RCIMClient sharedRCIMClient]
         joinChatRoom:self.targetId
         messageCount:self.defaultHistoryMessageCountOfChatRoom
         success:^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 ;
                 UserInfoModel *jzUserModel = userInfoModel;
                 
                 RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                 joinChatroomMessage.message = [NSString stringWithFormat: @"%@加入了聊天室",jzUserModel.name];
                 [self sendMessage:joinChatroomMessage pushContent:nil];
                 
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
                                         if ([message.content isMemberOfClass:[RCDLiveGiftMessage class]] ) {
                                             message.messageId = -1;//插入消息时如果id是-1不判断是否存在
                                         }
                                         [__weakself appendAndDisplayMessage:message];
                                         [__weakself.inputBar clearInputView];
                                     });
                                 } error:^(RCErrorCode nErrorCode, long messageId) {
                                     [[RCIMClient sharedRCIMClient]deleteMessages:@[ @(messageId) ]];
                                 }];
}
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
    if([NSThread isMainThread]){
        //        [self sendReceivedDanmaku:rcMessage.content];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self sendReceivedDanmaku:rcMessage.content];
        });
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

/********************推流视频初始化加载*************************************************************************/




-(void)YunfanInitiaData{
    //观看直播人员cell
    [self.portraitsCollectionView registerClass:[RCDLivePortraitViewCell class] forCellWithReuseIdentifier:@"portraitcell"];
    
    if (!self.isVertical) {
        //横屏直播  旋转90度
        [self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"isVertical"];
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isVertical"];
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

-(void)dealloc{
    
    [self unregisterApplicationObservers];
    [self.reachabilityMannger stopMonitoring];
    
}


//退出
- (void)exitLive:(UIButton *)sender{
    
    //切换直播状态
    NSDictionary *dic = @{@"status":@"OFFLINE",@"fansCount":@"1"};
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
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] init];
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_delete"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
/********************视频结束*************************************************************************/

/**
 *  初始化页面控件
 */
- (void)initializedSubViews {
    //聊天区
    if(self.contentView == nil){
        CGRect contentViewFrame = CGRectMake(0, self.view.bounds.size.height-237, self.view.bounds.size.width,237);
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

    
     [self registerClass:[RCDLiveTipMessageCell class]forCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier];
    
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
//设置点击
-(void)clapBtn:(UIButton*)sender{
    
 
    
}
/**
 *  点击返回的时候消耗播放器和退出聊天室
 *
 *  @param sender sender description
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"退出聊天室？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self quitConversationViewAndClear];
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
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                    self.conversationMessageCollectionView.dataSource = nil;
                                                    self.conversationMessageCollectionView.delegate = nil;
                                                });
                                                
                                            } error:^(RCErrorCode status) {
                                                
                                            }];
    }
}
//
#pragma MARK--主播间上方显示UI
-(void)initChatroomMemberInfo{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 130, 35)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha =0.2;
    [self.view addSubview:view];
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 34, 34)];
    imageView.layer.cornerRadius = 34/2;
    //    imageView.image =[UIImage imageNamed:[_userList[0]pimg]];
    
    //[imageView sd_setImageWithURL:[NSURL URLWithString:[_userList[0]pimg]]];
    
    imageView.layer.masksToBounds = YES;
    [view addSubview:imageView];
    
    
    UILabel *chatroomlabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 60, 35)];
    chatroomlabel.font = [UIFont systemFontOfSize:15.f];
    chatroomlabel.text = @"lihjshf";
    chatroomlabel.textColor = [UIColor whiteColor];
    [view addSubview:chatroomlabel];
    //关注
    _attentionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _attentionBtn.frame= CGRectMake(85, 10, 70, 25);
    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _attentionBtn.backgroundColor= [UIColor whiteColor];
    
    _attentionBtn.layer.cornerRadius=15;
    _attentionBtn.clipsToBounds = YES;
    
    [view addSubview:_attentionBtn];
    
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 16;
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat memberHeadListViewY = view.frame.origin.x + view.frame.size.width;
    self.portraitsCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(memberHeadListViewY,30,self.view.frame.size.width - memberHeadListViewY,35) collectionViewLayout:layout];
    self.portraitsCollectionView.delegate = self;
    self.portraitsCollectionView.dataSource = self;
    self.portraitsCollectionView.backgroundColor = [UIColor clearColor];
    [self.portraitsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
-(LiveMessegeBoomVIew *)liveView{
    if (!_liveView) {
        _liveView = [[LiveMessegeBoomVIew alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-40, SCREENWIDTH, 60)];
    }
    return _liveView;
    
}
@end
