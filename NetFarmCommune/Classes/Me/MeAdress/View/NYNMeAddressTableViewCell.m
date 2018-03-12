//
//  NYNMeAddressTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeAddressTableViewCell.h"
#import "NYNBianJiButton.h"

@implementation NYNMeAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(13), JZHEIGHT(15), SCREENWIDTH - JZWITH(26), JZHEIGHT(120))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self.contentView addSubview:backView];
    
    UILabel *shouhuorenlb = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(18), JZHEIGHT(17), JZWITH(100), JZHEIGHT(12))];
    shouhuorenlb.text = @"收货人：何亚男";
    shouhuorenlb.font = JZFont(13);
    shouhuorenlb.textColor = Color252827;
    self.shouHuoRenLabel = shouhuorenlb;
    [backView addSubview:shouhuorenlb];
    
    UILabel *dianhuaLabel = [[UILabel alloc]initWithFrame:CGRectMake(backView.width - JZWITH(21) - JZWITH(100), JZHEIGHT(18), JZWITH(100), JZHEIGHT(10))];
    dianhuaLabel.textColor = Color252827;
    dianhuaLabel.font = JZFont(13);
    dianhuaLabel.text = @"1555555555";
    dianhuaLabel.textAlignment = 2;
    self.dianhuaLabel = dianhuaLabel;
    [backView addSubview:dianhuaLabel];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(shouhuorenlb.left, shouhuorenlb.bottom + JZHEIGHT(26), backView.width - JZWITH(36), JZHEIGHT(12))];
    addressLabel.text = @"四川省成都是武侯区天府二街138号蜀都中心1栋3单元2204";
    addressLabel.font = JZFont(12);
    addressLabel.textColor = Color686868;
    self.dizhiLabel = addressLabel;
    [backView addSubview:addressLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, addressLabel.bottom + JZHEIGHT(15), backView.width, .5)];
    line.backgroundColor = Colore3e3e3;
    [backView addSubview:line];
    
//    UIImageView *chooseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(18), backView.height- JZHEIGHT(14), JZWITH(12), JZHEIGHT(12))];
////    mine_icon_selected2
//    chooseImageView.image = Imaged(@"mine_icon_unchecked");
//    [self.contentView addSubview:chooseImageView];
//    
//    UILabel *morenLabel = [[UILabel alloc]initWithFrame:CGRectMake(chooseImageView.right + JZWITH(12), chooseImageView.top, JZWITH(100), chooseImageView.height)];
//    morenLabel.textColor = Color686868;
//    morenLabel.text = @"默认收获地址";
//    morenLabel.font = JZFont(12);
//    [self.contentView addSubview:morenLabel];
//    
//    UIButton *morenClickButton = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(8), line.bottom, JZWITH(150), JZHEIGHT(39))];
//    morenClickButton.backgroundColor = [UIColor clearColor];
//    [morenClickButton addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:morenClickButton];
    
    NYNBianJiButton *xuanMoRen = [[NYNBianJiButton alloc]initWithFrame:CGRectMake(JZWITH(18), line.bottom + JZHEIGHT(13), JZWITH(100), JZHEIGHT(12))];
    xuanMoRen.picImageView.image = Imaged(@"mine_icon_unchecked");
    self.chooseImageView = xuanMoRen.picImageView;
    
    xuanMoRen.textLabel.text = @"默认收获地址";
    [backView addSubview:xuanMoRen];
    [xuanMoRen addTarget:self action:@selector(xuanmoren) forControlEvents:UIControlEventTouchUpInside];
    
    NYNBianJiButton *shanChuButton = [[NYNBianJiButton alloc]initWithFrame:CGRectMake(backView.width - JZWITH(15) - JZWITH(50), xuanMoRen.top, JZWITH(50), JZHEIGHT(15))];
    shanChuButton.picImageView.image = Imaged(@"mine_icon_delete2");
    shanChuButton.textLabel.text = @"删除";
    [backView addSubview:shanChuButton];
    [shanChuButton addTarget:self action:@selector(shanChu) forControlEvents:UIControlEventTouchUpInside];

    
    NYNBianJiButton *bianjibutton = [[NYNBianJiButton alloc]initWithFrame:CGRectMake(backView.width - JZWITH(15) - shanChuButton.width * 2 - JZWITH(20), xuanMoRen.top, JZWITH(50), JZHEIGHT(15))];
    bianjibutton.picImageView.image = Imaged(@"mine_icon_edit");
    bianjibutton.textLabel.text = @"编辑";
    [backView addSubview:bianjibutton];
    [bianjibutton addTarget:self action:@selector(bianji) forControlEvents:UIControlEventTouchUpInside];

    
    self.contentView.backgroundColor = Coloreeeeee;
}

- (void)xuanmoren{
    JZLog(@"");
    if (self.click) {
        self.click(@"0",self.indexPath);
    }
}

- (void)bianji{
    JZLog(@"");
    if (self.click) {
        self.click(@"1",self.indexPath);
    }
}

- (void)shanChu{
    JZLog(@"");
    if (self.click) {
        self.click(@"2",self.indexPath);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNMeAddressModel *)model{
    _model = model;
    self.shouHuoRenLabel.text = [NSString stringWithFormat:@"收货人：%@",model.contactName];
    self.dianhuaLabel.text = [NSString stringWithFormat:@"%@",model.phone];
    self.dizhiLabel.text = [NSString stringWithFormat:@"%@",model.address];
    
    if ([model.isDefault isEqualToString:@"1"]) {
        self.chooseImageView.image = Imaged(@"mine_icon_selected2");
    }else{
        self.chooseImageView.image = Imaged(@"mine_icon_unchecked");
    }
    
}
@end
