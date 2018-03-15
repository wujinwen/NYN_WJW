//
//  RestaurantUIViewController.h
//  NYNTest
//
//  Created by wzw on 18/3/14.
//  Copyright © 2018年 TF. All rights reserved.
//  餐饮
#import "PersonalCenterChildBaseVC.h"
#import <UIKit/UIKit.h>

@interface RestaurantUIViewController : PersonalCenterChildBaseVC
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *categoryId; //农产品：71
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
-(void)getDataFarmIDString:(NSString*)str;
@end
