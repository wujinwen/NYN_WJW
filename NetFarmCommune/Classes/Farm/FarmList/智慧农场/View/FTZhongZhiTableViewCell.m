//
//  FTZhongZhiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FTZhongZhiTableViewCell.h"

@implementation FTZhongZhiTableViewCell

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
    //    UIImageView *qiImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.right + JZWITH(8), titleLabel.top, titleLabel.height, titleLabel.height)];
    //    qiImage.image = Imaged(@"占位图");
    //    [self.contentView addSubview:qiImage];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(5), JZWITH(250), JZHEIGHT(40))];
    addressLabel.text = @"四川省成都市啦啦啦啦啊啦啦啦";
    addressLabel.textColor = RGB104;
    addressLabel.font = JZFont(12);
    addressLabel.numberOfLines = 0;
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UILabel *kucun = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, JZHEIGHT(80), JZWITH(100), JZHEIGHT(10))];
    kucun.text = @"总面积 8Km";
    kucun.textColor = RGB104;
    kucun.font = JZFont(11);
    [self.contentView addSubview:kucun];
    self.kucun = kucun;
    
   UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(kucun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
//    viewOne.backgroundColor = RGB136;
//    [self.contentView addSubview:viewOne];
//    self.viewOne = viewOne;
    
    UILabel *pinglun = [[UILabel alloc]initWithFrame:CGRectMake(viewOne.right + JZWITH(9), JZHEIGHT(80), JZWITH(60), JZHEIGHT(10))];
    pinglun.text = @"库存 100";
    pinglun.textColor = RGB104;
    pinglun.font = JZFont(11);
 //   [self.contentView addSubview:pinglun];
   // self.pinglun = pinglun;
    
    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(pinglun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
        viewTwo.backgroundColor = RGB136;
//        [self.contentView addSubview:viewTwo];
    self.viewTwo = viewTwo;
    
    UILabel *juli = [[UILabel alloc]initWithFrame:CGRectMake(viewTwo.right + JZWITH(9), JZHEIGHT(80), JZWITH(60), JZHEIGHT(10))];
        juli.text = @"评论 100";
        juli.textColor = RGB104;
        juli.font = JZFont(11);
//        [self.contentView addSubview:juli];
    self.juli = juli;
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(99.5), SCREENWIDTH, JZHEIGHT(0.5))];
//    lineView.backgroundColor = RGB238;
//    [self.contentView addSubview:lineView];
    
    //    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(305), JZHEIGHT(67), JZWITH(61), JZHEIGHT(24))];
    //    [go setTitle:@"去认领" forState:0];
    //    [go setTitleColor:[UIColor whiteColor] forState:0];
    //    go.layer.cornerRadius = 5;
    //    go.layer.masksToBounds = YES;
    //    go.titleLabel.font = JZFont(11);
    //    go.backgroundColor = KNaviBarTintColor;
    //    [self.contentView addSubview:go];
    //
    
    UILabel *unitPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(100), JZHEIGHT(10), JZWITH(100), JZHEIGHT(15))];
    unitPriceLabel.textAlignment = 2;
    [self.contentView addSubview:unitPriceLabel];
    self.unitPriceLabel = unitPriceLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNCategoryPageModel *)model{
    _model = model;
    NSString *picStr = [NSString stringWithFormat:@"%@",model.farm[@"img"]];
    NSURL *picUrl = [NSURL URLWithString:picStr];
    [self.imageV sd_setImageWithURL:picUrl placeholderImage:PlaceImage];
    self.titleLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"成长周期：%@天",model.cycleTime];
    
    self.kucun.text = [NSString stringWithFormat:@"每㎡土地种植 %@㎡",model.square];
   // self.pinglun.text = [NSString stringWithFormat:@"库存 %@㎡",model.stock];
    self.juli.text = [NSString stringWithFormat:@"评论 %@",model.commentCount];
    
    NSString *moneyStr = [NSString stringWithFormat:@"¥%@",model.price];
    NSString *unitStr = [NSString stringWithFormat:@"/%@/天",@"㎡"];

    self.unitPriceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",moneyStr,unitStr] thePartOneIndex:NSMakeRange(0, moneyStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:11] andPartTwoIndex:NSMakeRange(moneyStr.length, unitStr.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:11]];
    
//    self.pinglun.hidden = YES;
//    self.juli.hidden = YES;
//    self.viewOne.hidden = YES;
//    self.viewTwo.hidden= YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat kuCunWith = [MyControl getTextWith:[NSString stringWithFormat:@"每㎡土地种植 %@㎡",self.model.landStock] andHeight:JZHEIGHT(10) andFontSize:11];
    CGFloat pinglunWith = [MyControl getTextWith:[NSString stringWithFormat:@"库存 %@㎡",self.model.stock] andHeight:JZHEIGHT(10) andFontSize:11];
    CGFloat juliWith = [MyControl getTextWith:[NSString stringWithFormat:@"评论 %@",self.model.commentCount] andHeight:JZHEIGHT(10) andFontSize:11];

    
    self.kucun.frame = CGRectMake(self.titleLabel.left,  JZHEIGHT(80), kuCunWith, JZHEIGHT(10));
    self.viewOne.frame = CGRectMake(self.kucun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
    self.pinglun.frame = CGRectMake(self.viewOne.right + JZWITH(9), JZHEIGHT(80), pinglunWith, JZHEIGHT(10));
    self.viewTwo.frame = CGRectMake(self.pinglun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
    self.juli.frame = CGRectMake(self.viewTwo.right + JZWITH(9),JZHEIGHT(80), juliWith, JZHEIGHT(10));
}
@end
