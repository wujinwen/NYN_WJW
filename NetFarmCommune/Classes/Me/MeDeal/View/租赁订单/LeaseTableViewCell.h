//
//  LeaseTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TudiDealModel.h"


@protocol LeaseTableViewCellDelagete<NSObject>

//租赁档案点击
-(void)LeaseArchivesDidselect:(UIButton*)sender;





@end



@interface LeaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *archiveBtn;//档案
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//有效时间

@property (weak, nonatomic) IBOutlet UIImageView *headImage;//农场头像


@property (weak, nonatomic) IBOutlet UILabel *farmNameLabel;//农场名
@property (weak, nonatomic) IBOutlet UIImageView *farmImageView;//农场图
@property (weak, nonatomic) IBOutlet UILabel *farmTudiLabel;//农场土地名

@property (weak, nonatomic) IBOutlet UILabel *zulingPriceLabel;//租赁价格

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;//土地面积

@property(assign,nonatomic)id<LeaseTableViewCellDelagete> delegate;

@property(nonatomic,strong)TudiDealModel * model;


@end
