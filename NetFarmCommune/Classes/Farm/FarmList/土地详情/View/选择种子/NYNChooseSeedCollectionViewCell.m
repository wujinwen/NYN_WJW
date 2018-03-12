//
//  NYNChooseSeedCollectionViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseSeedCollectionViewCell.h"

@implementation NYNChooseSeedCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH - JZWITH(46)) / 2, JZHEIGHT(15), JZWITH(46), JZHEIGHT(46))];
    imageV.image = PlaceImage;
    [self.contentView addSubview:imageV];
    self.contentImageView = imageV;
    
    UIImageView *gougouImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageV.right - JZWITH(5), JZHEIGHT(5), JZWITH(17), JZHEIGHT(17))];
    gougouImageView.image = Imaged(@"farm_icon_selected2");
    [self.contentView addSubview:gougouImageView];
    self.gouXuanImageView = gougouImageView;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.bottom + JZHEIGHT(10), self.width, JZHEIGHT(15))];
    titleLabel.text = @"大白菜";
    titleLabel.font = JZFont(13);
    titleLabel.textColor = [UIColor colorWithHexString:@"F07029"];
    [self.contentView addSubview:titleLabel];
    self.contentLabel = titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - JZWITH(46)) / 2, JZHEIGHT(15), JZWITH(46), JZHEIGHT(46))];
    imageV.image = PlaceImage;
    [self.contentView addSubview:imageV];
    imageV.layer.cornerRadius = JZWITH(23);
    imageV.layer.masksToBounds = YES;
    self.contentImageView = imageV;
    
    UIImageView *gougouImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageV.right - JZWITH(5), JZHEIGHT(5), JZWITH(17), JZHEIGHT(17))];
    gougouImageView.image = Imaged(@"farm_icon_selected2");
    [self.contentView addSubview:gougouImageView];
    self.gouXuanImageView = gougouImageView;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.bottom + JZHEIGHT(10), self.width, JZHEIGHT(15))];
    titleLabel.text = @"大白菜";
    titleLabel.font = JZFont(13);
    titleLabel.textColor = [UIColor colorWithHexString:@"F07029"];
    titleLabel.textAlignment = 1;
    [self.contentView addSubview:titleLabel];
    self.contentLabel = titleLabel;
    
    self.isChoose = NO;
    return self;
}

@end
