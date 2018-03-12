//
//  NYNEarthDetailTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNEarthDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaoTiLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeight;

@end
