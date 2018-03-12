//
//  NYNMeDealDaiFaHuoTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDealModel.h"

typedef void(^CCBlock) (NSInteger i,GoodsDealModel * goodsDealModel);
@interface NYNMeDealDaiFaHuoTableViewCell : UITableViewCell
@property (nonatomic,copy) CCBlock ccblock;

@property(nonatomic,strong)GoodsDealModel * goodsDealModel;

@property(nonatomic,strong)UIImageView *viewOne;
@property(nonatomic,strong)UIImageView *jiantouV;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *numLable;

@property(nonatomic,strong)UILabel * nongchangLabel;//农场
@property(nonatomic,strong)UILabel * yunfeiLabel;//运费

@property(nonatomic,strong)UILabel * shouhuozhuangtaiLabel;


@end
