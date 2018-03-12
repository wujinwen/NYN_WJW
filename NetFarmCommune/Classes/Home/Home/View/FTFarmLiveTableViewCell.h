//
//  FTFarmLiveTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^activitySelectClick)(NSInteger selectCount);


@interface FTFarmLiveTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *textArr;

@property(nonatomic,strong)NSMutableArray * totalArr;
@property (nonatomic,copy) activitySelectClick activityClick;

@end
