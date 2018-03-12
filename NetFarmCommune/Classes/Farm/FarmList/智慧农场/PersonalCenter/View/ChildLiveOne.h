//
//  ChildLiveOne.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCDLiveMessageModel.h"
#import <YfMediaPlayer/YfMediaPlayer.h>

// 定义选择代理
@protocol ChildLiveOneDelagate < NSObject>

//开始直播按钮
-(void)startLiveDelagate:(UIButton*)sender;
//全屏切换按钮

-(void)quanpingBtnDelagate:(UIButton*)sender;
//退出全屏按钮
-(void)playerTapGesDelagete;

@end


@interface ChildLiveOne : UIView

@property(nonatomic,strong)NSString* liveId;
@property (nonatomic, strong) NSString *playUrl;

@property(atomic, retain) id<YfMediaPlayback> player;

/*!
 播放内容地址
 */
@property(nonatomic, strong) NSString *contentURL;

/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;

@property (nonatomic, strong) id <ChildLiveOneDelagate> delegate;

@property(nonatomic,strong)UIView * videoView;

@property(nonatomic,strong)UILabel * locationLabel;//地址名

//加载数据
- (void)getDataWith:(NSString *)farmLiveID ;

-(void)getLiveUrlWith:(NSString*)playUrl;

-(instancetype)initWithFrame:(CGRect)frame url:(NSString*)url;

@property(nonatomic,strong)UIView * videoView1;//临时view

@property(nonatomic,strong)NSString * zhuboId;//主播id全屏后使用


@property(nonatomic,assign)int isVertical;//横竖屏判断
-(void)initiaUI;



@end
