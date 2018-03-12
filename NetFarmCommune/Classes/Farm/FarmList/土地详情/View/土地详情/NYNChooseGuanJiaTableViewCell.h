//
//  NYNChooseGuanJiaTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNChooseGuanJiaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nianLingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nianLingImageVIEW;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contengHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@end
