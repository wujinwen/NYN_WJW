//
//  NYNAdressCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNAdressCell.h"
#import "NYNCellHeadView.h"

@interface NYNAdressCell(){
    NYNCellHeadView *cellHead;
}

@end

@implementation NYNAdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellHead = [[NYNCellHeadView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [self.contentView addSubview:cellHead];
        
        self.adressLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, SCREENWIDTH-100, 40)];
        self.adressLab.font = JZFont(12);
        [self.contentView addSubview:self.adressLab];
        
        
        self.disLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-80, 40, 70, 40)];
        self.disLab.font = JZFont(12);
        self.disLab.textAlignment = 2;
        [self.contentView addSubview:self.disLab];
        
        UIView *greenLine = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - 90, 52.5, 1, 15)];
        greenLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:greenLine];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 80-1, SCREENWIDTH, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(NYNActivityModel *)model{
    cellHead.titleLab.text = @"活动地址";
    self.disLab.text = [NSString stringWithFormat:@"距离%.0fkm",[model.distance floatValue]];
    self.adressLab.text = [NSString stringWithFormat:@"%@%@%@",model.farm[@"city"],model.farm[@"area"],model.farm[@"address"]];
    
}

@end
