//
//  FTWisdomFarmViewController.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "BaseViewController.h"

@interface FTWisdomFarmViewController : BaseViewController
@property (nonatomic,copy) NSString *ID;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@property (nonatomic,copy) NSString *ctype;
@end
