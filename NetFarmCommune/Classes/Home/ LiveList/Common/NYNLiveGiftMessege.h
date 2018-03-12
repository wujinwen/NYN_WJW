//
//  NYNLiveGiftMessege.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>

#define LiveGiftMessageIdentifier @"app:GiftMsg"
/* 点赞消息
 *
 * 对于聊天室中发送频率较高，不需要存储的消息要使用状态消息，自定义消息继承RCMessageContent
 * 然后persistentFlag 方法返回 MessagePersistent_STATUS
 */
@interface NYNLiveGiftMessege : RCMessageContent
//礼物ID
@property(nonatomic, assign) int  ID;

//礼物图片URL
@property(nonatomic, strong) NSString * content;
//礼物数量
@property(nonatomic, assign) int  count;

//直播间ID
@property(nonatomic, strong) NSString * targetName;

//当前时间
@property(nonatomic,strong)NSString * time;





@end
