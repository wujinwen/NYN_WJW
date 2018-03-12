//
//  MyLiveOneTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyLiveOneTVCell.h"

@implementation MyLiveOneTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMovieModel:(MyMovieListModel *)movieModel{
    _movieModel = movieModel;
    _username.text = movieModel.nickName;
    _fanLabel.text = [NSString stringWithFormat:@"粉丝：%d",movieModel.fans];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:movieModel.avatar] placeholderImage:[UIImage imageNamed:@"占位图"]];

    _levelLbael.text = [NSString stringWithFormat:@"LV.%@",movieModel.level];
    
    
    
    
    
}

@end
