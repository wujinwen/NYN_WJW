//
//  MyLiveTwoTabCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NYNLiveInfoModel.h"


@interface MyLiveTwoTabCell : UITableViewCell
@property(nonatomic,strong)NYNLiveInfoModel * model;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;


@property (weak, nonatomic) IBOutlet UILabel *liveName;

@property (weak, nonatomic) IBOutlet UIView *lajiBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

//@property(nonatomic,strong)NSDictionary * dataDic;

@property (weak, nonatomic) IBOutlet UILabel *taxLabel;//税收

@property (weak, nonatomic) IBOutlet UILabel *drawLabel;//是否转入钱包

@property(nonatomic,strong)NSDictionary * dic;


@end
