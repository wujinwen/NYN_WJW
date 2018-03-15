//
//  LodgeUIViewController.h
//  NYNTest
//
//  Created by wzw on 18/3/14.
//  Copyright © 2018年 TF. All rights reserved.
//  住宿
#import "PersonalCenterChildBaseVC.h"
#import <UIKit/UIKit.h>

@interface LodgeUIViewController : PersonalCenterChildBaseVC
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
-(void)getDataFarmIDString:(NSString*)str;
@end
