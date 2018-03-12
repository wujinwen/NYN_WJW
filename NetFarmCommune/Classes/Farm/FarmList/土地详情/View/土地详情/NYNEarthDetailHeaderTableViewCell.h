//
//  NYNEarthDetailHeaderTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface NYNEarthDetailHeaderTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;
@property (nonatomic,copy) NSMutableArray *urlImages;
@end
