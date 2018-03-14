//
//  FTCultivateTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTCultivateTableViewCell.h"

@implementation FTCultivateTableViewCell

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
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(15), JZWITH(200), JZHEIGHT(30))];
    addressLabel.text = @"四川省成都市啦啦啦啦啊啦啦啦";
    addressLabel.textColor = RGB104;
    addressLabel.font = JZFont(12);
    addressLabel.numberOfLines = 0;
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UILabel *kucun = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, JZHEIGHT(80), JZWITH(120), JZHEIGHT(10))];
    kucun.text = @"总面积 8Km";
    kucun.textColor = RGB104;
    kucun.font = JZFont(11);
    [self.contentView addSubview:kucun];
    self.kucun = kucun;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setModel:(NYNCategoryPageModel *)model{
    _model = model;
    NSURL *picUrl = [NSURL URLWithString:[NSString jsonImg:model.images]];
    [self.imageV sd_setImageWithURL:picUrl placeholderImage:PlaceImage];
    self.titleLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"月售%@",model.monthSales];
    
    //landStock
    self.kucun.text = [NSString stringWithFormat:@"代养周期 %@天",self.model.cycleTime];
    NSString *moneyStr = [NSString stringWithFormat:@"%.2f元",[model.price floatValue]];
    NSString *unitStr = [NSString stringWithFormat:@"/%@",model.unitName];
    self.unitPriceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",moneyStr,unitStr] thePartOneIndex:NSMakeRange(0, moneyStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:11] andPartTwoIndex:NSMakeRange(moneyStr.length, unitStr.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:11]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat kuCunWith = [MyControl getTextWith:[NSString stringWithFormat:@"代养周期%@天",self.model.landStock] andHeight:JZHEIGHT(10) andFontSize:11] + 3;
    CGFloat pinglunWith = [MyControl getTextWith:[NSString stringWithFormat:@"月售 %@㎡",self.model.stock] andHeight:JZHEIGHT(10) andFontSize:11];
    CGFloat juliWith = [MyControl getTextWith:[NSString stringWithFormat:@"评论 %@",self.model.commentCount] andHeight:JZHEIGHT(10) andFontSize:11];
    
    
    self.kucun.frame = CGRectMake(self.titleLabel.left,  JZHEIGHT(80), kuCunWith, JZHEIGHT(10));
    self.viewOne.frame = CGRectMake(self.kucun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
    self.pinglun.frame = CGRectMake(self.viewOne.right + JZWITH(9), JZHEIGHT(80), pinglunWith, JZHEIGHT(10));
    self.viewTwo.frame = CGRectMake(self.pinglun.right + JZWITH(8), self.kucun.top + JZHEIGHT(1), 1, self.kucun.height - JZHEIGHT(2));
    self.juli.frame = CGRectMake(self.viewTwo.right + JZWITH(9),JZHEIGHT(80), juliWith, JZHEIGHT(10));
}
@end
