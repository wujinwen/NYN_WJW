//
//  NYNWantZhongZhiViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNXuanZeZhongZiModel.h"
#import "NYNMeAddressModel.h"
#import "NYNQueRenDingDanViewController.h"

@interface NYNWantZhongZhiViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray *seedArr;
@property (nonatomic,copy) NSString *farmID;
@property (nonatomic,copy) NSString *earthPriceStr;
@property (nonatomic,copy) NSString *earthID;
@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;

//当前选中的种子
@property (nonatomic,strong) NSMutableArray *fangAnDicArr;


- (void)changeSeed;
@end
