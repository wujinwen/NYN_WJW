//
//  FuckPayViewController.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/31.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"

@interface FuckPayViewController : BaseViewController

@property (nonatomic,strong) NSString *totlePrice;
@property (nonatomic,strong) CustomModel* model;
@property (nonatomic,copy)   NSString *typeStr;

@end
