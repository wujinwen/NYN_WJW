//
//  NYNLeImgCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface NYNLeImgCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;
@property (nonatomic, strong) NSDictionary *dataDit;
@end
