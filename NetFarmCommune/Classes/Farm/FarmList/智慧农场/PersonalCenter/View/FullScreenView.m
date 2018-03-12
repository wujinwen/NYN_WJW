//
//  FullScreenView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/29.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FullScreenView.h"


#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import "RCDLiveGiftMessage.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "Masonry.h"
#import "LiveMessegeBoomVIew.h"
#import "NYNTextMessage.h"

#import "SendGiftView.h"
#import "RCDLivePortraitViewCell.h"
#import "RCDLiveMessageBaseCell.h"
#import "RCDLiveTipMessageCell.h"

#import "RCDLive.h"
#import "RCDLiveMessageModel.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import "RCDLiveGiftMessage.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "NYNMessageContent.h"

#import "UIView+RCDDanmaku.h"
#import "RCDDanmaku.h"
#import "RCDDanmakuManager.h"
#import "GSPChatMessage.h"
#import "NYNLiveGiftMessege.h"//自定义礼物类
#import "NYNTextMessage.h"//消息类
#import "ZWPullMenuModel.h"
#import <YfMediaPlayer/YfMediaPlayer.h>
#import <YFMediaPlayerPushStreaming/YfSessionCamera.h>
#import <YFMediaPlayerPushStreaming/XXManager.h>
#import "NYNLiveInfoModel.h"
#import "GiftModel.h"
#import "SendGiftView.h"
#import "AnimOperationManager.h"

#import "UIImage+Radius.h"
//输入框的高度
#define MinHeight_InputView 50.0f
@interface FullScreenView()<YfSessionDelegate,UICollectionViewDelegate,UICollectionViewDataSource,RCTKInputBarControlDelegate,UICollectionViewDelegateFlowLayout,SendGiftClickDelagate>{
      BOOL  danmuState;
     NSTimer *timer;//刷新主播信息
}

//Func
//直播关键类
@property(nonatomic,strong) YfSession *yfSession;

@property (nonatomic,strong)id<YfMediaPlayback>playerOne;

@property(nonatomic,strong)UIView * videoView;
//重推流的最大次数
@property (nonatomic, assign) NSInteger retryPushStreamCount;
//推流状态
@property(nonatomic,assign) YfSessionState rtmpSessionState;

//网络判断管理类
@property(nonatomic,strong) AFNetworkReachabilityManager *reachabilityMannger;

@property(nonatomic,strong) NSString *result1;//请求者推流

@property(nonatomic,strong)NSString *result;//请求者拉流
//主播信息显示UI
@property (nonatomic, strong) UIImageView *imageView;//主播头像
@property(nonatomic,strong) UILabel *chatroomlabel ;//房间名
@property(nonatomic,strong)UILabel * renqiLabel; //人气
@property(nonatomic,strong)UIView * topBackView;
@property(nonatomic,strong)UILabel * roomlabel;//房间号
@property (nonatomic, strong) NYNLiveInfoModel * liveInfoModel;//直播间参数
@property(nonatomic,strong)UILabel * peopleLabel;//人数
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) SendGiftView* giftView;

@property(nonatomic,strong)  NSString * giftName;
@property (nonatomic, strong) UIView * danmuView;//弹幕视图
//是否已经收藏
@property (nonatomic,assign) BOOL isCollection;

@end
/**
 *  小灰条提示cell标示F
 */
static NSString *const RCDLiveTipMessageCellIndentifier = @"RCDLiveTipMessageFFCellIndentifier";
@implementation FullScreenView





-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.conversationDataRepository = [[NSMutableArray alloc] init];
        [self initiaInterface];
        UIColor * color = [UIColor blackColor];
        
        self.backgroundColor = [color colorWithAlphaComponent:0];
        
    }
    return self;
    
}



