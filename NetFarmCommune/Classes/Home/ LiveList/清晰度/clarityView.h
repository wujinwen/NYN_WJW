//
//  clarityView.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义选择代理
@protocol clarityViewDelagate< NSObject>

//为防止后期又改，按钮点击时间单独写
//标清
-(void)BDBtnClickEvent:(UIButton*)sender;
//高清
-(void)HDBtnClickEvent:(UIButton*)sender;

//超清
-(void)SHBTNClickEvent:(UIButton*)sender;

@end

@interface clarityView : UIView
@property(nonatomic,weak)id<clarityViewDelagate>delagate;
@end
