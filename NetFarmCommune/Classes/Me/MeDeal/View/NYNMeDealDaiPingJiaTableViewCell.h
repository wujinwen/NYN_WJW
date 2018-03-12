//
//  NYNMeDealDaiPingJiaTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDealModel.h"

typedef void(^CCBlock) (NSInteger i);
@interface NYNMeDealDaiPingJiaTableViewCell : UITableViewCell
@property (nonatomic,copy) CCBlock ccblock;
@property(nonatomic,strong)GoodsDealModel * moedel;

@property(nonatomic,strong)UIImageView *viewOne;
@property(nonatomic,strong) UILabel *nongName;
@property(nonatomic,strong) UILabel *shouhuozhuangtaiLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong) UILabel *singlePrice;
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIImageView *jiantouV;
@property(nonatomic,strong)UILabel *numLable;
@end
