//
//  NYNGroupTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GrounpModel.h"

@interface NYNGroupTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimage;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property(nonatomic,strong)GrounpModel * moedel;


@end
