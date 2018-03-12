//
//  NYNMeNongChangTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeNongChangTableViewCell.h"

@implementation NYNMeNongChangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), JZWITH(81), JZHEIGHT(81))];
    imageV.image = Imaged(@"WechatIMG4");
    [self.contentView addSubview:imageV];
    
    self.cellImageView = imageV;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + JZWITH(17), JZHEIGHT(13), JZWITH(150), JZHEIGHT(13))];
    titleLabel.text = @"我是一个农场";
    titleLabel.font = JZFont(14);
    titleLabel.textColor = RGB56;
    [self.contentView addSubview:titleLabel];
    
    self.cellTitleLabel = titleLabel;
    
    UIImageView *qiImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.right + JZWITH(8), titleLabel.top, titleLabel.height, titleLabel.height)];
    qiImage.image = Imaged(@"farm_icon_plant");
    [self.contentView addSubview:qiImage];
    self.cellTypeImageView = qiImage;
    
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(25), JZWITH(8), JZHEIGHT(10))];
    locationImageView.image = Imaged(@"farm_icon_address");
    [self.contentView addSubview:locationImageView];
    
    
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImageView.right + JZWITH(5), titleLabel.bottom + JZHEIGHT(25), JZWITH(200), JZHEIGHT(11))];
    addressLabel.text = @"四川省成都市世纪城天府二街";
    addressLabel.textColor = RGB104;
    addressLabel.font = JZFont(11);
    [self.contentView addSubview:addressLabel];
    self.cellAddressLabel = addressLabel;
    
    UILabel *kucun = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, addressLabel.bottom + JZHEIGHT(15), JZWITH(55), JZHEIGHT(10))];
    kucun.text = @"库存 100";
    kucun.textColor = RGB104;
    kucun.font = JZFont(10);
    [self.contentView addSubview:kucun];
    self.cellkucunLabel = kucun;
    
    UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(kucun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
    viewOne.backgroundColor = RGB136;
    [self.contentView addSubview:viewOne];
    
    UILabel *pinglun = [[UILabel alloc]initWithFrame:CGRectMake(viewOne.right + JZWITH(9), addressLabel.bottom + JZHEIGHT(15), JZWITH(55), JZHEIGHT(10))];
    pinglun.text = @"评论 100";
    pinglun.textColor = RGB104;
    pinglun.font = JZFont(10);
    pinglun.textAlignment = 1;
    [self.contentView addSubview:pinglun];
    self.cellpinglunLabel = pinglun;
    
    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(pinglun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
    viewTwo.backgroundColor = RGB136;
    [self.contentView addSubview:viewTwo];
    
    UILabel *juli = [[UILabel alloc]initWithFrame:CGRectMake(viewTwo.right + JZWITH(9), addressLabel.bottom + JZHEIGHT(15), JZWITH(120), JZHEIGHT(10))];
    juli.text = @"距离 100";
    juli.textColor = RGB104;
    juli.font = JZFont(10);
    [self.contentView addSubview:juli];
    self.celljuliLabel = juli;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(99), SCREENWIDTH, JZHEIGHT(0.5))];
    lineView.backgroundColor = RGB238;
    [self.contentView addSubview:lineView];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(50 + 12) + i * JZWITH(3+10), JZHEIGHT(9+4), JZWITH(10), JZHEIGHT(10))];
        starImageView.image = Imaged(@"farm_icon_grade2");
        [self.contentView addSubview:starImageView];
        
        [self.starArray addObject:starImageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(NSMutableArray *)starArray{
    if (!_starArray) {
        _starArray = [[NSMutableArray alloc]init];
    }
    return _starArray;
}


-(void)setModel:(NYNCollectionFarmModel *)model{
    _model = model;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceImage];
    self.cellTitleLabel.text = model.name;
    
    self.cellTitleLabel.frame = CGRectMake(self.cellTitleLabel.frame.origin.x, self.cellTitleLabel.frame.origin.y, [MyControl getTextWith:model.name andHeight:self.cellTitleLabel.height andFontSize:14], self.cellTitleLabel.height);
    self.cellTypeImageView.frame = CGRectMake(self.cellTitleLabel.right + JZWITH(8), self.cellTitleLabel.top, self.cellTitleLabel.height, self.cellTitleLabel.height);
    self.cellAddressLabel.text = model.address;
    self.cellkucunLabel.text = [NSString stringWithFormat:@"库存%@",model.landStock];
    self.cellpinglunLabel.text = [NSString stringWithFormat:@"评论%@",model.commentCount];
//    float dis = [model.distance floatValue] / 1000;
//    self.celljuliLabel.text = [NSString stringWithFormat:@"距离%.0fKM",dis];
    self.celljuliLabel.text = @"";
    
    
    self.starCount = [model.grade intValue];
    
    self.cellTypeImageView.hidden = YES;
//    [self.cellTypeImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceImage];
}

-(void)setStarCount:(int)starCount{
    _starCount = starCount;
    
    if (starCount < 6) {
        for (int i = 0; i < starCount; i++) {
            UIImageView *starImageView = self.starArray[i];
            starImageView.image = Imaged(@"farm_icon_grade1");
        }
    }else{
        
    }

}
@end