-(void)initiaInterface{
    [self addSubview:self.videoView];
    
    
//    __weak typeof(FullScreenView*) weakSelf = self;
//    _liveView = [[LiveMessegeBoomVIew alloc]init];
    


    //注册接受消息通知
    [self registerNotification];
    
    _danmuView  = [[UIView alloc]init];
    
    //    _danmuView.backgroundColor = [UIColor yellowColor];
    //接收本地礼物通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GiftListNotification:) name:@"GiftListNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(danmuNotification:) name:@"danmuNotification" object:nil];
    
    [self addSubview:_danmuView];
    [_danmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    
//    timer = [NSTimer scheduledTimerWithTimeInterval:20 repeats:YES block:^(NSTimer * _Nonnull timer) {
////        [self getLiveIdDataStr:_liveId isVertical:_isLevel];
//    }];
}

//接收本地礼物通知方法
-(void)GiftListNotification:(NSNotification*)nofitation{
    //    nofitation.object
    UserInfoModel * usermodel = userInfoModel;
    
    // IM 消息
    GSPChatMessage *msg = [[GSPChatMessage alloc] init];
    //msg.text = [NSString ] @"1个【鲜花】";
    // 模拟 n 个人在送礼物
    //    int x = arc4random() % 9;
    msg.senderChatID = userInfoModel.ID;
    msg.senderName = usermodel.name;
    NSLog(@"id %@ -------送了%@--------",usermodel.name,nofitation.userInfo[@"giftName"]);
    
    // 礼物模型
    GiftModel *giftModel = [[GiftModel alloc] init];
    giftModel.headImage = usermodel.avatar;
    giftModel.name = msg.senderName;
    //    [giftModel.giftImage sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
    
    giftModel.giftImage = nofitation.userInfo[@"giftPic"];
    giftModel.giftName = nofitation.userInfo[@"giftName"];
    giftModel.giftCount = 1;
    
    
    AnimOperationManager *manager = [AnimOperationManager sharedManager];
    manager.parentView = self;
    // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
    [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
        
    }];
    
    
}



-(void)danmuNotification:(NSNotification*)notification{
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:notification.userInfo[@"text"] attributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
    danmaku.position = RCDDanmakuPositionNone;
    [self sendDanmaku:danmaku];
}


-(void)dealloc{
      [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark--SendGiftClickDelagate
-(void)SendGift:(UIButton *)btn giftID:(NSString *)giftID giftPic:(NSString *)giftPic giftName:(NSString *)giftName{
    if (giftID ==nil) {
        return;
        
    }
    [NYNNetTool GetGuanSendGiftListWithparams:@{@"liveId":_targetId,@"giftId":giftID,@"count":@"1"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        _giftView.hidden= YES;
        [self.inputBar setHidden:YES];
        _giftName = giftName;
        
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            if  ([success[@"data"]integerValue] ==1 ) {
                //                [self showLoadingView:@"发送成功"];
                
                NYNLiveGiftMessege * giftMessege = [[NYNLiveGiftMessege alloc]init];
                giftMessege.ID = giftID.intValue;
                giftMessege.targetName = self.targetId;
                giftMessege.content = giftPic;
                giftMessege.count = 1;
                giftMessege.time = [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
                
                [self sendMessage:giftMessege pushContent:@""];
                
                NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":giftName};
                //发送礼物的本地通知
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
                
            }else if ([success[@"data"]integerValue] ==-1){
                //                [self showLoadingView:@"直播结束"];
                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
                giftMessage.type = @"0";
                [self sendMessage:giftMessage pushContent:@""];
                NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":giftName};
                //发送礼物的本地通知
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
                
            }else if ([success[@"data"]integerValue]==0){
                //                [self showLoadingView:@"余额不足"];
                NYNLiveGiftMessege * giftMessege = [[NYNLiveGiftMessege alloc]init];
                giftMessege.ID = giftID.intValue;
                giftMessege.targetName = self.targetId;
                giftMessege.content = giftPic;
                giftMessege.count = 1;
                giftMessege.time = [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
                
                [self sendMessage:giftMessege pushContent:@""];
                //                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
                //                giftMessage.type = @"0";
                //                giftMessage.picUrl = giftPic;
                //                [self sendMessage:giftMessage pushContent:giftPic];
                NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":giftName};
                //发送礼物的本地通知
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
                
                
            }
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
    
}
-(void)getLiveIdDataStr:(NSString *)string isVertical:(BOOL)isVertical{
    _liveView = [[LiveMessegeBoomVIew alloc]init];
    [self addSubview:self.liveView];
    [self addSubview:self.exitBtn];

    
    //初始化主播信息
    NSDictionary * dic = @{@"id":string,@"token":userInfoModel.token};
    [NYNNetTool GetInfoWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {

            NYNLiveInfoModel *model = [NYNLiveInfoModel mj_objectWithKeyValues:success[@"data"]];
            //
            self.liveInfoModel = model;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initChatroomInfo];
                
            });
        }else{
       
        }
    } failure:^(NSError *failure){
        NSLog(@"初始化主播信息失败");
    }];
    //判断横竖屏
    if (isVertical == YES) {
        //        _liveView.frame =  CGRectMake(0, SCREENWIDTH-60, SCREENHEIGHT, 60);
        //        _exitBtn.frame =CGRectMake(SCREENHEIGHT-40, 15, 25, 25);
        _exitBtn.userInteractionEnabled=YES;
        
    }else{
        //        _liveView.frame = CGRectMake(0, SCREENHEIGHT-60, SCREENWIDTH, 60);
        //        _exitBtn.frame =CGRectMake(SCREENWIDTH-40, 15, 25, 25);
        
        
    }
    
    [_liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(30);
        
    }];
    _liveView.lianmaiButton.hidden = YES;//暂时隐藏连麦功能
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-40);
        make.top.mas_offset(15);
        make.width.height.mas_offset(25);
    }];
    __weak typeof(FullScreenView*) weakSelf = self;
    //连麦
    self.liveView.lianmaiClick = ^(){
        [weakSelf lianmaiClick];
        
        
    };
    //评论
    self.liveView.commentClick=^(){
        [weakSelf initializedSubViews];
        
    };
    //送礼物
    self.liveView.liftClick=^(){
          [weakSelf initSendGift];
        
    };
    self.liveView.zanClick = ^(){
        [weakSelf dianzanButtonClick];
        
    };
    
    
}
//初始化发送礼物
-(void)initSendGift{
    _giftView = [[SendGiftView alloc]init];
    _giftView.delegate = self;
    
    [self addSubview:_giftView];
    [_giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(300);
    }];
    
}




