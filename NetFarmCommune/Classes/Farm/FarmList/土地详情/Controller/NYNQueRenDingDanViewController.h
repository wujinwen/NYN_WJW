//
//  NYNQueRenDingDanViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNDealModel.h"

@interface NYNQueRenDingDanViewController : BaseViewController
@property (nonatomic,strong) NYNDealModel *model;
@property (nonatomic,copy) NSString *type;

@property (nonatomic,copy) NSString *picName;
@end
