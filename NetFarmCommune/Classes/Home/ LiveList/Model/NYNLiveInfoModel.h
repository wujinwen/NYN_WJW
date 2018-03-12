//
//  NYNLiveInfoModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNLiveInfoModel : NSObject


@property(nonatomic,assign)int liveid;

@property(nonatomic,strong)NSString * title;//直播间名称

@property(nonatomic,strong)NSString * pimg;//

@property(nonatomic,assign)int  farmId;//

@property(nonatomic,strong)NSString * farmTitle;//农场Id在监控直播时可用

@property(nonatomic,strong)NSString * rtmpPush;//农场名称

@property(nonatomic,strong)NSString * rtmpPull;//直播间名称

@property(nonatomic,strong)NSString * intro;//直播间介绍

@property(nonatomic,strong)NSString * type;//

@property(nonatomic,strong)NSString*  currentMember;//当前在线人数

@property(nonatomic,assign)int  popurlar;//人气

@property(nonatomic,strong)NSString * userName;//主播

@property(nonatomic,strong)NSString * avatar;//头像

@property(nonatomic,assign)BOOL  hasCollection;//是否已经关注

@property(nonatomic,strong)NSMutableArray * hotFans;


@property(nonatomic,strong)NSString * giftName;//礼品名称
@property(nonatomic,strong)NSString * giftImg;//礼品图标
@property(nonatomic,assign)NSString * count;//礼品数量
@property(nonatomic,assign)NSString * giftId;//礼品ID







@end
