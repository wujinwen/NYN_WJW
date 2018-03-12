//
//  ZhongZhiPlanVController.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/29.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomModel.h"


@interface ZhongZhiPlanVController : BaseViewController

//@property(nonatomic,strong)CustomModel * model;

@property(nonatomic,assign)NSInteger  styleString;//种植养殖类型判断，为了不想在建一个重复界面根据类型判断一下,500为种植，501为养殖，502位已收货

@property(nonatomic,strong)NSString* orderId;




@end
