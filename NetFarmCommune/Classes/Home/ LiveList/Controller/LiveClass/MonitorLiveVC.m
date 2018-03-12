//
//  MonitorLiveVC.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MonitorLiveVC.h"
#import "MonitorLiveTVCell.h"
#import "NYNNetTool.h"
#import "GiftListModel.h"

#import "YFMediaPlayer/YFMediaPlayer.h"
#import "LiveMessegeBoomVIew.h"
#import "Masonry.h"
#import "SendGiftView.h"

#import "RCDLive.h"
#import "RCDLiveMessageModel.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import "RCDLiveGiftMessage.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>

#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"
#import "RCDLive.h"

//输入框的高度
#define MinHeight_InputView 50.0f

@interface MonitorLiveVC ()<UITableViewDelegate,UITableViewDataSource,SendGiftClickDelagate,YfFFMoviePlayerControllerDelegate,RCConnectionStatusChangeDelegate,RCTKInputBarControlDelegate>
{
        NSTimer * timer;
     SendGiftView * giftView;
    
}

@property(nonatomic,strong)UIView * videoView;
@property(nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong)UILabel * farmLabel;//农场名label

@property(nonatomic,strong)LiveMessegeBoomVIew * liveView;//界面下方显示

@property(nonatomic,strong)  NSString * giftName;



/**
 *  是否需要滚动到底部
 */
@property(nonatomic, assign) BOOL isNeedScrollToButtom;

@property(atomic, retain) id<YfMediaPlayback> player;


@end

@implementation MonitorLiveVC


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self rcinit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self rcinit];
    }
    return self;
}
- (void)rcinit {
    self.targetId = nil;
    [self registerNotification];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationDataRepository = [[NSMutableArray alloc] init];
    self.title =@"农场监控直播";
     [self.view addSubview:self.tableview];
    [self.view addSubview:self.liveView];
    [self.liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(60);
        
    }];
  
    
    __weak typeof(MonitorLiveVC*) weakSelf = self;
    //礼物按钮
    self.liveView.liftClick =^(){
        [weakSelf initSendGift];
    };
    
    //点赞按钮
    self.liveView.zanClick=^(){
        [weakSelf dianzanButton];

    };
    //评论
    self.liveView.commentClick=^(){
         [weakSelf commentData];
    };
    
    
    
     [self.view addSubview:self.videoView];
    
    
    NSString* str = @"rtmp://live.hkstv.hk.lxdns.com/live/hks";
     self.player = [[YfFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:str] withOptions:NULL useDns:NO useSoftDecode:NO DNSIpCallBack:NULL appID:"" refer:"" bufferTime:3 display:YES isOpenSoundTouch:YES];
    self.player.shouldAutoplay = YES;
    self.player.overalState = YfPLAYER_OVERAL_NORMAL;
    self.player.delegate = self;
    self.player.view.frame = CGRectMake(0, 0, SCREENWIDTH,JZHEIGHT(200));
    self.player.scalingMode = YfMPMovieScalingModeAspectFit;
    
    [self.videoView addSubview:self.player.view];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.player prepareToPlay];
    [self.player play];
    
    [self initiaChatRoom];
    
    self.farmLabel.text = _farmString;
    [self.videoView addSubview:self.farmLabel];
    [_farmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(30);
        make.width.mas_equalTo(SCREENWIDTH);
        make.top.mas_equalTo(JZHEIGHT(220));
        
    }];
    



}
//点赞（点赞要付费所以外面要请求一次，神经病需求）

