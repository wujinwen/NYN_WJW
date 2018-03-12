//
//  NEinfoTableViewCell.m
//  NetworkEngineer
//
//  Created by 123 on 2017/5/16.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import "NEinfoTableViewCell.h"

@implementation NEinfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImageView *v = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(15), JZWITH(45), JZHEIGHT(45))];
    v.image = PlaceImage;
    [self.contentView addSubview:v];
    v.layer.cornerRadius = JZWITH(22.5);
    v.layer.masksToBounds = YES;
    
    UIImageView *xiaoV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(50), JZHEIGHT(13), JZWITH(8.5), JZHEIGHT(8.5))];
    xiaoV.image = Imaged(@"提示");
    [self.contentView addSubview:xiaoV];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(v.right + JZWITH(15), JZHEIGHT(15), JZWITH(200), JZHEIGHT(25))];
    lb.text = @"分享奖励";
    lb.font = JZFont(15);
    lb.textColor = RGB40;
    [self.contentView addSubview:lb];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(lb.left, lb.bottom, JZWITH(210), JZHEIGHT(20))];
    detailLabel.text = @"分享奖励分享奖励分享奖励分!";
    detailLabel.font = JZFont(12);
    detailLabel.textColor = RGB136;
    [self.contentView addSubview:detailLabel];
    
    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(110), JZHEIGHT(15), JZWITH(100), JZHEIGHT(20))];
    timelabel.textColor = RGB136;
    timelabel.font = JZFont(12);
    timelabel.text = @"05月09日";
    timelabel.textAlignment = 2;
    [self.contentView addSubview:timelabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(lb.left, JZHEIGHT(67.5) - 0.5, SCREENWIDTH - lb.left, 0.5)];
    lineView.backgroundColor = BackGroundColor;
    [self.contentView addSubview:lineView];
    
    self.headerImageView = v;
    self.dianImageView = xiaoV;
    self.titleLabel = lb;
    self.contentLabel = detailLabel;
    self.timeLabel = timelabel;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
