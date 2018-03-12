//
//  NYNMeNongJiaLeTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NYNCategoryPageModel.h"
#import "NYNMeShouCangModel.h"
#import "NYNCollectionFarmModel.h"

@interface NYNMeNongJiaLeTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *kucun;
@property (nonatomic,strong) UILabel *pinglun;
@property (nonatomic,strong) UILabel *juli;
@property (nonatomic,strong) UILabel *unitPriceLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) NYNCollectionFarmModel *model;

@property (nonatomic,strong) UIView *viewOne;
@property (nonatomic,strong) UIView *viewTwo;

@property (nonatomic,strong) NSMutableArray *starArray;
@property (nonatomic,assign) int starCount;

@end
