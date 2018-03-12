//
//  FTFarmListTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNFarmCellModel.h"

@interface FTFarmListTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *starArray;


@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UIImageView *cellTypeImageView;
@property (nonatomic,strong) UILabel *cellAddressLabel;
@property (nonatomic,strong) UILabel *cellkucunLabel;
@property (nonatomic,strong) UILabel *cellpinglunLabel;
@property (nonatomic,strong) UILabel *celljuliLabel;

@property (nonatomic,strong) NYNFarmCellModel *model;

@property (nonatomic,assign) int starCount;
@end
