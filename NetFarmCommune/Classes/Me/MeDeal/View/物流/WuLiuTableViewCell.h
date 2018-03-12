//
//  WuLiuTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuLiuTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//地址

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UIView *smartCyclView;

@property(nonatomic,strong)NSMutableDictionary * expressArray;
@end
