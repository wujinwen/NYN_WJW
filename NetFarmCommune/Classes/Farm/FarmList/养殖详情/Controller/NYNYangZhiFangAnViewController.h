//
//  NYNYangZhiFangAnViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNYangZhiFangAnModel.h"
#import "NYNChuShiHuaModel.h"

typedef void(^BackDataModel)(NYNChuShiHuaModel *model);
@interface NYNYangZhiFangAnViewController : BaseViewController
@property (nonatomic,assign) int yangZhiCount;

@property (nonatomic,copy) BackDataModel modelBack;


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NYNChuShiHuaModel *chuShiHuaModel;


@property(nonatomic,assign)int  yangzhiTime;

@property(nonatomic,strong)NSString * farmingId;

@end