-(void)dianzanButton{
    
    [NYNNetTool GetSendGiftListWithparams:nil isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
            giftMessage.type = @"0";
            [self sendMessage:giftMessage pushContent:@""];
            
//            NSString * giftPic =success[@"data"][0][@"img"] ;
//            NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":success[@"data"][0][@"name"]};
//            //发送礼物的本地通知
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
    
}
//评论
-(void)commentData{
    //聊天区
    if(self.contentView == nil){
        CGRect contentViewFrame = CGRectMake(0, 0, SCREENWIDTH,237);
        self.contentView.backgroundColor =[UIColor colorWithRed:235 green:235 blue:235 alpha:1] ;
        self.contentView = [[UIView alloc]initWithFrame:contentViewFrame];
        [self.view addSubview:self.contentView];
    }
    //输入区
    if(self.inputBar == nil){
        float inputBarOriginY = 700;
        float inputBarOriginX = self.tableview.frame.origin.x;
        float inputBarSizeWidth = self.contentView.frame.size.width;
        float inputBarSizeHeight = MinHeight_InputView;
        self.inputBar = [[RCDLiveInputBar alloc]initWithFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
        self.inputBar.delegate = self;
        self.inputBar.backgroundColor = [UIColor clearColor];
        self.inputBar.hidden = YES;
        [self.view addSubview:self.inputBar];
        
    }
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
}

#pragma mark RCInputBarControlDelegate

/**
 *  根据inputBar 回调来修改页面布局，inputBar frame 变化会触发这个方法
 *
 *  @param frame    输入框即将占用的大小
 *  @param duration 时间
 */
- (void)onInputBarControlContentSizeChanged:(CGRect)frame withAnimationDuration:(CGFloat)duration andAnimationCurve:(UIViewAnimationCurve)curve{
    
    CGRect inputbarRect = self.inputBar.frame;
    
    inputbarRect.origin.y = SCREENHEIGHT - frame.size.height - MinHeight_InputView - 15;
    [self.inputBar setFrame:inputbarRect];
    [self.view bringSubviewToFront:self.inputBar];
}
/**
 *  消息滚动到底部
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToBottomAnimated:(BOOL)animated {
    if ([self.tableview numberOfSections] == 0) {
        return;
    }
}
/**
 *  移除监听
 *
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self  name:@"kRCPlayVoiceFinishNotification"   object:nil];
    [self quitConversationViewAndClear];
    [self.player shutdown];
    self.player = nil;
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


-(void)initiaChatRoom{
    __weak MonitorLiveVC * weakself = self;
    
    //聊天室类型进入时需要调用加入聊天室接口，退出时需要调用退出聊天室接口
    if (ConversationType_CHATROOM == self.conversationType) {
        [[RCIMClient sharedRCIMClient]
         joinChatRoom:self.targetId
         messageCount:10
         success:^{
             dispatch_async(dispatch_get_main_queue(), ^{
//                 timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(sendmessage) userInfo:nil repeats:YES];
                 RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                 UserInfoModel *jzUserModel = userInfoModel;
                 
                 joinChatroomMessage.message = [NSString stringWithFormat: @"%@加入了聊天室",jzUserModel.name];
                 [self sendMessage:joinChatroomMessage pushContent:nil];
             });
         }
         error:^(RCErrorCode status) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (status == KICKED_FROM_CHATROOM) {
                     
                     [weakself loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomRejected", @"RongCloudKit", nil)];
                 } else {
                     [weakself loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomFailed", @"RongCloudKit", nil)];
                 }
             });
         }];
    }
}

#pragma mark ----SendGiftClickDelagate

-(void)SendGift:(UIButton *)btn giftID:(NSString *)giftID giftPic:(NSString *)giftPic giftName:(NSString *)giftName{
    [NYNNetTool GetGuanSendGiftListWithparams:@{@"liveId":_targetId,@"giftId":giftID,@"count":@"1"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        giftView.hidden= YES;
        [self.inputBar setHidden:YES];
        _giftName = giftName;
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            if  ([success[@"data"]integerValue] ==1) {
                
                
                
            }else if ([success[@"data"]integerValue] ==-1){
                
                
            }else if ([success[@"data"]integerValue] ==0){
                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
                giftMessage.type = @"0";
                [self sendMessage:giftMessage pushContent:@""];
              //礼物动画
                UserInfoModel * usermodel = userInfoModel;
                
                // IM 消息
                GSPChatMessage *msg = [[GSPChatMessage alloc] init];
                //msg.text = [NSString ] @"1个【鲜花】";
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
                giftModel.giftName = giftName;
                giftModel.giftCount = 1;
                
                
                AnimOperationManager *manager = [AnimOperationManager sharedManager];
                manager.parentView = self.view;
                // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
                [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                    
                }];
            }
        }else if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"401"]){
            //重新登录
            
        }
    } failure:^(NSError *failure) {
        
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
                                     });
                                 } error:^(RCErrorCode nErrorCode, long messageId) {
                                     [[RCIMClient sharedRCIMClient]deleteMessages:@[ @(messageId) ]];
                                 }];
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
                //                if (![self isAtTheBottomOfTableView]) {
                //                    self.unreadNewMsgCount ++ ;
                //                    [self updateUnreadMsgCountLabel];
                //                }
            }
        });
    }
}

    /**
     *  将消息加入本地数组
     
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
            [self.tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
        }
    }

//初始化发送礼物
-(void)initSendGift{
     giftView = [[SendGiftView alloc]init];
    giftView.delegate=self;
    
    [self.view addSubview:giftView];
    [giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(300);
    }];
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
            [self.tableview reloadData];
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

    // 清理环境（退出聊天室并断开融云连接）
- (void)quitConversationViewAndClear {
        if (self.conversationType == ConversationType_CHATROOM) {
            
            [timer invalidate];
            timer = nil;
            //退出聊天室
            [[RCIMClient sharedRCIMClient] quitChatRoom:self.targetId
                                                success:^{
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        self.tableview.dataSource = nil;
                                                        self.tableview.delegate = nil;
                                                    });
                                                    
                                                
                                                    [[NSNotificationCenter defaultCenter] removeObserver:self];
                                                    
                                                    //断开融云连接，如果你退出聊天室后还有融云的其他通讯功能操作，可以不用断开融云连接，否则断开连接后需要重新connectWithToken才能使用融云的功能
//                                                    [[RCDLive sharedRCDLive]logoutRongCloud];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    });
                                                    
                                                } error:^(RCErrorCode status) {
                                                    
                                                }];
        }
    }


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
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
    //    [self sendDanmaku:rcTextMessage.content];
    [self.inputBar setHidden:YES];
}


- (void)playerStatusCallBackLoadingCanReadyToPlay:(YfFFMoviePlayerController *)player
{
    
    /*
     *加载完成 异步
     *
     */
    NSLog(@"异步加载完成");
    //    [self.player play];
    
}

-(void)playerStatusCallBackPlayerPlayErrorType:(YfPLAYER_MEDIA_ERROR)errorType httpErrorCode:(int)httpErrorCode player:(YfFFMoviePlayerController *)player
{
    
//    [controlView shutdownUpdatePlayTimeOnMainThread];
    NSLog(@"播放错误");
    [self.player clean];
    //重新获取流地址
    [self.player play:[NSURL URLWithString:self.playUrl] useDns:NO useSoftDecode:NO DNSIpCallBack:nil appID:"" refer:"" bufferTime:3];
    
}
-(void)playerStatusCallBackPlayerPlayEnd:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"播放结束");
    player.currentPlaybackTime = 0;
    [player play];
    //[controlView shutdownUpdatePlayTimeOnMainThread];
    
}




