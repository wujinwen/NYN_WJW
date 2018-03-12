//
//  NYNMeAddressTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMeAddressModel.h"

typedef void(^Click)(NSString *type,NSIndexPath *indexpath);
@interface NYNMeAddressTableViewCell : UITableViewCell
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) Click click;
@property (nonatomic,strong) NYNMeAddressModel *model;

@property (nonatomic,strong) UILabel *shouHuoRenLabel;
@property (nonatomic,strong) UILabel *dianhuaLabel;
@property (nonatomic,strong) UILabel *dizhiLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;


@end
