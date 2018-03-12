//
//  NYNJiaoShuiCiShuViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickBack)(NSMutableArray *chooseArr,NSMutableArray *chooseDataArr);
@interface NYNJiaoShuiCiShuViewController : BaseViewController
//0 浇水  1  施肥
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) ClickBack clickBack;
//@property
@property (nonatomic,strong) NSMutableArray *monthArr;
@end
