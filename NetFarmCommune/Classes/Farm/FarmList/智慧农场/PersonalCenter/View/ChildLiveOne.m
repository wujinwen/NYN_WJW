//
//  ChildLiveOne.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ChildLiveOne.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import "RCDLiveGiftMessage.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "Masonry.h"


#import "ZWPullMenuView.h"

#import "UIView+RCDDanmaku.h"
#import "RCDDanmaku.h"
#import "RCDDanmakuManager.h"


#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"
#import "RCDLive.h"
//#import "NYNLiveGiftMessege.h"
#import "FullScreenView.h"
#import<Masonry/Masonry.h>
#import "AppDelegate.h"
#import "ControlView.h"
@interface ChildLiveOne ()<YfFFMoviePlayerControllerDelegate,FullScreenViewDelagate>
{
    NSMutableArray * listModeArr;
    UITapGestureRecognizer * tapGes;
    AppDelegate *appdelegate;
       ControlView                  *controlView;
}


@property(nonatomic,strong)UIButton * pauseBtn;//暂停按钮

@property(nonatomic,strong)UIButton * startLive;//发起直播

@property(nonatomic,strong)UIButton * listLive;//直播列表


@property(nonatomic,strong)UIButton * quanpingBtn;//全屏模式

@property(nonatomic,strong)UIImageView * locationImgae;//地址图
@property(nonatomic,strong)UILabel * livecontent;//直播内容


@property(nonatomic,strong)UIButton * phoneBtuuon;//电话按钮

@property(nonatomic,strong)NSString * farmLiveId;
@property (nonatomic, strong) UIView * danmuView;//弹幕视图
@property(nonatomic,strong)FullScreenView * fullView;

/**
 是否横屏
 */
@property (nonatomic, assign) BOOL isHeng;


@end

@implementation ChildLiveOne


-(instancetype)initWithFrame:(CGRect)frame url:(NSString *)url{
    self = [super initWithFrame:frame];
    if (self) {
        _playUrl = url;
        [self initiaInterface];

    }
    return self;
    
}
-(void)initiaInterface{
    UIColor * color = [UIColor lightGrayColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.7];
    
    
    //[self addSubview:self.videoView];

    //接受发送礼物成功方法
    [self registerNotification];
    
    //接收本地礼物通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GiftListNotification:) name:@"GiftListNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(danmuNotification:) name:@"danmuNotification" object:nil];
    _danmuView  = [[UIView alloc]init];
    
    //    _danmuView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_danmuView];
    [_danmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    

    
}
-(void)getLiveUrlWith:(NSString *)playUrl{
    NSLog(@"播放url");
}
- (void)didAddSubview:(UIView *)subview{
            [controlView updatePlayTimeOnMainThread];
      [self.player play];
       [controlView updatePlayTimeOnMainThread];

}
//移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
//移除view后调用
- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
    //释放视频
//    [self.player shutdown];
   [self.player pause];
       [controlView shutdownUpdatePlayTimeOnMainThread];
//    self.player = nil;
}







//全屏切换手势op

-(void)playerTapGes:(UITapGestureRecognizer*)tap{
    _videoView.transform = CGAffineTransformMakeRotation(0);
    _videoView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(150));
    [_videoView removeGestureRecognizer:tapGes];
    _listLive.hidden = NO;
    _startLive.hidden = NO;
    
    _quanpingBtn.hidden = NO;
//    [self.delegate playerTapGesDelagete:tap];

    _locationImgae.hidden = NO;
    _locationLabel.hidden = NO;
    _livecontent.hidden = NO;
    
}

-(void)getDataWith:(NSString *)farmLiveID{
    _farmLiveId = farmLiveID;
    //[self getFarmLiveInfoData];

}

-(void)danmuNotification:(NSNotification*)notification{
    
    
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:notification.userInfo[@"text"] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    danmaku.position = RCDDanmakuPositionNone;
    [self sendDanmaku:danmaku];
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





/**
 *  注册监听Notification
 */
- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCDLiveKitDispatchMessageNotification object:nil];
}


