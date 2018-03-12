//
//  GoodsTwoSectionViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/4.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketListModel.h"

typedef void(^clickBlock)(int str);

@interface GoodsTwoSectionViewCell : UITableViewCell

@property(nonatomic,strong)NYNMarketListModel* model;

@property (nonatomic,copy) clickBlock selectClick;

@property (nonatomic,assign) int count;


@end
