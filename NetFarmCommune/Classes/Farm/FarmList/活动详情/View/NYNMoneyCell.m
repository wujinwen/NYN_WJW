//
//  NYNMoneyCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNMoneyCell.h"
#import "NYNCellHeadView.h"

@interface NYNMoneyCell(){
    NYNCellHeadView *cellHead;
}
@end

@implementation NYNMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellHead = [[NYNCellHeadView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        [self.contentView addSubview:cellHead];
        
        self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 90, 50)];
        self.moneyLab.textColor = [UIColor redColor];
        self.moneyLab.textAlignment = 2;
        [self.contentView addSubview:self.moneyLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50-1, SCREENWIDTH, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)setModel:(NYNActivityModel *)model{
    cellHead.titleLab.text = @"活动费用";
    self.moneyLab.text = [NSString stringWithFormat:@"%@元/人",model.price];
}
@end