/**
 *  接收到消息的回调
 *
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    

    
    
}
//发起直播
- (void)startLiveClick:(UIButton*)btn{
    //释放视频
//    [self.player shutdown];
//    self.player = nil;
      [self.player pause];
    [self.delegate startLiveDelagate:btn];
    
}
//初始化UI
-(void)initiaUI{
    [self addSubview:self.startLive];
    [self.listLive addTarget:self action:@selector(listLiveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.listLive];
    
    
    [_startLive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-50);
        make.width.mas_offset(80);
        make.height.mas_offset(27);
        make.left.mas_offset(10);
        
    }];
    
    [_listLive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-50);
        make.width.mas_offset(80);
        make.height.mas_offset(27);
        make.left.mas_equalTo(_startLive.mas_right).offset(10);

    }];

    
    [self addSubview:self.quanpingBtn];
    [_quanpingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-50);
        
        
    }];
    [self addSubview:self.locationImgae];
    [_locationImgae mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(10);
        make.height.mas_offset(14);
        make.bottom.mas_offset(-15);
        make.height.mas_offset(20);
        
    }];
    
    [self addSubview:self.locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_locationImgae.mas_right).offset(10);
        make.height.mas_offset(30);
        make.bottom.mas_offset(-5);

        
    }];
    [self addSubview:self.livecontent];
    [_livecontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_locationLabel.mas_right).offset(10);
        make.bottom.mas_offset(-5);
        make.height.mas_offset(30);
        
        
    }];
    
    [self addSubview:self.phoneBtuuon];
    [_phoneBtuuon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.width.height.mas_offset(25);
        make.bottom.mas_offset(-7);
        
    }];
    
    
    
    

}
//电话按钮
-(void)phoneBtuuonClick:(UIButton*)sender{
    if (self.delegate) {
        [self.delegate telphone];
    }
}




//直播列表
-(void)listLiveClick:(UIButton*)sender{
    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"10",@"orderType":@"multiple",@"farmId":_targetId};
    
    [NYNNetTool PostLiveListWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        ZWPullMenuModel * model = [[ZWPullMenuModel alloc]init];

        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NSMutableArray * arr = [NSMutableArray array];
            
            if ([success[@"data"] count] < 1) return ;
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                model = [ZWPullMenuModel mj_objectWithKeyValues:dic];
                //判断bool加载cell
                model.isCell = YES;
                [arr addObject:model];
            }
            listModeArr = [arr mutableCopy];
            
            ZWPullMenuView * menuView = [ZWPullMenuView pullMenuAnchorView:sender menuArray:listModeArr];
            menuView.zwPullMenuStyle = PullMenuLightStyle;
            
            
             __weak typeof(self) weakSelf = self;
            menuView.blockSelectedMenu=^(NSInteger menuRow){
                //重新获取流地址，先将播放器clean，否则会出现重影
                [weakSelf.player clean];
                [weakSelf.player play:[NSURL URLWithString:[listModeArr[menuRow] rtmpPull]] useDns:NO useSoftDecode:NO DNSIpCallBack:nil appID:"" refer:"" bufferTime:3];
                //通知其他页面刷新
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadPalyer" object:nil userInfo:@{@"model":listModeArr[menuRow]}];

            };

        }else{
            
        }
        NSLog(@"");
    } failure:^(NSError *failure) {
  
    }];
}




//全屏放大
-(void)quanpingBtn:(UIButton*)sender{
    //先给appdelegate赋值
    appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"宽 ---%f高---%f", _player.naturalSize.width,_player.naturalSize.height);
    
    
   [self.delegate quanpingBtnDelagate:sender];
    
    _listLive.hidden = YES;
    _startLive.hidden = YES;
    _quanpingBtn.hidden = YES;
    _livecontent.hidden = YES;
    _locationLabel.hidden = YES;
    _locationImgae.hidden = YES;
    _phoneBtuuon.hidden  =YES;
    
    
    _fullView = [[FullScreenView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _fullView.targetId=_targetId;
    _fullView.zhuboId =_zhuboId;
    _fullView.delagate = self;

    
//    [fullView getScreenLiveUrlWith:_playUrl];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_fullView];
    //判断宽高。如果宽>高则为横屏显示，否则为竖屏显示
    if (_player.naturalSize.width > _player.naturalSize.height) {
        appdelegate.isHengping=YES;
              _fullView.liveId =_liveId;
        
        if (appdelegate.isHengping) {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
             [_fullView getLiveIdDataStr:_liveId isVertical:YES];
              _fullView.isLevel =YES;
         
        }else {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
             [_fullView getLiveIdDataStr:_liveId isVertical:NO];
              _fullView.isLevel =NO;
        }
         _videoView1.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [_fullView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_offset(0);
            
        }];
        
//           _fullView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
//        //反射动画
//        _fullView.transform =CGAffineTransformIdentity;
//        [UIView animateWithDuration:1.0f animations:^{
//            //旋转状态栏
//            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
//            _fullView.transform = CGAffineTransformMakeRotation(M_PI_2);
//            _fullView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
//            _videoView1.transform = CGAffineTransformMakeRotation(M_PI_2);
//            _videoView1.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
//
//            [_fullView getLiveIdDataStr:_liveId isVertical:YES];
//            [self keyboard];
//
//        }];
//
    }else{
        _videoView1.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
            [_fullView getLiveIdDataStr:_liveId isVertical:NO];
           _fullView.isLevel =NO;
    }
    
   

}

-(void)attentionBtnClick{
    

}
//退出全屏
-(void)exitFullScreenClick{
    _listLive.hidden = NO;
    _startLive.hidden = NO;
    _quanpingBtn.hidden = NO;
    _livecontent.hidden = NO;
    _locationLabel.hidden = NO;
    _locationImgae.hidden = NO;
     _phoneBtuuon.hidden  =NO;
     [self.delegate playerTapGesDelagete];
    
    //隐藏view
    _fullView.hidden = YES;
    //判断宽高。如果宽>高则为横屏显示，否则为竖屏显示
    if (_player.naturalSize.width > _player.naturalSize.height) {

        appdelegate.isHengping=NO;
        
        if (appdelegate.isHengping) {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
            [_fullView getLiveIdDataStr:_liveId isVertical:YES];
            _fullView.isLevel =YES;
            
        }else {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
            [_fullView getLiveIdDataStr:_liveId isVertical:NO];
                _fullView.isLevel =NO;
        }
        
        
        _fullView.liveId =_liveId;
    
  
    }else{
     //   _videoView1.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(200));
        
    }
    
    [_videoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_offset(JZHEIGHT(200));

    }];
    
    
    //反射动画
    //        _fullView.transform =CGAffineTransformIdentity;
    //        [UIView animateWithDuration:1.0f animations:^{
    //            _videoView1.transform = CGAffineTransformMakeRotation(M_PI_2);
    ////            _videoView1.frame = CGRectMake(0, 0, SCREENWIDTH,JZHEIGHT(200));
    //
    //        }];
    
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
}

- (void)playerStatusCallBackLoadingCanReadyToPlay:(YfFFMoviePlayerController *)player
{
    
    /*
     *加载完成 异步
     *
     */
    NSLog(@"异步加载完成");
    [controlView updatePlayTimeOnMainThread];
    
}
- (void)playerStatusCallBackLoading:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"-------------开始加载");
    NSLog(@"开始加载");

}

