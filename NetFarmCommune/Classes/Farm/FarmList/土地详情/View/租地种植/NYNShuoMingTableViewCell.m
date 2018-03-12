//
//  NYNShuoMingTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNShuoMingTableViewCell.h"

@implementation NYNShuoMingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), JZWITH(31), JZHEIGHT(31))];
    headerImageView.image = PlaceImage;
    headerImageView.layer.cornerRadius = JZWITH(15.5);
    headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:headerImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(10), JZHEIGHT(18), JZWITH(150), JZHEIGHT(14))];
    nameLabel.text = @"关键词";
    nameLabel.font = JZFont(14);
    nameLabel.textColor = Color383938;
    [self.contentView addSubview:nameLabel];
    
    
    NYNStarsView *starView = [NYNStarsView shareStarsWith:4 with:CGRectMake(nameLabel.right + JZWITH(10), nameLabel.top, JZWITH(100),nameLabel.height)];
    [self.contentView addSubview:starView];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 100), JZHEIGHT(18.5), JZWITH(100), JZHEIGHT(10))];
    timeLabel.font = JZFont(9);
    timeLabel.textColor = Color888888;
    timeLabel.text = @"2017-4-19";
    [self.contentView addSubview:timeLabel];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZHEIGHT(50), JZHEIGHT(46), JZWITH(312), JZHEIGHT(30))];
    textLabel.text = @"智慧农场真的是不错啊，自己种植的蔬菜，吃起来味道 都不一样，完全无添加";
    textLabel.font = JZFont(13);
    textLabel.textColor = Color686868;
    [self.contentView addSubview:textLabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
