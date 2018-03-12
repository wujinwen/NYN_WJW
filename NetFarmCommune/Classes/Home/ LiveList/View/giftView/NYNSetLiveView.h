//
//  NYNSetLiveView.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义选择代理
@protocol NYNSetLiveViewDelagate< NSObject>

//为防止后期又改，按钮点击时间单独写
//横竖屏
-(void)screenSwitch:(UIButton*)sender;

//禁言列表
-(void)stopSpeakBtnClick:(UIButton*)sender;
//标清
-(void)BDBtnClick:(UIButton*)sender;


@end



typedef void(^BackClickBlck)();

@interface NYNSetLiveView : UIView
@property (nonatomic,copy) BackClickBlck backClick;


@property(nonatomic,weak)id<NYNSetLiveViewDelagate>delagate;



@end