- (void)playerStatusCallBackLoadingSuccess:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"加载成功");
    //此处可以seek
    //    self.player.currentPlaybackTime = 14;
    //[player play];
    NSLog(@"加载成功");


}
- (void)playerStatusCallBackBufferingStart:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"开始缓冲");


}

- (void)playerStatusCallBackBufferingEnd:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"缓冲结束");
}

-(void)playerStatusCallBackPlayerPlayErrorType:(YfPLAYER_MEDIA_ERROR)errorType httpErrorCode:(int)httpErrorCode player:(YfFFMoviePlayerController *)player
{
    NSLog(@"播放错误");
    [self.player clean];
    [self.player play:[NSURL URLWithString:self.playUrl] useDns:NO useSoftDecode:NO DNSIpCallBack:nil appID:"" refer:"" bufferTime:3];
    
}
-(void)playerStatusCallBackPlayerPlayEnd:(YfFFMoviePlayerController *)player
{
    
    NSLog(@"播放结束");
    player.currentPlaybackTime = 0;
    [player play];
}

- (void)senderOutAudioData:(NSData *)audioData size:(size_t)audioDataSize player:(YfFFMoviePlayerController *)player {
    
}


- (void)willOutputPlayerRenderbuffer:(CVPixelBufferRef)renderbuffer player:(YfFFMoviePlayerController *)player {
    
}