-(void)dianzanButtonClick{
    [NYNNetTool GetSendGiftListWithparams:nil isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            
            NYNLiveGiftMessege * giftMessege = [[NYNLiveGiftMessege alloc]init];
            giftMessege.ID = [success[@"data"][0][@"id"] intValue];
            giftMessege.targetName = self.targetId;
            giftMessege.content =success[@"data"][0][@"img"];
            giftMessege.count = 1;
            giftMessege.time = [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
            
            [self sendMessage:giftMessege pushContent:@""];
            
            
            NSString * giftPic =success[@"data"][0][@"img"] ;
            NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":success[@"data"][0][@"name"]};
            //发送礼物的本地通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
}


#pragma mark---弹幕
- (void)sendReceivedDanmaku:(RCMessageContent *)messageContent {
    if([messageContent isMemberOfClass:[RCInformationNotificationMessage class]]){
        
    }else if ([messageContent isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *msg = (RCTextMessage *)messageContent;
        
        [self sendDanmaku:msg.content];
    }else if([messageContent isMemberOfClass:[NYNLiveGiftMessege class]]){
        NYNLiveGiftMessege * msg =(NYNLiveGiftMessege *)messageContent;
        NSURL *url = [NSURL URLWithString:msg.content];// 获取的图片地址
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
        //生成文本附件
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = image;
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        
        
        
        //        RCDLiveGiftMessage *msg = (RCDLiveGiftMessage *)messageContent;
        //       NSString *tip = [msg. isEqualToString:@"0"]?@"送了一个钻戒":@"为主播点了赞";
        NSString *text = [NSString stringWithFormat:@"%@ %@",msg.senderUserInfo.name,string];
                [self sendDanmaku:text];
    }
}


#pragma mark <UICollectionViewDataSource>
/**
 *  定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView  numberOfItemsInSection:(NSInteger)section {
    
    return self.conversationDataRepository.count;
}

/**
 *  每个UICollectionView展示的内容
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    
    RCDLiveMessageBaseCell *cell = nil;
    if ([messageContent isMemberOfClass:[NYNMessageContent class]] || [messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]] ||[messageContent isMemberOfClass:[NYNLiveGiftMessege class]]){
        RCDLiveTipMessageCell *__cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier forIndexPath:indexPath];
        __cell.isFullScreenMode = YES;
        [__cell setDataModel:model];
        //        [__cell setDelegate:self];
        cell = __cell;
    }
    
    //    }
    return cell;
}
#pragma mark <UICollectionViewDelegateFlowLayout>

/**
 *  cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //    if ([collectionView isEqual:self.conversationMessageCollectionView]) {
    //        return CGSizeMake(35,35);
    //    }
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (model.cellSize.height > 0) {
        return model.cellSize;
    }
    RCMessageContent *messageContent = model.content;
    if ([messageContent isMemberOfClass:[NYNMessageContent class]] || [messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCInformationNotificationMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]]||[messageContent isMemberOfClass:[NYNLiveGiftMessege class]]) {
        model.cellSize = [self sizeForItem:collectionView atIndexPath:indexPath];
    } else {
        return CGSizeZero;
    }
    return model.cellSize;
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
    }else if ([messageContent isMemberOfClass:[NYNMessageContent class]]){
        NYNMessageContent *notification = (NYNMessageContent *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)messageContent;
        //        localizedMessage = [NSString stringWithFormat:@"送了一个%@",_giftName];
        localizedMessage = [NSString stringWithFormat:@"送了一个礼物"];
        if(notification && [notification.type isEqualToString:@"1"]){
            localizedMessage = @"为主播点了赞";
        }
        
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[NYNLiveGiftMessege class]]){
        NYNLiveGiftMessege *notification = (NYNLiveGiftMessege *)messageContent;
        //判断点赞id
        
        
           localizedMessage = [NSString stringWithFormat:@"送了一个礼物"];
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


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
}
-(void)initChatroomInfo{
    [self addSubview:self.topBackView];
    [self.topBackView addSubview:self.imageView];
    
    [_topBackView addSubview:self.chatroomlabel];
    [_topBackView addSubview:self.roomlabel];
    [_topBackView addSubview:self.attentionBtn];
    
    
    [self addSubview:self.renqiLabel];
    [self addSubview:self.peopleLabel];
    
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        WithFrame:CGRectMake(1, 5, 38, 38)
        make.width.mas_offset(150);
        make.left.mas_offset(10);
        make.top.mas_offset(30);
        make.height.mas_offset(45);
    }];
    [self.renqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(JZWITH(60));
        make.left.equalTo(self.topBackView.mas_right).offset(10);
        make.top.mas_offset(18);
        make.height.mas_offset(28);
    }];

    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBackView.mas_right).offset(5);
        make.width.mas_offset(JZWITH(60));
        make.height.mas_offset(30);
        make.top.equalTo(_renqiLabel.mas_bottom).offset(5);
    }];
    
    //主播头像
    
    if ([self.liveInfoModel.avatar isEqualToString:@""]) {
           [_imageView sd_setImageWithURL:[NSURL URLWithString:self.liveInfoModel.pimg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    }else{
           [_imageView sd_setImageWithURL:[NSURL URLWithString:self.liveInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"占位图"]];
    }
    //主播姓名
    if ([self.liveInfoModel.userName isEqualToString:@""]) {
         _chatroomlabel.text =self.liveInfoModel.farmTitle;
    }else{
          _chatroomlabel.text =self.liveInfoModel.userName;
    }
 
    //房间号
    _roomlabel.text = [NSString stringWithFormat:@"房间号:%d",self.liveInfoModel.farmId];
    //人气
    _renqiLabel.text = [NSString stringWithFormat:@"人气:%d",self.liveInfoModel.popurlar];
    //人数
    _peopleLabel.text = [NSString stringWithFormat:@"人数:%@",self.liveInfoModel.currentMember ];
    
    if (self.liveInfoModel.hasCollection  == NO) {
           [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    }else{
         [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }
    
   
    
    
}
//关注
-(void)attentionBtnClick:(UIButton*)sender{

    NSDictionary * dic = @{@"cid":_targetId,@"ctype":@"live"};
    
    [NYNNetTool ZengJiaShouCangWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]]isEqualToString:@"200"]) {
            if ([[NSString stringWithFormat:@"%@",success[@"data"]]isEqualToString:@"1"]) {
                self.isCollection = YES;
                 [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal] ;
                
             
            }else{
                self.isCollection = NO;
                 [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal] ;
                
            }
            
           
            
       
            
        }
        
        
    } failure:^(NSError *failure) {
        
        
    }];
}

/**
 *  注册监听Notification
 */
- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessageNotification:)name:RCDLiveKitDispatchMessageNotification object:nil];
    //刷新界面
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(didReceiveMessageNotification:) name:@"reloadPalyer"object:nil];
}

