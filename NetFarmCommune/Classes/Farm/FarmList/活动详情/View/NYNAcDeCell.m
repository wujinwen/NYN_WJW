//
//  NYNAcDeCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNAcDeCell.h"
#import "NYNCellHeadView.h"

@interface NYNAcDeCell(){
    NYNCellHeadView *cellHead;
}
@end
@implementation NYNAcDeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellHead = [[NYNCellHeadView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        [self.contentView addSubview:cellHead];
        
        self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 160)];
        self.moneyLab.numberOfLines = 0;
        self.moneyLab.font = JZFont(14);
        self.moneyLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.moneyLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 200-1, SCREENWIDTH, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)setModel:(NYNActivityModel *)model{
    cellHead.titleLab.text = @"活动详情";
    self.moneyLab.text = model.intro;//@"尽快；疯狂。非拉开舒服啊善良的开发能力坷。阿时刻记得那份科技时代，方式是打开附近那份科技三部分sad 看见菲尼克斯的肌肤撒代理反馈哪里撒风";
}

@end