-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(200))];
        _videoView.backgroundColor = [UIColor blackColor];
    }
    return _videoView;
    
}

-(UIButton *)pauseBtn{
    if (!_pauseBtn) {
        
    }
    return _pauseBtn;
    
}
-(UIButton *)startLive{
    if (!_startLive) {
        _startLive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startLive setTitle:@"发起直播" forState:UIControlStateNormal ];
        _startLive.titleLabel.font=[UIFont systemFontOfSize:12];
        UIColor * color = [UIColor whiteColor];
        _startLive.backgroundColor =[color colorWithAlphaComponent:0.5];
        [_startLive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startLive addTarget:self action:@selector(startLiveClick:) forControlEvents:UIControlEventTouchUpInside];
        _startLive.layer.cornerRadius=10;
        _startLive.clipsToBounds = YES;
        
    }
    return _startLive;
    
}

-(UIButton *)listLive{
    if (!_listLive) {
        _listLive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listLive setTitle:@"直播列表" forState:UIControlStateNormal ];
        _listLive.titleLabel.font=[UIFont systemFontOfSize:12];
        UIColor * color = [UIColor whiteColor];
        _listLive.backgroundColor =[color colorWithAlphaComponent:0.5];
        
        [_listLive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _listLive.layer.cornerRadius=10;
          _listLive.clipsToBounds = YES;
    }
    return _listLive;
    
}


-(UIButton *)quanpingBtn{
    if (!_quanpingBtn) {
        _quanpingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_quanpingBtn setImage:[UIImage imageNamed:@"quanping.png"] forState:UIControlStateNormal];
//        [_quanpingBtn setTitle:@"全屏" forState:UIControlStateNormal ];
        [_quanpingBtn setImage:[UIImage imageNamed:@"Fullscreen"] forState:UIControlStateNormal];
        
        [_quanpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _quanpingBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [_quanpingBtn addTarget:self action:@selector(quanpingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quanpingBtn;
    
}
-(UIImageView *)locationImgae{
    if (!_locationImgae) {
        _locationImgae = [[UIImageView alloc]init];
        _locationImgae.image = [UIImage imageNamed:@"farm_icon_address2"];
    }
    return _locationImgae;
    
}

-(UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]init];
        _locationLabel.text = @"花果山白果农场 >";
        _locationLabel.textColor = Color686868;
        _locationLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _locationLabel;
    
}

-(UILabel *)livecontent{
    if (!_livecontent) {
        _livecontent = [[UILabel alloc]init];
        _livecontent.textColor = [UIColor darkGrayColor];
        _livecontent.font = [UIFont systemFontOfSize:13];
        _livecontent.text =@"直播摘柚子";
        _livecontent.hidden = YES;
        
    }
    return _livecontent;
    
}

-(UIButton *)phoneBtuuon{
    if (!_phoneBtuuon) {
        _phoneBtuuon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtuuon setImage:[UIImage imageNamed:@"farm_icon_phone"] forState:UIControlStateNormal];
        [_phoneBtuuon addTarget:self action:@selector(phoneBtuuonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _phoneBtuuon;
    
}



@end
