//
//  MonitorLiveVC.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "RCDLiveMessageModel.h"

#import "RCDLiveInputBar.h"

@interface MonitorLiveVC : BaseViewController

@property(nonatomic,strong)NSString* liveId;
@property (nonatomic, strong) NSString *playUrl;

#pragma mark - 会话属性

/*!
 当前会话的会话类型
 */
@property(nonatomic) RCConversationType conversationType;
/*!
 屏幕方向
 */
@property(nonatomic, assign) BOOL isScreenVertical;

/*!
 播放内容地址
 */
@property(nonatomic, strong) NSString *contentURL;

/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;
#pragma mark - 会话页面属性

/*!
 聊天内容的消息Cell数据模型的数据源
 
 @discussion 数据源中存放的元素为消息Cell的数据模型，即RCDLiveMessageModel对象。
 */
@property(nonatomic, strong) NSMutableArray<RCDLiveMessageModel *> *conversationDataRepository;

#pragma mark - 输入工具栏

@property(nonatomic,strong) RCDLiveInputBar *inputBar;

/*!
 消息列表CollectionView和输入框都在这个view里
 */
@property(nonatomic, strong) UIView *contentView;

@property(nonatomic,strong)NSString * farmString;



@end
