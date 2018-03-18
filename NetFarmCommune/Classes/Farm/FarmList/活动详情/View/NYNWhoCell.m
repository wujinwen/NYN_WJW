//
//  NYNWhoCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNWhoCell.h"
#import "NYNCellHeadView.h"

@interface NYNWhoCell(){
    NYNCellHeadView *cellHead;
}

@end

@implementation NYNWhoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellHead = [[NYNCellHeadView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [self.contentView addSubview:cellHead];
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 30, 30)];
        [self.contentView addSubview:self.headImg];
        self.headImg.backgroundColor = [UIColor grayColor];
        
        self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 35, 100, 40)];
        self.nameLab.font = JZFont(12);
        [self.contentView addSubview:self.nameLab];
        
        
        UIImageView *phone = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - 10 -30 , 40, 30, 30)];
        [self.contentView addSubview:phone];
        phone.backgroundColor = [UIColor grayColor];
        
        UIView *greenLine = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - 50, 45, 1, 20)];
        greenLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:greenLine];
        
        UIImageView *message = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - 50 -10-30 , 40, 30, 30)];
        [self.contentView addSubview:message];
        message.backgroundColor = [UIColor grayColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 80-1, SCREENWIDTH, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(NYNActivityModel *)model{
    cellHead.titleLab.text = @"活动发起人";
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.farm[@"userName"]];
    
}
@end
