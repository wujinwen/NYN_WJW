//
//  NYNNewTaskTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMyFarmTaskHistoryModel.h"

@interface NYNNewTaskTableViewCell : UITableViewCell
@property (nonatomic,strong) NYNMyFarmTaskHistoryModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fabuLabel;
@property (weak, nonatomic) IBOutlet UILabel *shifeiLabel;
@end
