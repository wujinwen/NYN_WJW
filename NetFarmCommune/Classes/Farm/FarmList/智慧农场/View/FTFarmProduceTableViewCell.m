//
//  FTFarmProduceTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTFarmProduceTableViewCell.h"

@implementation FTFarmProduceTableViewCell

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
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + JZHEIGHT(11), JZWITH(200), JZHEIGHT(11))];
    addressLabel.text = @"四川省成都市啦啦啦啦啊啦啦啦";
    addressLabel.textColor = RGB104;
    addressLabel.font = JZFont(13);
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UILabel *kucun = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, addressLabel.bottom + JZHEIGHT(33), JZWITH(100), JZHEIGHT(10))];
    kucun.text = @"总面积 8Km";
    kucun.textColor = RGB104;
    kucun.font = JZFont(11);
    [self.contentView addSubview:kucun];
    self.kucun = kucun;
    
    UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(kucun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
    viewOne.backgroundColor = RGB136;
    [self.contentView addSubview:viewOne];
    self.viewOne = viewOne;
    
    UILabel *pinglun = [[UILabel alloc]initWithFrame:CGRectMake(viewOne.right + JZWITH(9), addressLabel.bottom + JZHEIGHT(33), JZWITH(60), JZHEIGHT(10))];
    pinglun.text = @"库存 100";
    pinglun.textColor = RGB104;
    pinglun.font = JZFont(11);
    [self.contentView addSubview:pinglun];
    self.pinglun = pinglun;
    
    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(pinglun.right + JZWITH(8), kucun.top + JZHEIGHT(1), 1, kucun.height - JZHEIGHT(2))];
    viewTwo.backgroundColor = RGB136;
    [self.contentView addSubview:viewTwo];
    self.viewTwo = viewTwo;
    
    UILabel *juli = [[UILabel alloc]initWithFrame:CGRectMake(viewTwo.right + JZWITH(9), addressLabel.bottom + JZHEIGHT(33), JZWITH(60), JZHEIGHT(10))];
    juli.text = @"评论 100";
    juli.textColor = RGB104;
    juli.font = JZFont(10);
    [self.contentView addSubview:juli];
    self.juli = juli;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(99.5), SCREENWIDTH, JZHEIGHT(0.5))];
    lineView.backgroundColor = RGB238;
    [self.contentView addSubview:lineView];
    
    
    //    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(305), JZHEIGHT(67), JZWITH(61), JZHEIGHT(24))];
    //    [go setTitle:@"去认领" forState:0];
    //    [go setTitleColor:[UIColor whiteColor] forState:0];
    //    go.layer.cornerRadius = 5;
    //    go.layer.masksToBounds = YES;
    //    go.titleLabel.font = JZFont(11);
    //    go.backgroundColor = KNaviBarTintColor;
    //    [self.contentView addSubview:go];
    //
    
    
//    UILabel *unitPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(100), JZHEIGHT(10), JZWITH(100), JZHEIGHT(15))];
//    unitPriceLabel.textAlignment = 2;
//    [self.contentView addSubview:unitPriceLabel];
//    self.unitPriceLabel = unitPriceLabel;
}




-(void)setModel:(NYNCategoryPageModel *)model{
    
    _model = model;
    if (model.images.count>0) {
        NSData *jsonData = [model.images[0] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    }
    
   
    
//    NSString *picStr = [NSString stringWithFormat:@"%@",model.pImg];
//    NSURL *picUrl = [NSURL URLWithString:picStr];
//    [self.imageV sd_setImageWithURL:picUrl placeholderImage:PlaceImage];
//
    
    self.titleLabel.text = model.name;
    self.addressLabel.text =[NSString stringWithFormat:@"¥%@%@",model.price,model.unitName] ;
    self.kucun.text = [NSString stringWithFormat:@"商品库存 %@%@",model.stock,model.unitName];
    
    NSString *moneyStr = [NSString stringWithFormat:@"¥%@",model.price];
    NSString *unitStr = [NSString stringWithFormat:@"/%@",model.unitName];
    
    self.unitPriceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",moneyStr,unitStr] thePartOneIndex:NSMakeRange(0, moneyStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:11] andPartTwoIndex:NSMakeRange(moneyStr.length, unitStr.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:11]];
    
    self.pinglun.hidden = YES;
    self.juli.hidden = YES;
    self.viewOne.hidden = YES;
    self.viewTwo.hidden= YES;
}

@end