#pragma mark--退出全屏
-(void)exitLive:(UIButton*)sender{
    //退出全屏导航栏显示
    
    [self.delagate exitFullScreenClick];
    //    [self lianmaiClick];
    
}

/**
 *  接收到消息的回调
 *
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"reloadPalyer"]) {
        ZWPullMenuModel * model = [[ZWPullMenuModel alloc]init];
        model = notification.userInfo[@"model"];
        self.targetId = model.farmId;
        //        [self.conversationDataRepository removeAllObjects];
        //        [self.tableView reloadData];
        //        [self initiaChatRoom];
    }else if ([notification.name isEqualToString:RCDLiveKitDispatchMessageNotification]) {
        __block RCMessage *rcMessage = notification.object;
        RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
        //        RCUserInfo * info = [[RCUserInfo alloc]initWithUserId:model.senderUserId name:nil portrait:nil];
        NSDictionary *leftDic = notification.userInfo;
        if (leftDic && [leftDic[@"left"] isEqual:@(0)]) {
            //       self.isNeedScrollToButtom = YES;
        }
        if (model.conversationType == self.conversationType &&[model.targetId isEqual:self.targetId]) {
            __weak typeof(&*self) __blockSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (rcMessage) {
                    [__blockSelf appendAndDisplayMessage:rcMessage];
                    UIMenuController *menu = [UIMenuController sharedMenuController];
                    menu.menuVisible=NO;
                }
            });
        }
        
        
        //发送收到礼物的通知
        if ([rcMessage.content isKindOfClass:[NYNLiveGiftMessege class]]) {
            //发送礼物显示的通知
            NSDictionary * dict = @{@"giftPic":[(NYNLiveGiftMessege*)rcMessage.content content],@"giftName":@"礼物"};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
        }
        if ([rcMessage.content isKindOfClass:[NYNMessageContent class]]) {
            //弹幕显示
            if ([(NYNMessageContent*)rcMessage.content isDanmu] ==YES ) {
                if([NSThread isMainThread]){
                    NSDictionary * dict = @{@"text":[(NYNMessageContent*)rcMessage.content msg] };
                    //发送弹幕显示通知，
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];
                     [self picuRL:rcMessage.content.senderUserInfo.portraitUri msg:[(NYNMessageContent*)rcMessage.content msg]];
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary * dict = @{@"text":[(NYNMessageContent*)rcMessage.content msg] };
                        //发送弹幕显示通知，
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];
                        [self picuRL:rcMessage.content.senderUserInfo.portraitUri msg:[(NYNMessageContent*)rcMessage.content msg]];
                    });
                }
            }

        }
        
        //接收主播端接受连麦请求
        if ([rcMessage.content isKindOfClass:[NYNTextMessage class]]) {
            NSString * url =[(NYNTextMessage*)rcMessage.content content];
            NSRange  userUrl = [url rangeOfString:@","];
            NSRange  range= NSMakeRange(0, userUrl.location);
            _result= [url substringWithRange:range];
            
            NSRange  range1= NSMakeRange(userUrl.location+1, userUrl.location);
            _result1 = [url substringWithRange:range1];
            
            //初始化推流
            self.kbps = 400;
            self.fps = 20;
            [self setParameter];
        }
        
        
    }
}

//连麦点击
-(void)lianmaiClick{
    
    
    NSDictionary * dic =@{@"token":userInfoModel.token,@"toUserId":_targetId,@"type":@"0"};
    
    [NYNNetTool GetUnionInfoWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            // RCTextMessage *testMessage = [RCTextMessage messageWithContent:@"test"];
            
            if ([success[@"msg"] isEqualToString:@"申请失败"]) {
                
                
            }else{
                //发送单聊连麦申请
                NYNTextMessage * textMessege = [[NYNTextMessage alloc]init];
                //type为1表示请求连麦
                textMessege.type =1;
                textMessege.targetId= _targetId;
                textMessege.content = @"";
                _conversationType = ConversationType_PRIVATE;
                textMessege.time =[NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
                [self sendMessage:textMessege pushContent:nil];
                
            }
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
    
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

- (void)sendCenterDanmakuWithAttributedString:(NSAttributedString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = text;
    
    //    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    //    [self.view sendDanmaku:danmaku atPoint:(CGPoint)]
    
    //    danmaku.position = RCDDanmakuPositionNone;
    [self sendDanmaku:danmaku];
}

-(void)getScreenLiveUrlWith:(NSString *)playUrl{
    
    
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
    
    messageContent.senderUserInfo.userId = userInfoModel.ID;
    
    if (messageContent == nil) {
        return;
    }
    
    if ([messageContent isKindOfClass:[NYNTextMessage class]]) {
        if (self.conversationType  ==ConversationType_PRIVATE) {
            [[RCIMClient sharedRCIMClient]sendMessage:self.conversationType targetId:_zhuboId content:messageContent pushContent:nil pushData:nil success:^(long messageId) {
                NSLog(@"发送成功。当前消息ID：%ld", messageId);
            } error:^(RCErrorCode nErrorCode, long messageId) {
                NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
            }];
        }else{
            [[RCIMClient sharedRCIMClient]sendMessage:self.conversationType targetId:_targetId content:messageContent pushContent:nil pushData:nil success:^(long messageId) {
                NSLog(@"发送成功。当前消息ID：%ld", messageId);
                
            } error:^(RCErrorCode nErrorCode, long messageId) {
                NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
            }];
        }
        
        
        
    }else{
        self.conversationType = ConversationType_CHATROOM;
        [[RCDLive sharedRCDLive] sendMessage:self.conversationType targetId:self.targetId content:messageContent  pushContent:pushContent   pushData:nil
                                     success:^(long messageId) {
                                         __weak typeof(&*self) __weakself = self;
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             RCMessage *message = [[RCMessage alloc] initWithType:__weakself.conversationType
                                                                                         targetId:__weakself.targetId
                                                                                        direction:MessageDirection_SEND
                                                                                        messageId:messageId
                                                                                          content:messageContent];
                                             if ([message.content isMemberOfClass:[NYNLiveGiftMessege class]] ) {
                                                 message.messageId = -1;//插入消息时如果id是-1不判断是否存在
                                             }
                                             [__weakself appendAndDisplayMessage:message];
                                             [__weakself.inputBar clearInputView];
                                         });
                                     } error:^(RCErrorCode nErrorCode, long messageId) {
                                         
                                         [[RCIMClient sharedRCIMClient]deleteMessages:@[ @(messageId) ]];
                                     }];
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
        [self.conversationMessageCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
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

#pragma mark-----用户端接收到主播端同意连麦后，用户端实现推流机制

-(void)connectionStatusChanged:(YfSessionState) state{
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
            [self.yfSession startRtmpSessionWithRtmpURL:_result1];
            NSLog(@"初始化完成");
        }
            break;
        case YfSessionStateStarting: {
            _rtmpSessionState = YfSessionStateStarting;
            NSLog(@"正在连接流服务器...");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
        }
            break;
        case YfSessionStateStarted: {
            _rtmpSessionState = YfSessionStateStarted;
            
            NSLog(@"连接成功，推流开始");
            // self.retryPushStreamCount = 5;
            NYNTextMessage * textMessege = [[NYNTextMessage alloc]init];
            //type为3表示连麦成功，发送群消息通知每个用户显示双屏操作
            textMessege.type =3;
            textMessege.targetId= _targetId;
            textMessege.content = _result;
            self.conversationType = ConversationType_CHATROOM;
            
            textMessege.time =  [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
            [self sendMessage:textMessege pushContent:nil];
        }
            break;
        case YfSessionStateEnded: {
            _rtmpSessionState = YfSessionStateEnded;
        }
            break;
        case YfSessionStateError: {
            _rtmpSessionState = YfSessionStateError;
            NSLog(@"连接流服务器出错");
            //            if (self.isManualCloseLive) {
            //                if (_yfSession) {
            //                    [_yfSession releaseRtmpSession];//停止rtmp session，释放资源，不会触发rtmp session结束通知
            //                    NSLog(@"%s releaseRtmpSession",__FUNCTION__);
            //                }
            //            }else{
            //                if (self.yfSession && self.urlString) {
            //                    [self.yfSession shutdownRtmpSession]; //停止rtmp session，不释放资源
            //                    NSLog(@"%s shutdownRtmpSession",__FUNCTION__);
            //                }
            //            }
            //            if (self.reachabilityMannger.networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable && !self.isManualCloseLive) {
            //                NSLog(@"%s 继续重试推流 retryPushStream...",__FUNCTION__);
            //                [self retryPushStream];//继续重试推流（5次机会）
            //            }
            [self retryPushStream];//继续重试推流（5次机会）
        }
            break;
        default:
            break;
    }
}
/**
 *  重试推流
 */
