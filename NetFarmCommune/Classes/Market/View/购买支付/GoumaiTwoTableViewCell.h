//
//  GoumaiTwoTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketListModel.h"
typedef void (^guanliBlock) (NSString *strValue);


@interface GoumaiTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//地址
@property (weak, nonatomic) IBOutlet UIButton *guanliButton;//管理
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property(nonatomic, copy) guanliBlock guanliBlock;
@property(nonatomic,strong)NYNMarketListModel * lictModel;


@end
