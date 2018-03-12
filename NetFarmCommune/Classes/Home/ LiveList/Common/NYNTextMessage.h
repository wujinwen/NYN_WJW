//
//  NYNTextMessage.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

#define LianmaiMessageIdentifier @"app:NotiMsg"

@interface NYNTextMessage : RCMessageContent


//直播流地址
@property(nonatomic, strong) NSString * content;
//类型
@property(nonatomic, assign) int  type;
//时间
@property(nonatomic, strong) NSString * time;


//
@property(nonatomic,strong)NSString * targetId;
@end
