//
//  TuiJianViewController.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/22.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^TiaoZhuan)(NSString *ss);
@interface TuiJianViewController : BaseViewController
@property (nonatomic,copy) TiaoZhuan TiaoZhuan;
@end