#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.conversationDataRepository.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorLiveTVCell * liveVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (liveVCell == nil) {
        liveVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MonitorLiveTVCell class]) owner:self options:nil].firstObject;
    }
    
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    [liveVCell.headImage sd_setImageWithURL:[NSURL  URLWithString:userInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"占位图"]];

    RCMessageContent *content = model.content;
    if ([content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)content;
        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        liveVCell.nameLabel.text = localizedMessage;
    }else if ([content isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *notification = (RCTextMessage *)content;
        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = [NSString stringWithFormat:@"%@:",userInfoModel.name];
        }
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:([UIColor whiteColor]) range:[str rangeOfString:localizedMessage]];
        liveVCell.nameLabel.attributedText = attributedString.copy;
    }else if ([content isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)content;
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = userInfoModel.name;
        }
        NSString *localizedMessage = @"送了一个钻戒";
        if(notification && [notification.type isEqualToString:@"1"]){
            localizedMessage = @"为主播点了赞";
        }
        
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
       liveVCell.nameLabel.attributedText = attributedString.copy;
    }
    
      return liveVCell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    giftView.hidden= YES;
    
}


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(250))];
        _videoView.backgroundColor = [UIColor whiteColor];
    }
    return _videoView;
    
}
-(UILabel *)farmLabel{
    if (!_farmLabel) {
        _farmLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_videoView.frame)-50, 200, 30)];
        _farmLabel.textColor = [UIColor blackColor];
        _farmLabel.font = [UIFont systemFontOfSize:15];
        _farmLabel.text = @"热门直播>开心农场";
    }
    return _farmLabel;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(260), SCREENWIDTH, SCREENHEIGHT-JZHEIGHT(260)-60) style:UITableViewStylePlain];
        _tableview.dataSource =self;
        _tableview.delegate =self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.rowHeight=70;
    }
    return _tableview;
    
}
-(LiveMessegeBoomVIew *)liveView{
    if (!_liveView) {
        _liveView = [[LiveMessegeBoomVIew alloc]init];
    }
    return _liveView;
    
}




@end
