//
//  FarmChatViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FarmChatViewController.h"
#import "MonitorLiveTVCell.h"
#import "ZWPullMenuModel.h"

#import "SendGiftView.h"
#import "LiveMessegeBoomVIew.h"

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

#import "NYNLiveGiftMessege.h"//自定义礼物类
#import "NYNTextMessage.h"//消息类
#import "UIImage+Radius.h"
#import "NYNGouMaiWangNongBiViewController.h"
//输入框的高度
#define MinHeight_InputView 50.0f
@interface FarmChatViewController ()<UITableViewDelegate,UITableViewDataSource,RCTKInputBarControlDelegate,SendGiftClickDelagate>
{
     SendGiftView * giftView;
      BOOL  danmuState;
    
  
    
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)LiveMessegeBoomVIew * liveView;//界面下方显示
@property(nonatomic,strong)  NSString * giftName;
@end

@implementation FarmChatViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _liveView.hidden = YES;
   [self quitConversationViewAndClear];
    
    [self.inputBar endEdit];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _liveView.hidden = NO;
    [self initiaChatRoom];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    _conversationDataRepository = [NSMutableArray array];
      [self initiaChatRoom];


    
    _liveView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.liveView];
    [self.liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_offset(41);
        make.bottom.mas_offset(0);
        
        
    }];
    
    __weak typeof(FarmChatViewController*) weakSelf = self;
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
    //连麦
    self.liveView.lianmaiClick = ^(){
        [weakSelf lianmaiClick];
        
    };
    //注册接受消息通知
    [self registerNotification];

    
}

