//
//  NYNZhongZhiNewFangAnViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNChuShiHuaModel.h"

typedef void(^FangAnDataBack)(NSMutableArray *arr,int cycleTime,NSString * title);
@interface NYNZhongZhiNewFangAnViewController : BaseViewController
@property (nonatomic,copy) FangAnDataBack fangAnDataBack;

@property (nonatomic,strong) NYNChuShiHuaModel *chuShiHuaModel;
//就是种子的数量
@property (nonatomic,assign) int yangZhiCount;
@property(nonatomic,assign)int zhongzhiTime;//周期


@end
