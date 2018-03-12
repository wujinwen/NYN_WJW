//
//  NYNYangZhiBuyActionTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^clickBlock)(int str);
@interface NYNYangZhiBuyActionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *jianImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIImageView *jiaImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,copy) clickBlock selectClick;
@property (nonatomic,assign) int count;
@end
