//
//  NYNXuanZeZhongZiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNZuDiZhonZhiModel.h"
@interface NYNXuanZeZhongZiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *xingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rowImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *peiceLeadingWith;
@property (weak, nonatomic) IBOutlet UILabel *zhanweiLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhongziLabel;//主产品名

@property(nonatomic,strong)NYNZuDiZhonZhiModel* model;

@property(nonatomic,assign)NSInteger indexpath;

@property(nonatomic,assign)NSInteger indexpathRow;







@end
