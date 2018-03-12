//
//  NYNMeNongChangTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNFarmCellModel.h"
#import "NYNCollectionFarmModel.h"


@interface NYNMeNongChangTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *starArray;


@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UIImageView *cellTypeImageView;
@property (nonatomic,strong) UILabel *cellAddressLabel;
@property (nonatomic,strong) UILabel *cellkucunLabel;
@property (nonatomic,strong) UILabel *cellpinglunLabel;
@property (nonatomic,strong) UILabel *celljuliLabel;

@property (nonatomic,strong) NYNCollectionFarmModel *model;

@property (nonatomic,assign) int starCount;
@end
