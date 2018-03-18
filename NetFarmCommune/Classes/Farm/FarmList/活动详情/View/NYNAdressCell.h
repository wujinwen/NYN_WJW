//
//  NYNAdressCell.h
//  NetFarmCommune
//
//  Created by ff on 2018/3/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNActivityModel.h"

@interface NYNAdressCell : UITableViewCell
@property (nonatomic, strong) UILabel *adressLab;
@property (nonatomic, strong) UILabel *disLab;

@property (nonatomic, strong) NYNActivityModel *model;
@end
