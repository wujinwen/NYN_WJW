//
//  ChooseLandTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NYNXuanZeZhongZiModel.h"

@interface ChooseLandTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//土地图片
@property (weak, nonatomic) IBOutlet UILabel *landLabel;//土地名
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//土地价格
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;//土地面积
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;//种植人数
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property(nonatomic,strong)NYNXuanZeZhongZiModel * model;


@end
