//
//  NYNMessageContent.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>


/*!
 通知消息的类型名
 */
#define InformationNotificationMessageIdentifier @"app:TextTimeMsg"


@interface NYNMessageContent : RCMessageContent


//消息内容
@property(nonatomic,strong)NSString * msg;

//弹幕
@property(nonatomic,assign)BOOL isDanmu ;

//时间戳
@property(nonatomic,strong)NSString * time;

//直播间的Id
@property(nonatomic,strong)NSString * targetName;





@end
