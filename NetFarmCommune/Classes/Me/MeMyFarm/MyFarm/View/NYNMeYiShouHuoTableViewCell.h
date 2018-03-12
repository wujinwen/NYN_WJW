//
//  NYNMeYiShouHuoTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMeFarmModel.h"

typedef void(^PingJiaBackBlock)(NSIndexPath* indexPath);

typedef void(^SuYuanBackBlock)(NSIndexPath* indexPath);

@interface NYNMeYiShouHuoTableViewCell : UITableViewCell
@property (nonatomic,strong) NYNMeFarmModel *model;


@property (nonatomic,strong) UIImageView *nongChangImageView;
@property (nonatomic,strong) UILabel *nongChangLabel;
@property (nonatomic,strong) UIImageView *chanPinImageView;
@property (nonatomic,strong) UILabel *tuDiMianJiCountLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *riqiLabel;
@property (nonatomic,strong) UILabel *zhuangTaiLabel;

@property (nonatomic,copy) SuYuanBackBlock suYuanBack;
@property (nonatomic,copy) PingJiaBackBlock pingJiaBack;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
