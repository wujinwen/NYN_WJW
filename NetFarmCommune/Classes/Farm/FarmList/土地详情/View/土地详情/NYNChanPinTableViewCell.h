//
//  NYNChanPinTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNChanPinTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
