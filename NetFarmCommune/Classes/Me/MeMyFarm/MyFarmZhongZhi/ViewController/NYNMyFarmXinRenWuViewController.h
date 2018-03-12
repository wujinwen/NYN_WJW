//
//  NYNMyFarmXinRenWuViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNChuShiHuaModel.h"

typedef void(^BackDataModel)(NYNChuShiHuaModel *model);

@interface NYNMyFarmXinRenWuViewController : BaseViewController
@property (nonatomic,copy) NSString *productId;



@property (nonatomic,assign) int yangZhiCount;

@property (nonatomic,copy) BackDataModel modelBack;


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NYNChuShiHuaModel *chuShiHuaModel;
@property (nonatomic,assign) int cycTime;
@property (nonatomic,copy) NSString *orderId;


@property (nonatomic,copy) NSString *typeStr;
@end
