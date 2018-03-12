//
//  NYNMaiBaiCaiView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^jianBlcok) (int nowCount);//1
typedef void(^jiaBlcok) (int nowCount);//1
typedef void(^actionBlcok) (int nowCount);//1


@interface NYNMaiBaiCaiView : UIView
@property (nonatomic,copy)jianBlcok jianCallBackBlock;//2
@property (nonatomic,copy)jiaBlcok jiaCallBackBlock;//2
@property (nonatomic,copy)actionBlcok actionBlcok;//2

@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *moneyLB;

@property (nonatomic,assign) int nowCount;
@end
