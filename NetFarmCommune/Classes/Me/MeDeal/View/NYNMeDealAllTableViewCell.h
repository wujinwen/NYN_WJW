//
//  NYNMeDealAllTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDealModel.h"

typedef void(^CCBlock) (NSInteger i ,NSString * state ,NSString * orderId,NSInteger index,GoodsDealModel * goodsDealModel);
@interface NYNMeDealAllTableViewCell : UITableViewCell
@property (nonatomic,copy) CCBlock ccblock;

@property(nonatomic,strong)GoodsDealModel * goodsDealModel;

@property(nonatomic,strong)UILabel * nongchangLabel;//农场
@property(nonatomic,strong)UILabel * yunfeiLabel;//运费

@property(nonatomic,strong)UILabel * shouhuozhuangtaiLabel;

@property(nonatomic,strong)UILabel * timeLabel;//时间

@property(nonatomic,strong)UIButton *  shanchubt;
@property(nonatomic,strong)UIButton *chakanwuliubt;

@property(nonatomic,strong)UIButton *pingjiabt;

@property(nonatomic,strong)UIImageView *viewOne;
@property(nonatomic,strong)UIImageView *jiantouV;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *numLable;

@property(nonatomic,strong)UIButton *shouHouTuiHuan;

@property(nonatomic,strong) UILabel *singlePrice;//单价

@property(nonatomic,assign)NSInteger indexpath;



@end
