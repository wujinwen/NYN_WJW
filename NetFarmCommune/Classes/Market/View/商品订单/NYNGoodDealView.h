//
//  NYNGoodDealView.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "NYNMarketListModel.h"
typedef void(^clickBlock)(int str);


@interface NYNGoodDealView : UIView<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;

@property(nonatomic,strong)NSArray * picArr;

@property (nonatomic,assign) int count;

@property (nonatomic,copy) clickBlock selectClick;
@property(nonatomic,strong)NYNMarketListModel * model;

@end
