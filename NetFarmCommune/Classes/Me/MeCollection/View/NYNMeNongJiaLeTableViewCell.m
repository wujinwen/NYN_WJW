//
//  NYNMeNongJiaLeTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeNongJiaLeTableViewCell.h"

@implementation NYNMeNongJiaLeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), JZWITH(81), JZHEIGHT(81))];
    imageV.image = PlaceImage;
    [self.contentView addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + JZWITH(17), JZHEIGHT(13), JZWITH(150), JZHEIGHT(13))];
    titleLabel.text = @"我是一个农场";
    titleLabel.font = JZFont(15);
    titleLabel.textColor = RGB56;
    [self.contentView addSubview:titleLabel];
    self.titleLabel= titleLabel;
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(15), JZWITH(200), JZHEIGHT(30))];
    addressLabel.text = @"四川省成都市啦啦啦啦啊啦啦啦";
    addressLabel.textColor = Color383938;
    addressLabel.font = JZFont(12);
    addressLabel.numberOfLines = 0;
    [self.contentView addSubview:addressLabel];
    self.contentLabel = addressLabel;
    
//    UILabel *kucun = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, JZHEIGHT(80), JZWITH(100), JZHEIGHT(10))];
//    kucun.text = @"总面积 8Km";
//    kucun.textColor = RGB104;
//    kucun.font = JZFont(11);
//    [self.contentView addSubview:kucun];
//    self.kucun = kucun;
//    
//    UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(kucun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
//    viewOne.backgroundColor = RGB136;
//    [self.contentView addSubview:viewOne];
//    self.viewOne = viewOne;
//    
//    UILabel *pinglun = [[UILabel alloc]initWithFrame:CGRectMake(viewOne.right + JZWITH(9), JZHEIGHT(80), JZWITH(60), JZHEIGHT(10))];
//    pinglun.text = @"库存 100";
//    pinglun.textColor = RGB104;
//    pinglun.font = JZFont(11);
//    [self.contentView addSubview:pinglun];
//    self.pinglun = pinglun;
//    
//    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(pinglun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
//    viewTwo.backgroundColor = RGB136;
//    [self.contentView addSubview:viewTwo];
//    self.viewTwo = viewTwo;
//    
//    UILabel *juli = [[UILabel alloc]initWithFrame:CGRectMake(viewTwo.right + JZWITH(9), JZHEIGHT(80), JZWITH(60), JZHEIGHT(10))];
//    juli.text = @"评论 100";
//    juli.textColor = RGB104;
//    juli.font = JZFont(11);
//    [self.contentView addSubview:juli];
//    self.juli = juli;
//    
//
//    
//    UILabel *unitPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(100), JZHEIGHT(10), JZWITH(100), JZHEIGHT(15))];
//    unitPriceLabel.textAlignment = 2;
//    [self.contentView addSubview:unitPriceLabel];
//    self.unitPriceLabel = unitPriceLabel;
    
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(55), JZWITH(8), JZHEIGHT(10))];
    locationImageView.image = Imaged(@"farm_icon_address");
    [self.contentView addSubview:locationImageView];
    
    UILabel *aaddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImageView.right + JZWITH(5), titleLabel.bottom + JZHEIGHT(55), JZWITH(200), JZHEIGHT(11))];
    aaddressLabel.text = @"四川省成都市世纪城天府二街";
    aaddressLabel.textColor = Color686868;
    aaddressLabel.font = JZFont(11);
    [self.contentView addSubview:aaddressLabel];
    self.addressLabel = aaddressLabel;
    
    UILabel *juliLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(60), aaddressLabel.top, JZWITH(50), JZHEIGHT(12))];
    juliLabel.textColor = Color686868;
    juliLabel.font = JZFont(12);
    juliLabel.text = @"距离 1km";
    [self.contentView addSubview:juliLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(100.5), SCREENWIDTH, JZHEIGHT(0.5))];
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
//    NSString *picStr = [NSString stringWithFormat:@"%@",model.pImg];
//    NSURL *picUrl = [NSURL URLWithString:picStr];
//    [self.imageV sd_setImageWithURL:picUrl placeholderImage:PlaceImage];
//    self.titleLabel.text = model.name;
//    self.addressLabel.text = model.intro;
//    
//    self.kucun.text = [NSString stringWithFormat:@"总面积 %@㎡",model.landStock];
//    self.pinglun.text = [NSString stringWithFormat:@"库存 %@㎡",model.stock];
//    self.juli.text = [NSString stringWithFormat:@"评论 %@",model.commentCount];
//    
//    NSString *moneyStr = [NSString stringWithFormat:@"¥%@",model.price];
//    NSString *unitStr = [NSString stringWithFormat:@"/%@/月",model.unitName];
//    
//    self.unitPriceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",moneyStr,unitStr] thePartOneIndex:NSMakeRange(0, moneyStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:11] andPartTwoIndex:NSMakeRange(moneyStr.length, unitStr.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:11]];
//    
//    self.starCount = [model.grade intValue];

    //    self.pinglun.hidden = YES;
    //    self.juli.hidden = YES;
    //    self.viewOne.hidden = YES;
    //    self.viewTwo.hidden= YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    CGFloat kuCunWith = [MyControl getTextWith:[NSString stringWithFormat:@"总面积 %@㎡",self.model.landStock] andHeight:JZHEIGHT(10) andFontSize:11];
//    CGFloat pinglunWith = [MyControl getTextWith:[NSString stringWithFormat:@"库存 %@㎡",self.model.stock] andHeight:JZHEIGHT(10) andFontSize:11];
//    CGFloat juliWith = [MyControl getTextWith:[NSString stringWithFormat:@"评论 %@",self.model.commentCount] andHeight:JZHEIGHT(10) andFontSize:11];
//    
//    
//    self.kucun.frame = CGRectMake(self.titleLabel.left,  JZHEIGHT(80), kuCunWith, JZHEIGHT(10));
//    self.viewOne.frame = CGRectMake(self.kucun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
//    self.pinglun.frame = CGRectMake(self.viewOne.right + JZWITH(9), JZHEIGHT(80), pinglunWith, JZHEIGHT(10));
//    self.viewTwo.frame = CGRectMake(self.pinglun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
//    self.juli.frame = CGRectMake(self.viewTwo.right + JZWITH(9),JZHEIGHT(80), juliWith, JZHEIGHT(10));
    

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

