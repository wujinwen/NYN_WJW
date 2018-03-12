//
//  NYNAiJuanTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNAiJuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UILabel *shouJianRenLabel;
@property (weak, nonatomic) IBOutlet UILabel *dianHuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
