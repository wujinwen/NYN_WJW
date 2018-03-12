//
//  FullScreenView.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/29.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCDLiveMessageModel.h"
#import "RCDLiveInputBar.h"
#import "LiveMessegeBoomVIew.h"

#import <YFMediaPlayerPushStreaming/YFMediaPlayerPushStreaming.h>

// 定义选择代理
@protocol FullScreenViewDelagate < NSObject>

//退出全屏
-(void)exitFullScreenClick;
-(void)attentionBtnClick;


@end

@interface FullScreenView : UIView

/*!
 当前会话的会话类型
 */

@property(nonatomic) RCConversationType conversationType;

@property(nonatomic,strong)NSString * targetId;

@property(nonatomic,strong)NSString * zhuboId;

@property(nonatomic,strong)LiveMessegeBoomVIew * liveView;//界面下方显示

@property (nonatomic, assign) CGFloat kbps;
@property (nonatomic, assign) CGFloat fps;
@property (nonatomic, strong) UIButton* attentionBtn;//关注按钮
/*!
 会话页面的CollectionView
 */
@property(nonatomic, strong) UICollectionView *conversationMessageCollectionView;
@property(nonatomic,assign)int isVertical;//判断是否为横竖屏，0为横屏1为竖屏

@property(nonatomic,assign)id<FullScreenViewDelagate>delagate;
/*!
 消息列表CollectionView和输入框都在这个view里
 */
@property(nonatomic, strong) UIView *contentView;

-(void)getLiveIdDataStr:(NSString*)string isVertical:(BOOL)isVertical;

/*!
 聊天内容的消息Cell数据模型的数据源
 
 @discussion 数据源中存放的元素为消息Cell的数据模型，即RCDLiveMessageModel对象。
 */
@property(nonatomic, strong) NSMutableArray<RCDLiveMessageModel *> *conversationDataRepository;

#pragma mark - 输入工具栏

@property(nonatomic,strong) RCDLiveInputBar *inputBar;

@property(nonatomic,assign)BOOL isLevel;

@property(nonatomic,strong)NSString * liveId;

@end
