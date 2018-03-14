//
//  FTFarmProduceTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//  农产品cell

#import <UIKit/UIKit.h>
#import "NYNCategoryPageModel.h"

@interface FTFarmProduceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *kucun;
@property (nonatomic,strong) UILabel *pinglun;
@property (nonatomic,strong) UILabel *juli;
@property (nonatomic,strong) UILabel *unitPriceLabel;
@property (nonatomic,strong) UILabel *monthSalesLabel;

@property (nonatomic,strong) NYNCategoryPageModel *model;

@property (nonatomic,strong) UIView *viewOne;
@property (nonatomic,strong) UIView *viewTwo;
@end
