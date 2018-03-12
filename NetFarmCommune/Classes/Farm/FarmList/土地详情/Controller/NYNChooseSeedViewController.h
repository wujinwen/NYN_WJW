//
//  NYNChooseSeedViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNXuanZeZhongZiModel.h"


typedef void(^ChooseSeedBack)(NYNXuanZeZhongZiModel *model);
@interface NYNChooseSeedViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray *seedArr;
@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;
@property (nonatomic,copy) ChooseSeedBack seedBack;
@end
