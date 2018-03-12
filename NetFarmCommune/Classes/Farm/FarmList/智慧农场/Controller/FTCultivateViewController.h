//
//  FTCultivateViewController.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalCenterChildBaseVC.h"

typedef void(^DateUp)(NSString *ss);
@interface FTCultivateViewController : PersonalCenterChildBaseVC
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,copy) DateUp dateUp;

- (void)updateData;
@end
