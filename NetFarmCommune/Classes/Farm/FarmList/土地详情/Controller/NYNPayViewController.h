//
//  NYNPayViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNDealModel.h"

@interface NYNPayViewController : BaseViewController
@property (nonatomic,strong) NSString *totlePrice;
@property (nonatomic,strong) NYNDealModel* model;
@property (nonatomic,copy)   NSString *typeStr;

@property(nonatomic,assign)BOOL selectBool;

@end
