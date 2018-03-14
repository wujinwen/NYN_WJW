//
//  FTFarmProduceViewController.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//  农产品

#import "BaseViewController.h"
#import "PersonalCenterChildBaseVC.h"

typedef void(^DateUp)(NSString *ss);
@interface FTFarmProduceViewController : PersonalCenterChildBaseVC
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *categoryId; //农产品：71
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@property (nonatomic,copy) DateUp dateUp;
- (void)updateData;
@end