-(void)retryPushStream{
    self.retryPushStreamCount--;
    if (self.retryPushStreamCount <= 0) {
        
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_yfSession && _result1) {
                [self.yfSession startRtmpSessionWithRtmpURL:_result1];
            }
        });
    }
    
}
- (void)setParameter{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _videoView.hidden= NO;
        
    });
    if (self.kbps < 400) {
        self.kbps = 400;
    }
    if (self.fps < 10) {
        self.fps = 10;
    }
    
    //    self.isPushed = NO;
    //    self.registeredNotifications = [[NSMutableArray alloc] init];
    self.retryPushStreamCount = 5;
    self.reachabilityMannger = [AFNetworkReachabilityManager sharedManager];
    [self.reachabilityMannger startMonitoring];
    [self networkReachabilityStatusChange];
    [self setupYfSession];
    //    UIPinchGestureRecognizer *ping = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoom:)];
    //    [self.view addGestureRecognizer:ping];
    
}

- (void)setupYfSession{
    if (!_yfSession) {
        NSLog(@"竖屏推流");
        _yfSession = [[YfSession alloc] initWithVideoSize:CGSizeMake(110, 130) sessionPreset:AVCaptureSessionPresetMedium frameRate:20 bitrate:400*1000 bufferTime:0 isUseUDP:YfTransportNone isDropFrame:YES YfOutPutImageOrientation:YfOutPutImageOrientationNormal isOnlyAudioPushBuffer:NO audioRecoderError:^(NSString *error, OSStatus status) {
        } isOpenAdaptBitrate:YES];
        
        
        [self.videoView insertSubview:_yfSession.previewView atIndex:0];
        
        XXManager *manager = [XXManager sharedManager];
        _yfSession.delegate = self;
        //人脸检测和手势开始设置为NO，等预览层加载好后，再设为YES
        manager.is_facing_tracking = NO;
        manager.is_heartGesture = NO;
        _yfSession.isHeadPhonesPlay = NO;
        [_yfSession.videoCamera switchBeautyFilter:YfSessionCameraBeautifulFilterLocalSkinBeauty];
        //默认为YES
        
        _yfSession.IsAudioOpen = YES;
        
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
/**
 *  初始化页面控件
 */
- (void)initializedSubViews {
    //    _exitBtn.hidden = YES;
    
    
    
    //聊天区
    if(self.contentView == nil){
        CGRect contentViewFrame = CGRectMake(0, self.bounds.size.height-237-60, self.bounds.size.width,237);
        self.contentView.backgroundColor =[UIColor colorWithRed:235 green:235 blue:235 alpha:1] ;
        self.contentView = [[UIView alloc]initWithFrame:contentViewFrame];
        [self addSubview:self.contentView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self.liveView.mas_top).offset(-10);
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 237));
        }];
    }
    //聊天消息区
    if (nil == self.conversationMessageCollectionView) {
        UICollectionViewFlowLayout *customFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        customFlowLayout.minimumLineSpacing = 10;
        //        customFlowLayout.minimumInteritemSpacing = 1000;
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
        [self.conversationMessageCollectionView registerClass:[RCDLiveTipMessageCell class]forCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier];
        
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
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
    
    //注册cell
    [self.conversationMessageCollectionView  registerClass:[RCDLiveTipMessageCell class]forCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier];
    //    [self.conversationMessageCollectionView  registerClass:[RCDLiveGiftMessageCell class]forCellWithReuseIdentifier:RCDLiveGiftMessageCellIndentifier];
    
    
    
}
#pragma mark RCInputBarControlDelegate
-(void)onTouchSendButton:(NSString *)text {
//    RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:text];
//    [self sendMessage:rcTextMessage pushContent:nil];
//    //    [self sendDanmaku:rcTextMessage.content];
//    [self.inputBar setHidden:YES];
    
    if (text.length<1) {
        [self.inputBar setHidden:YES];
        return;
        
        
    }
    
    //自定义消息类型，集成于融云基类
    NYNMessageContent * messegeContetnt =[[NYNMessageContent alloc]init];
    messegeContetnt.msg = text;
    messegeContetnt.targetName=_targetId;
    if (danmuState  == NO) {
        messegeContetnt.isDanmu = NO;
    }else{
        messegeContetnt.isDanmu = YES;
        //弹幕发送
//        RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
//        danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
//        danmaku.position = RCDDanmakuPositionNone;
//        [self sendDanmaku:danmaku];
        [self picuRL:[NSString stringWithFormat:@"%@",userInfoModel.avatar] msg:messegeContetnt.msg];

    }
    //获取当前时间
    NSTimeInterval i = [[NSDate date] timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", i];//转为字符型
    messegeContetnt.time = timeString;
    
    [self sendMessage:messegeContetnt pushContent:nil];
    //    [self sendMessage:[RCTextMessage messageWithContent:text] pushContent:nil];
    
    [self.inputBar setHidden:YES];
}

//是否发送弹幕
-(void)catchSwitchDanm:(BOOL)state{
    danmuState = state;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.giftView.hidden= YES;
    
}
/**
 *  根据inputBar 回调来修改页面布局，inputBar frame 变化会触发这个方法
 *
 *  @param frame    输入框即将占用的大小
 *  @param duration 时间
 */
- (void)onInputBarControlContentSizeChanged:(CGRect)frame withAnimationDuration:(CGFloat)duration andAnimationCurve:(UIViewAnimationCurve)curve{
//    CGRect collectionViewRect = self.contentView.frame;
    //        self.contentView.backgroundColor = [UIColor clearColor];
    //        collectionViewRect.origin.y = self.bounds.size.height - frame.size.height - 237 +50;
    //
    //        collectionViewRect.size.height = 237;
    //        [UIView animateWithDuration:duration animations:^{
    //            [UIView setAnimationCurve:curve];
    //            [self.contentView setFrame:collectionViewRect];
    //            [UIView commitAnimations];
    //        }];
    //        CGRect inputbarRect = self.inputBar.frame;
    //
    //        inputbarRect.origin.y = self.contentView.frame.size.height -50;
    //        [self.inputBar setFrame:inputbarRect];
    //        [self bringSubviewToFront:self.inputBar];
    //        [self scrollToBottomAnimated:NO];
}
///**
// *  消息滚动到底部
// *
// *  @param animated 是否开启动画效果
// */
//- (void)scrollToBottomAnimated:(BOOL)animated {
//    if ([self.conversationMessageCollectionView numberOfSections] == 0) {
//        return;
//    }
//    NSUInteger finalRow = MAX(0, [self.conversationMessageCollectionView numberOfItemsInSection:0] - 1);
//    if (0 == finalRow) {
//        return;
//    }
//    NSIndexPath *finalIndexPath =
//    [NSIndexPath indexPathForItem:finalRow inSection:0];
//    [self.conversationMessageCollectionView scrollToItemAtIndexPath:finalIndexPath
//                                                   atScrollPosition:UICollectionViewScrollPositionTop
//                                                           animated:animated];
//}
-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH-160,  SCREENWIDTH-150, 130, 130)];
        _videoView.backgroundColor = [UIColor blackColor];
        _videoView.hidden= YES;
    }
    return _videoView;
    
}
-(UILabel *)chatroomlabel{
    if (!_chatroomlabel) {
        _chatroomlabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 30)];
        _chatroomlabel.font = [UIFont systemFontOfSize:15.f];
        _chatroomlabel.textColor = [UIColor whiteColor];
    }
    return _chatroomlabel;
    
}
-(UILabel *)renqiLabel{
    if (!_renqiLabel) {
        _renqiLabel = [[UILabel alloc]init];
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
        _topBackView = [[UIView alloc] init];
        UIColor * color = [UIColor blackColor];
        _topBackView.backgroundColor =[color colorWithAlphaComponent:0.2];
        _topBackView.layer.cornerRadius=25;
        _topBackView.clipsToBounds = YES;
    }
    return _topBackView;
    
}
-(UILabel *)roomlabel{
    if (!_roomlabel) {
        _roomlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, CGRectGetMaxY(_chatroomlabel.frame)-8, 80, 20)];
        _roomlabel.textColor = [UIColor whiteColor];
        _roomlabel.font = [UIFont systemFontOfSize:13];
    }
    return _roomlabel;
}
-(UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.textColor = [UIColor whiteColor];
        _peopleLabel.textAlignment = NSTextAlignmentCenter;
        _peopleLabel.backgroundColor = [UIColor colorWithRed:0/250 green:0/250 blue:0/250 alpha:0.2];
        _peopleLabel.font=[UIFont systemFontOfSize:14];
        _peopleLabel.layer.cornerRadius=15;
        _peopleLabel.clipsToBounds = YES;
    }
    return _peopleLabel;
    
}
- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-40, 15, 25, 25)];
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"fork-@2x"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 38, 38)];
        _imageView.layer.cornerRadius = 38/2;
        _imageView.layer.masksToBounds = YES;
        
    }
    return _imageView;
    
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 12, 40, 20)];
        _attentionBtn.backgroundColor=[UIColor whiteColor];
        [_attentionBtn addTarget:self action:@selector(attentionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:Colore87f03 forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _attentionBtn.layer.cornerRadius=10;
        _attentionBtn.clipsToBounds= YES;
        
    }
    return _attentionBtn;
    
    
}
@end

