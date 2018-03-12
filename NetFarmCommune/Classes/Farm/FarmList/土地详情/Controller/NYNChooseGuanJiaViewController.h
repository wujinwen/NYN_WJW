//
//  NYNChooseGuanJiaViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNGuanJiaModel.h"

typedef void(^GuanJiaBlcok)(NYNGuanJiaModel *model);

@interface NYNChooseGuanJiaViewController : BaseViewController
@property (nonatomic,copy) NSString *farmID;
@property (nonatomic,copy) GuanJiaBlcok guanJiaBlcok;
@end
