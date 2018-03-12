//
//  NYNHomeViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^TiaoZhuan)(NSString *ss);
@interface NYNHomeViewController : BaseViewController
@property (nonatomic,copy) TiaoZhuan TiaoZhuan;
@end
