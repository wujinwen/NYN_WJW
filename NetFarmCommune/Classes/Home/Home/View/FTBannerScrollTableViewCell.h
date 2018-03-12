//
//  FTBannerScrollTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNFarmCellModel.h"
#import "LQScrollView.h"

typedef void(^TapBacks)(NYNFarmCellModel *model);


@interface FTBannerScrollTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *bannerDataArr;
@property (nonatomic,strong) LQScrollView * lq;

@property (nonatomic,copy) TapBacks back;
@end
