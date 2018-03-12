//
//  FarmChatViewController.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PersonalCenterChildBaseVC.h"
#import "RCDLiveMessageModel.h"
#import "RCDLiveInputBar.h"

@protocol SendGiftDelagate<NSObject>

@end


@interface FarmChatViewController : PersonalCenterChildBaseVC




@property (nonatomic, strong) UIView * danmuView;//弹幕视图

#pragma mark - 会话页面属性
//
@property(nonatomic,assign)id<SendGiftDelagate>delagate;


/*!
 当前会话的会话类型
 */

@property(nonatomic) RCConversationType conversationType;

/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;

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

//农场名
@property(nonatomic,strong)NSString * farmName;



@property(nonatomic,strong)NSString * zhuboId;


@end
