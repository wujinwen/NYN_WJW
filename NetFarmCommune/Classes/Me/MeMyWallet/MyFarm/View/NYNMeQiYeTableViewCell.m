//
//  NYNMeQiYeTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeQiYeTableViewCell.h"

@implementation NYNMeQiYeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    UILabel *zhongzhizhuangtailabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(14), JZWITH(100), JZHEIGHT(0))];
//    zhongzhizhuangtailabel.textColor = Color90b659;
//    zhongzhizhuangtailabel.font = JZFont(14);
//    zhongzhizhuangtailabel.text = @"代付款";
//    [self.contentView addSubview:zhongzhizhuangtailabel];
//    
//    UILabel *lianxiguanjialabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(11) - JZWITH(52), JZHEIGHT(14), JZWITH(52), JZHEIGHT(0))];
//    lianxiguanjialabel.text = @"联系管家";
//    lianxiguanjialabel.font = JZFont(13);
//    lianxiguanjialabel.textColor = Color90b659;
//    [self.contentView addSubview:lianxiguanjialabel];
//    
//    UIImageView *lianxiguanjiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(lianxiguanjialabel.left - JZWITH(20), JZHEIGHT(13), JZWITH(15), JZHEIGHT(0))];
//    lianxiguanjiaImageView.image = Imaged(@"mine_icon_contact");
//    [self.contentView addSubview:lianxiguanjiaImageView];
    
//    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(40), SCREENWIDTH - JZWITH(22), 0)];
//    lineOne.backgroundColor = Colore3e3e3;
//    [self.contentView addSubview:lineOne];
    
    UIImageView *headerImageViewOne = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), 0 + JZHEIGHT(6), JZWITH(24), JZHEIGHT(24))];
    headerImageViewOne.image = PlaceImage;
    [self.contentView addSubview:headerImageViewOne];
    
    UILabel *headerJiLuLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageViewOne.right + JZWITH(10), 0 + JZHEIGHT(11), JZWITH(150), JZHEIGHT(13))];
    headerJiLuLabel.text = @"花果山农场 > 优质土地2号 > 土豆";
    headerJiLuLabel.font = JZFont(13);
    [self.contentView addSubview:headerJiLuLabel];
    
    UIImageView *dianhuaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZHEIGHT(35) - JZWITH(15), JZHEIGHT(11), JZWITH(16), JZHEIGHT(15))];
    dianhuaImageView.image = Imaged(@"farm_icon_phone_2");
    UIButton *dianhuaButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, dianhuaImageView.width, dianhuaImageView.height)];
    [dianhuaImageView addSubview:dianhuaButton];
    [self.contentView addSubview:dianhuaImageView];
    [dianhuaButton addTarget:self action:@selector(dianhua) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(35) + 0, SCREENWIDTH - JZWITH(22), .5)];
    lineTwo.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineTwo];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), lineTwo.bottom + JZHEIGHT(8), JZWITH(76), JZHEIGHT(76))];
    headerImageView.image = PlaceImage;
    [self.contentView addSubview:headerImageView];
    
    //    UIImageView *shexiangtou = [[UIImageView alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), lineTwo.bottom + JZHEIGHT(14), JZWITH(19), JZHEIGHT(12))];
    //    shexiangtou.image = Imaged(@"mine_icon_monitor");
    //    [self.contentView addSubview:shexiangtou];
    //
    //    UILabel *chakanjiankong = [[UILabel alloc]initWithFrame:CGRectMake(shexiangtou.right + JZWITH(10), lineTwo.bottom + JZWITH(14), JZWITH(52), JZHEIGHT(13))];
    //    chakanjiankong.text = @"查看监控";
    //    chakanjiankong.font = JZFont(13);
    //    chakanjiankong.textColor = Color252827;
    //    [self.contentView addSubview:chakanjiankong];
    
    UILabel *tudiMianji = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), lineTwo.bottom + JZWITH(12), JZWITH(100), JZHEIGHT(13))];
    tudiMianji.text = @"土地面积 5m";
    tudiMianji.font = JZFont(13);
    tudiMianji.textColor = Color686868;
    [self.contentView addSubview:tudiMianji];
    
    UILabel *jiaoyijiageLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), tudiMianji.bottom + JZHEIGHT(10), JZWITH(120), JZHEIGHT(15))]
    ;
    jiaoyijiageLabel.text = @"交易价格 ¥1/㎡/天";
    jiaoyijiageLabel.font = JZFont(13);
    jiaoyijiageLabel.textColor = Color686868;
    [self.contentView addSubview:jiaoyijiageLabel];
    
    UIImageView *locaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), jiaoyijiageLabel.bottom + JZHEIGHT(17), JZWITH(8), JZHEIGHT(10))];
    locaImageView.image = Imaged(@"mine_icon_address2");
    [self.contentView addSubview:locaImageView];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(locaImageView.right + JZWITH(5), jiaoyijiageLabel.bottom + JZHEIGHT(17), JZWITH(150), JZHEIGHT(12))];
    addressLabel.text = @"成都市高新区天府二街";
    addressLabel.font = JZFont(12);
    addressLabel.textColor = Color686868;
    [self.contentView addSubview:addressLabel];
    
    UIButton *chakanjinduButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), lineTwo.bottom + JZHEIGHT(20), JZWITH(66), JZHEIGHT(23))];
    chakanjinduButton.backgroundColor = Color90b659;
    [chakanjinduButton setTitle:@"档案" forState:0];
    [chakanjinduButton setTitleColor:[UIColor whiteColor] forState:0];
    chakanjinduButton.titleLabel.font = JZFont(12);
    chakanjinduButton.layer.cornerRadius = 5;
    chakanjinduButton.layer.masksToBounds = YES;
    [self.contentView addSubview:chakanjinduButton];
    
    
//    UIButton *zhongzhijihuabutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), lineTwo.bottom + JZHEIGHT(19 + 15 + 23), JZWITH(66), JZHEIGHT(23))];
//    zhongzhijihuabutton.backgroundColor = [UIColor whiteColor];
//    [zhongzhijihuabutton setTitle:@"养殖计划" forState:0];
//    [zhongzhijihuabutton setTitleColor:Color90b659 forState:0];
//    zhongzhijihuabutton.titleLabel.font = JZFont(12);
//    zhongzhijihuabutton.layer.borderColor = Color90b659.CGColor;
//    zhongzhijihuabutton.layer.cornerRadius = 5;
//    zhongzhijihuabutton.layer.masksToBounds = YES;
//    zhongzhijihuabutton.layer.borderWidth = .5;
//    [self.contentView addSubview:zhongzhijihuabutton];
    
    UILabel *juliLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(305 - 30), JZHEIGHT(103), JZWITH(90), JZHEIGHT(12))];
    juliLabel.textColor = Color686868;
    juliLabel.font = JZFont(12);
    juliLabel.text = @"距离 12 km";
    juliLabel.textAlignment = 2;
    [self.contentView addSubview:juliLabel];
    
    UIView *lineThree = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(90) + lineTwo.bottom, SCREENWIDTH - JZWITH(22), .5)];
    lineThree.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineThree];
    
    UILabel *shijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), lineThree.bottom + JZHEIGHT(10), SCREENWIDTH - JZWITH(20), JZHEIGHT(12))];
    shijianLabel.font = JZFont(12);
    shijianLabel.textColor = Color888888;
    shijianLabel.text = @"有效日期：2017-4-20 至 20179-20";
    [self.contentView addSubview:shijianLabel];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dianhua{
    JZLog(@"打电话");
}

@end