//连麦点击
-(void)lianmaiClick{
    
    
    NSDictionary * dic =@{@"token":userInfoModel.token,@"toUserId":_targetId,@"type":@"0"};
    
    [NYNNetTool GetUnionInfoWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
          // RCTextMessage *testMessage = [RCTextMessage messageWithContent:@"test"];
       //发送单聊连麦申请
            NYNTextMessage * textMessege = [[NYNTextMessage alloc]init];
            //type为1表示请求连麦
            textMessege.type =1;
            textMessege.targetId= _targetId;
            textMessege.content = @"";
            _conversationType = ConversationType_PRIVATE;
            textMessege.time =[NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
            [self sendMessage:textMessege pushContent:nil];
            
            
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
    
}




//点赞（点赞要付费所以外面要请求一次，神经病需求）
-(void)dianzanButton{
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


//初始化发送礼物
-(void)initSendGift{
    giftView = [[SendGiftView alloc]init];
    giftView.delegate = self;
    
    [self.view addSubview:giftView];
    [giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(300);
    }];
    
}
//评论
-(void)commentData{
    //聊天区
//    if(self.contentView == nil){
//        CGRect contentViewFrame = CGRectMake(0, 0, SCREENWIDTH,237);
//        self.contentView.backgroundColor =[UIColor colorWithRed:235 green:235 blue:235 alpha:1] ;
//        self.contentView = [[UIView alloc]initWithFrame:contentViewFrame];
//        [self.view addSubview:self.contentView];
//    }
    

    
    //输入区
    if(self.inputBar == nil){
        float inputBarOriginY = self.tableView.bounds.size.height-20 ;
        float inputBarOriginX = self.tableView.frame.origin.x;
        float inputBarSizeWidth = SCREENWIDTH;
        float inputBarSizeHeight = MinHeight_InputView;
        self.inputBar = [[RCDLiveInputBar alloc]initWithFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
        self.inputBar.delegate = self;
        self.inputBar.backgroundColor = [UIColor clearColor];
        self.inputBar.hidden = YES;
        self.inputBar.hideDanMu = NO;//隐藏弹幕
        [self.view addSubview:self.inputBar];
        
    }
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
}
//是否发送弹幕
-(void)catchSwitchDanm:(BOOL)state{
    danmuState = state;
    
}


#pragma mark ----SendGiftClickDelagate

-(void)chongzhiBtnClick:(UIButton *)sender{
    NYNGouMaiWangNongBiViewController * goumaiVC = [[NYNGouMaiWangNongBiViewController alloc]init];
    goumaiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goumaiVC animated:YES];
    
    
}

-(void)SendGift:(UIButton *)btn giftID:(NSString *)giftID giftPic:(NSString *)giftPic giftName:(NSString *)giftName{
    if (giftID ==nil) {
        return;
        
    }
    [NYNNetTool GetGuanSendGiftListWithparams:@{@"liveId":_targetId,@"giftId":giftID,@"count":@"1"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        giftView.hidden= YES;
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
               [self showLoadingView:@"直播结束"];
//                RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
//                giftMessage.type = @"0";
//                [self sendMessage:giftMessage pushContent:@""];
//                NSDictionary * dict = @{@"giftPic":giftPic,@"giftName":giftName};
//                //发送礼物的本地通知
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"GiftListNotification" object:nil userInfo:dict];
                
            }else if ([success[@"data"]integerValue]==0){
                [self showLoadingView:@"余额不足"];
            }
            [self hideLoadingView];
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
    
}

#pragma mark---弹幕
- (void)sendReceivedDanmaku:(RCMessageContent *)messageContent {
//    if([messageContent isMemberOfClass:[RCInformationNotificationMessage class]]){
//         RCInformationNotificationMessage *msg = (RCInformationNotificationMessage *)messageContent;
//        [self sendCenterDanmaku:msg.message];
//        [self picuRL:msg.senderUserInfo.portraitUri msg:msg.message];
//
//
//    }else if ([messageContent isMemberOfClass:[RCTextMessage class]]){
//        RCTextMessage *msg = (RCTextMessage *)messageContent;
//
////        [self sendDanmaku:msg.content];
//         [self picuRL:msg.senderUserInfo.portraitUri msg:msg.content];
//
//    }else if([messageContent isMemberOfClass:[NYNLiveGiftMessege class]]){
//
//
//        NYNLiveGiftMessege * msg =(NYNLiveGiftMessege *)messageContent;
//        NSURL *url = [NSURL URLWithString:msg.content];// 获取的图片地址
//        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
//        //生成文本附件
//        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//        attch.image = image;
//        // 创建带有图片的富文本
//        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//
//
//
////        RCDLiveGiftMessage *msg = (RCDLiveGiftMessage *)messageContent;
////       NSString *tip = [msg. isEqualToString:@"0"]?@"送了一个钻戒":@"为主播点了赞";
//       NSString *text = [NSString stringWithFormat:@"%@ %@",msg.senderUserInfo.name,string];
////        [self sendDanmaku:text];
//    }
    
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
//    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
//    danmaku.contentStr = text;
//
//    //    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
//    //    [self.view sendDanmaku:danmaku atPoint:(CGPoint)]
//
//    //    danmaku.position = RCDDanmakuPositionNone;
//    [_danmuView sendDanmaku:danmaku];
    
    NSDictionary * dict = @{@"text":text};
    //发送弹幕显示通知，由于加载在这里只会显示在屏幕下方
    [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];
}


- (void)sendDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
//    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
//
//    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
//    danmaku.position = RCDDanmakuPositionCenterTop;
//
//  //  [self.liveView sendDanmaku:danmaku];
    NSDictionary * dict = @{@"text":text};
    //发送弹幕显示通知，由于加载在这里只会显示在屏幕下方
    [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];
}

- (void)sendCenterDanmaku:(NSString *)text {
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    danmaku.position = RCDDanmakuPositionNone;
    [self.liveView sendDanmaku:danmaku];
}

#pragma mark RCInputBarControlDelegate

/**
 *  根据inputBar 回调来修改页面布局，inputBar frame 变化会触发这个方法
 *
 *  @param frame    输入框即将占用的大小
 *  @param duration 时间
 */
- (void)onInputBarControlContentSizeChanged:(CGRect)frame withAnimationDuration:(CGFloat)duration andAnimationCurve:(UIViewAnimationCurve)curve{

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
    liveVCell.liftNameLabel.hidden = YES;
    
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    
    
    RCMessageContent *content = model.content;
    if ([content isMemberOfClass:[RCInformationNotificationMessage class]]) {
//        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)content;
//        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
//        liveVCell.nameLabel.text = localizedMessage;
    }else if ([content isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *notification = (RCTextMessage *)content;
        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = [NSString stringWithFormat:@"%@:",content.senderUserInfo.name];
        }
        NSString *str =[NSString stringWithFormat:@"%@   %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:([UIColor blackColor]) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:([UIColor blackColor]) range:[str rangeOfString:localizedMessage]];
        liveVCell.nameLabel.attributedText = attributedString.copy;
    }else if ([content isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)content;
        [liveVCell.headImage sd_setImageWithURL:[NSURL  URLWithString:content.senderUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"占位图"]];

        NSString *name=@"";
        if (content.senderUserInfo) {
            name = content.senderUserInfo.name;
        }
        NSString *localizedMessage =[NSString stringWithFormat:@"送了一个%@",_giftName] ;
        if(notification && [notification.type isEqualToString:@"1"]){
            localizedMessage = @"为主播点了赞";
        }
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
        liveVCell.nameLabel.attributedText = attributedString.copy;
        
    }else if ([content isMemberOfClass:[NYNMessageContent class]]){
         NYNMessageContent *notification = (NYNMessageContent *)content;
        liveVCell.nameLabel.text = notification.msg;
        [liveVCell.headImage sd_setImageWithURL:[NSURL URLWithString:content.senderUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
    }else if ([content isMemberOfClass:[NYNLiveGiftMessege class]]){
        NYNLiveGiftMessege *notification = (NYNLiveGiftMessege *)content;
        [liveVCell.headImage sd_setImageWithURL:[NSURL  URLWithString:content.senderUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = content.senderUserInfo.name;
        }
        NSURL *url = [NSURL URLWithString: notification.content];// 获取的图片地址
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
        
        //生成文本附件
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = image;
          attch.bounds = CGRectMake(0, 0, 40, 40);
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        
        NSString *localizedMessage =[NSString stringWithFormat:@"送了一个"] ;
     
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
        //拼接字符串
        [attributedString appendAttributedString:string];
        
        liveVCell.nameLabel.attributedText = attributedString.copy;

    }
    
    return liveVCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, SCREENWIDTH, 50)];
    NSString * str = [NSString stringWithFormat:@"网农公社：欢迎来到%@，你可以观看直播,还可以尽情选购哟",_farmName];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0] range:NSMakeRange(0, 5)];
    titleLabel.attributedText = string;
    //自动换行
    titleLabel.numberOfLines=0;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [view addSubview:titleLabel];
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
    
}



-(void)initiaChatRoom{
    __weak FarmChatViewController * weakself = self;
    
    //聊天室类型进入时需要调用加入聊天室接口，退出时需要调用退出聊天室接口
    if (ConversationType_CHATROOM == self.conversationType) {
        [[RCIMClient sharedRCIMClient]
         joinChatRoom:self.targetId
         messageCount:10
         success:^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 //                 UserInfoModel *jzUserModel = userInfoModel;
             //    RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
//                 joinChatroomMessage.message = [NSString stringWithFormat: @"%@加入了聊天室",jzUserModel.name];
                // [self sendMessage:joinChatroomMessage pushContent:nil];
                 
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
    messageContent.senderUserInfo.name = userInfoModel.name;
    messageContent.senderUserInfo.portraitUri = userInfoModel.avatar;

    messageContent.senderUserInfo.userId = userInfoModel.ID;

    if (messageContent == nil) {
        return;
    }
    
    if ([messageContent isKindOfClass:[NYNTextMessage class]]) {
        
        
        
        [[RCIMClient sharedRCIMClient]sendMessage:self.conversationType targetId:_zhuboId content:messageContent pushContent:nil pushData:nil success:^(long messageId) {
            NSLog(@"发送成功。当前消息ID：%ld", messageId);
        } error:^(RCErrorCode nErrorCode, long messageId) {
            NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
        }];
        
        
    }else{
        self.conversationType = ConversationType_CHATROOM;
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
 *  注册监听Notification
 */
- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCDLiveKitDispatchMessageNotification
     object:nil];
    //刷新界面
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:@"reloadPalyer"
     object:nil];
}
/**
 *  接收到消息的回调Ø
 *Ï
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"reloadPalyer"]) {
        ZWPullMenuModel * model = [[ZWPullMenuModel alloc]init];
        model = notification.userInfo[@"model"];
        self.targetId = model.farmId;
        [self.conversationDataRepository removeAllObjects];
        [self.tableView reloadData];
        [self initiaChatRoom];
    }else if ([notification.name isEqualToString:RCDLiveKitDispatchMessageNotification]) {
        __block RCMessage *rcMessage = notification.object;
        RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
//        RCUserInfo * info = [[RCUserInfo alloc]initWithUserId:model.senderUserId name:nil portrait:nil];
        NSDictionary *leftDic = notification.userInfo;
        if (leftDic && [leftDic[@"left"] isEqual:@(0)]) {
            //       self.isNeedScrollToButtom = YES;
        }
        if (model.conversationType == self.conversationType &&
            [model.targetId isEqual:self.targetId]) {
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
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary * dict = @{@"text":[(NYNMessageContent*)rcMessage.content msg] };
                        //发送弹幕显示通知，
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"danmuNotification" object:nil userInfo:dict];                    });
                }
             
            }
            
        }
        
//        //接收主播端接受连麦请求
//        if ([rcMessage.content isKindOfClass:[NYNTextMessage class]]) {
//            NSString * url =[(NYNTextMessage*)rcMessage.content content];
//            NSRange  userUrl = [url rangeOfString:@","];
//            NSString *result = [url substringWithRange:userUrl];
//            
//      
//
//            NYNTextMessage * textMessege = [[NYNTextMessage alloc]init];
//            //type为3表示连麦成功，发送群消息通知每个用户显示双屏操作
//            textMessege.type =3;
//            textMessege.targetId= _targetId;
//            textMessege.content = result;
//            self.conversationType = ConversationType_CHATROOM;
//            
//            textMessege.time =  [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
//            [self sendMessage:textMessege pushContent:nil];
//            
//        }
        
        
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
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
//        [self.tableView reloadData];
    }
}
#pragma mark - 输入框事件
/**
 *  点击键盘回车或
 *
 *  @param text  输入框的内容
 */
- (void)onTouchSendButton:(NSString *)text{
  
//    RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:text];
//    [self sendMessage:rcTextMessage pushContent:nil];
    if (text.length<1) {
        [self showTextProgressView:@"发送内容不能为空"];
         [self.inputBar setHidden:YES];
        [self hideLoadingView];
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
//        [self sendDanmaku:messegeContetnt.msg];
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
        [self.tableView reloadData];
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
        //退出聊天室
        [[RCIMClient sharedRCIMClient] quitChatRoom:self.targetId
                                            success:^{
                                                [[NSNotificationCenter defaultCenter] removeObserver:self];
                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    self.tableView.dataSource = nil;
//                                                    self.tableView.delegate = nil;
                                                });
                                                
                                            } error:^(RCErrorCode status) {
                                                
                                            }];
    }
}

/**
 *  消息滚动到底部
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToBottomAnimated:(BOOL)animated {
    if ([self.tableView numberOfSections] == 0) {
        return;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    giftView.hidden= YES;
    self.inputBar.hidden = YES;
    
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2-30) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource  =self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
        
        
        
    }
    return _tableView;
    
}
-(LiveMessegeBoomVIew *)liveView{
    if (!_liveView) {
        _liveView = [[LiveMessegeBoomVIew alloc]init];
        _liveView.backgroundColor = [UIColor whiteColor];
        [_liveView.speakButton setTitleColor:Color686868 forState:UIControlStateNormal];
        [_liveView.giftButton setImage:[UIImage imageNamed:@"gift拷贝2"] forState:UIControlStateNormal];
          [_liveView.goodButton setImage:[UIImage imageNamed:@"zan拷贝2"] forState:UIControlStateNormal];
        
    }
    return _liveView;
    
}

@end
