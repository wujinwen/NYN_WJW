//
//  NYNZhongZhiFangAnViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNXuanZeZhongZiModel.h"


typedef void(^BBBlock)(double price,NSString *type,NSMutableArray *mArr);

@interface NYNZhongZhiFangAnViewController : BaseViewController
//当前选中的种子
@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;

@property (nonatomic,copy) NSString *zhongZhiZhouQi;
@property (nonatomic,copy) BBBlock bbblock;


@property (nonatomic,copy) NSString *fangAnXiangID;
@end
