//
//  FTUserInfoTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface FTUserInfoTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *sexImageView;
@property (nonatomic,strong) UserInfoModel *userModel;
@property (nonatomic,strong) UILabel *levelLabel;

@property (nonatomic,strong) UIButton *goMeInfo;
@end
