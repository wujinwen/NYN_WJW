//
//  WuLiuOneTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WuLiuModel.h"
@interface WuLiuOneTableViewCell : UITableViewCell

@property(nonatomic,strong)WuLiuModel * model;
@property (weak, nonatomic) IBOutlet UILabel *oderSn;//订单编号

@property (weak, nonatomic) IBOutlet UILabel *oderTime;

@property (weak, nonatomic) IBOutlet UILabel *kuaidiTime;
@property (weak, nonatomic) IBOutlet UILabel *huoyunLabel;

@end
