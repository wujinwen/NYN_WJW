//
//  FTMyDealTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTMyDealTableViewCell.h"
#import "FTMeButton.h"

@implementation FTMyDealTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSArray *imageArr = @[@"mine_icon_payment",@"mine_icon_deliver-goods",@"mine_icon_goods-receipt",@"mine_icon_evaluate"];
    
    UILabel *wodedingdan = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(15), JZWITH(70), JZHEIGHT(13))];
    wodedingdan.textColor = RGB_COLOR(56, 57, 56);
    wodedingdan.text = @"我的订单";
    wodedingdan.font = JZFont(14);
    [self.contentView addSubview:wodedingdan];
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(40))];
    [moreButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.tag = 10;
    [self.contentView addSubview:moreButton];
    
    UIImageView *jiantouImageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZHEIGHT(10) - JZHEIGHT(7),  JZHEIGHT(18), JZWITH(7), JZHEIGHT(11))];
    jiantouImageview.image = Imaged(@"mine_icon_more");
    [self.contentView addSubview:jiantouImageview];
    
    UILabel *gerenzhuyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(jiantouImageview.left - JZWITH(9) - JZWITH(50), JZHEIGHT(18), JZWITH(50), JZHEIGHT(11))];
    gerenzhuyeLabel.textAlignment = 2;
    gerenzhuyeLabel.text = @"全部订单";
    gerenzhuyeLabel.font = JZFont(11);
    gerenzhuyeLabel.textColor = RGB104;
    [self.contentView addSubview:gerenzhuyeLabel];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(40), SCREENWIDTH, 0.5)];
    lineView.backgroundColor = RGB_COLOR(238, 238, 238);
    [self.contentView addSubview:lineView];
    
    NSArray *titleArr = @[@"待付款",@"待发货",@"待收货",@"待评价"];
    
    CGFloat cellwith = JZWITH(30);
    CGFloat cellJianGeWith = (SCREENWIDTH - JZWITH(33) * 2 - JZWITH(30) * 4) / 3;
    
    for (int i = 0; i < 4; i++) {
        FTMeButton *bt = [[FTMeButton alloc]initWithFrame:CGRectMake(JZWITH(33) + (cellJianGeWith + cellwith) * i, lineView.bottom + JZHEIGHT(20), cellwith, JZHEIGHT(47))];
        bt.picImageView.image = Imaged(imageArr[i]);
        bt.textLabel.text = titleArr[i];
        bt.tag = i;
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
}

- (void)click:(UIButton *)sender{
    NSInteger i = sender.tag;
    
    if (self.clickDealCell) {
        self.clickDealCell(i);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
