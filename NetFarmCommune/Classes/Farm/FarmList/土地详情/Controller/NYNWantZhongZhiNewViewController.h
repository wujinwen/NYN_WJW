//
//  NYNWantZhongZhiNewViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNXuanZeZhongZiModel.h"

@interface NYNWantZhongZhiNewViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray *seedArr;
@property (nonatomic,copy) NSString *farmID;//种植养殖Id
@property (nonatomic,copy) NSString *earthPriceStr;
@property (nonatomic,copy) NSString *earthID;
@property (nonatomic,copy) NSString *earthUnit;

@property (nonatomic,copy) NSString *picName;

@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;


@end
