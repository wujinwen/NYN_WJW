//
//  LiveMessegeBoomVIew.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^liftClickBlck)();

typedef void(^CommentClickBlck)();

typedef void(^ZanClickBlck)();


typedef void(^LianmaiClickBlck)();

@interface LiveMessegeBoomVIew : UIView

@property(nonatomic,strong)UIButton * speakButton;
@property(nonatomic,strong)UIButton * giftButton;
@property(nonatomic,strong)UIButton * goodButton;


@property(nonatomic,strong)UIButton * lianmaiButton;


@property (nonatomic,copy) liftClickBlck liftClick;

@property (nonatomic,copy) CommentClickBlck commentClick;

@property (nonatomic,copy) ZanClickBlck zanClick;
@property (nonatomic,copy) LianmaiClickBlck lianmaiClick;
@end
