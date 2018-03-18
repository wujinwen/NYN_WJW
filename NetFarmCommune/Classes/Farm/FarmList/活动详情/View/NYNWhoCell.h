//
//  NYNWhoCell.h
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNActivityModel.h"

@interface NYNWhoCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) NYNActivityModel *model;
@end
