//
//  NYNWalletTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWalletTableViewCell.h"

@implementation NYNWalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = Colorededed;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(14), JZHEIGHT(13), SCREENWIDTH - JZWITH(14+14), JZHEIGHT(113))];
    backImageView.image = Imaged(@"mine_cash_bj");
    [self.contentView addSubview:backImageView];
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(34), JZHEIGHT(23), JZWITH(150), JZHEIGHT(14))];
    namelabel.text = @"花果山农场代金券";
    namelabel.font = JZFont(14);
    namelabel.textColor = Color383938;
    [self.contentView addSubview:namelabel];
    
    UILabel *zhuShiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(34 + 143), JZHEIGHT(24), JZWITH(143), JZHEIGHT(11))];
    zhuShiLabel.text = @"注：该币可以在所有农场使用";
    zhuShiLabel.font = JZFont(11);
    zhuShiLabel.textColor = Color888888;
    [self.contentView addSubview:zhuShiLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(20), JZHEIGHT(69), JZWITH(70), JZHEIGHT(28))];
    priceLabel.textColor = Colorffa200;
    priceLabel.font = JZFont(35);
    priceLabel.text = @"100";
    priceLabel.textAlignment = 2;
    [self.contentView addSubview:priceLabel];
    
    UILabel *yuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.right + JZWITH(9), JZHEIGHT(77), JZWITH(14), JZHEIGHT(13))];
    yuanLabel.text = @"元";
    yuanLabel.font = JZFont(14);
    yuanLabel.textColor = Color252827;
    [self.contentView addSubview:yuanLabel];
    
    UILabel *beishuLabel = [[UILabel alloc]initWithFrame:CGRectMake(yuanLabel.right + JZWITH(16), JZHEIGHT(79), JZWITH(17), JZHEIGHT(9))];
    beishuLabel.text = @"×1";
    beishuLabel.font = JZFont(11);
    beishuLabel.textColor = Color888888;
    [self.contentView addSubview:beishuLabel];
    
    UIButton *qushiyongButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(58 + 61), JZHEIGHT(62), JZWITH(61), JZHEIGHT(26))];
    [qushiyongButton setTitle:@"去使用" forState:0];
    [qushiyongButton setTitleColor:[UIColor whiteColor] forState:0];
    qushiyongButton.backgroundColor = Colorffa200;
    qushiyongButton.titleLabel.font = JZFont(13);
    qushiyongButton.layer.cornerRadius =5;
    qushiyongButton.layer.masksToBounds = YES;
    [self.contentView addSubview:qushiyongButton];
    
    UILabel *guoqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(21 + 120), JZHEIGHT(103), JZWITH(120), JZHEIGHT(11))];
    guoqiLabel.textColor = Color686868;
    guoqiLabel.text = @"过期时间：2017-05-01";
    guoqiLabel.font = JZFont(11);
    [self.contentView addSubview:guoqiLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
