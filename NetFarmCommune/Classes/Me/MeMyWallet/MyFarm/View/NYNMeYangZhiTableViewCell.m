//
//  NYNMeYangZhiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeYangZhiTableViewCell.h"

@implementation NYNMeYangZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *zhongzhizhuangtailabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(14), JZWITH(200), JZHEIGHT(13))];
    zhongzhizhuangtailabel.textColor = Color90b659;
    zhongzhizhuangtailabel.font = JZFont(14);
    zhongzhizhuangtailabel.text = @"代付款";
    [self.contentView addSubview:zhongzhizhuangtailabel];
    
    self.zhuangTaiLabel = zhongzhizhuangtailabel;
    
    UILabel *lianxiguanjialabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(11) - JZWITH(52), JZHEIGHT(14), JZWITH(52), JZHEIGHT(13))];
    lianxiguanjialabel.text = @"联系管家";
    lianxiguanjialabel.font = JZFont(13);
    lianxiguanjialabel.textColor = Color90b659;
    [self.contentView addSubview:lianxiguanjialabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuanJia)];
    [lianxiguanjialabel addGestureRecognizer:tap];
    
    UIImageView *lianxiguanjiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(lianxiguanjialabel.left - JZWITH(20), JZHEIGHT(13), JZWITH(15), JZHEIGHT(15))];
    lianxiguanjiaImageView.image = Imaged(@"mine_icon_contact");
    [self.contentView addSubview:lianxiguanjiaImageView];
    
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(40), SCREENWIDTH - JZWITH(22), .5)];
    lineOne.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineOne];
    
    UIImageView *headerImageViewOne = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), lineOne.bottom + JZHEIGHT(6), JZWITH(24), JZHEIGHT(24))];
    headerImageViewOne.image = PlaceImage;
    [self.contentView addSubview:headerImageViewOne];
    headerImageViewOne.layer.cornerRadius = JZWITH(12);
    headerImageViewOne.layer.masksToBounds = YES;
    self.nongChangImageView = headerImageViewOne;

    
    UILabel *headerJiLuLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageViewOne.right + JZWITH(10), lineOne.bottom + JZHEIGHT(11), SCREENWIDTH - (headerImageViewOne.right + JZWITH(10) + JZWITH(10)), JZHEIGHT(13))];
    headerJiLuLabel.text = @"花果山农场 > 优质土地2号 > 土豆";
    headerJiLuLabel.font = JZFont(13);
    [self.contentView addSubview:headerJiLuLabel];
    self.nongChangLabel = headerJiLuLabel;
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(35) + lineOne.bottom, SCREENWIDTH - JZWITH(22), .5)];
    lineTwo.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineTwo];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), lineTwo.bottom + JZHEIGHT(8), JZWITH(76), JZHEIGHT(76))];
    headerImageView.image = PlaceImage;
    [self.contentView addSubview:headerImageView];
    self.chanPinImageView = headerImageView;
//    UIImageView *shexiangtou = [[UIImageView alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), lineTwo.bottom + JZHEIGHT(14), JZWITH(19), JZHEIGHT(12))];
//    shexiangtou.image = Imaged(@"mine_icon_monitor");
//    [self.contentView addSubview:shexiangtou];
//    
//    UILabel *chakanjiankong = [[UILabel alloc]initWithFrame:CGRectMake(shexiangtou.right + JZWITH(10), lineTwo.bottom + JZWITH(14), JZWITH(52), JZHEIGHT(13))];
//    chakanjiankong.text = @"查看监控";
//    chakanjiankong.font = JZFont(13);
//    chakanjiankong.textColor = Color252827;
//    [self.contentView addSubview:chakanjiankong];
    
    UILabel *tudiMianji = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), lineTwo.bottom + JZWITH(23), JZWITH(100), JZHEIGHT(13))];
    tudiMianji.text = @"土地面积 5㎡";
    tudiMianji.font = JZFont(13);
    tudiMianji.textColor = Color686868;
    [self.contentView addSubview:tudiMianji];
    self.tuDiMianJiCountLabel = tudiMianji;
    
    UILabel *jiaoyijiageLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(15), tudiMianji.bottom + JZHEIGHT(18), JZWITH(200), JZHEIGHT(15))]
    ;
    jiaoyijiageLabel.text = @"交易价格 ¥1/㎡/天";
    jiaoyijiageLabel.font = JZFont(13);
    jiaoyijiageLabel.textColor = Color686868;
    [self.contentView addSubview:jiaoyijiageLabel];
    self.priceLabel = jiaoyijiageLabel;
    
    UIButton *chakanjinduButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), lineTwo.bottom + JZHEIGHT(20), JZWITH(66), JZHEIGHT(23))];
    chakanjinduButton.backgroundColor = Color90b659;
    [chakanjinduButton setTitle:@"查看进度" forState:0];
    [chakanjinduButton setTitleColor:[UIColor whiteColor] forState:0];
    chakanjinduButton.titleLabel.font = JZFont(12);
    chakanjinduButton.layer.cornerRadius = 5;
    chakanjinduButton.layer.masksToBounds = YES;
    [self.contentView addSubview:chakanjinduButton];
    
    
    UIButton *zhongzhijihuabutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), lineTwo.bottom + JZHEIGHT(19 + 15 + 23), JZWITH(66), JZHEIGHT(23))];
    zhongzhijihuabutton.backgroundColor = [UIColor whiteColor];
    [zhongzhijihuabutton setTitle:@"养殖计划" forState:0];
    [zhongzhijihuabutton setTitleColor:Color90b659 forState:0];
    zhongzhijihuabutton.titleLabel.font = JZFont(12);
    zhongzhijihuabutton.layer.borderColor = Color90b659.CGColor;
    zhongzhijihuabutton.layer.cornerRadius = 5;
    zhongzhijihuabutton.layer.masksToBounds = YES;
    zhongzhijihuabutton.layer.borderWidth = .5;
    [self.contentView addSubview:zhongzhijihuabutton];
    
    
    UIView *lineThree = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(90) + lineTwo.bottom, SCREENWIDTH - JZWITH(22), .5)];
    lineThree.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineThree];
    
    UILabel *shijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), lineThree.bottom + JZHEIGHT(10), SCREENWIDTH - JZWITH(20), JZHEIGHT(12))];
    shijianLabel.font = JZFont(12);
    shijianLabel.textColor = Color888888;
    shijianLabel.text = @"有效日期：2017-4-20 至 20179-20";
    [self.contentView addSubview:shijianLabel];
    self.riqiLabel = shijianLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}


-(void)setModel:(NYNMeFarmModel *)model{
    _model = model;
    
    
    NSString *statusStr;
    if ([model.orderStatus isEqualToString:@"pendingPayment"]) {
        statusStr = @"等待付款";
    }else if ([model.orderStatus isEqualToString:@"pendingReview"]){
        statusStr = @"等待审核";
        
    }else if ([model.orderStatus isEqualToString:@"pendingShipment"]){
        statusStr = @"等待发货";
        
    }else if ([model.orderStatus isEqualToString:@"growing"]){
        statusStr = @"种植中";
        
    }else if ([model.orderStatus isEqualToString:@"shipped"]){
        statusStr = @"已发货";
        
    }else if ([model.orderStatus isEqualToString:@"received"]){
        statusStr = @"已收货";
        
    }else if ([model.orderStatus isEqualToString:@"completed"]){
        statusStr = @"已完成";
        
    }else if ([model.orderStatus isEqualToString:@"failed"]){
        statusStr = @"已失败";
        
    }else if ([model.orderStatus isEqualToString:@"canceled"]){
        statusStr = @"已取消";
        
    }else if ([model.orderStatus isEqualToString:@"denied"]){
        statusStr = @"已拒绝";
        
    }else if ([model.orderStatus isEqualToString:@"consum"]){
        statusStr = @"待消费";
        
    }else {
        statusStr = @"请联系管理员查询订单状态";
        
    }
    self.zhuangTaiLabel.text = statusStr;
    
    
    [self.nongChangImageView sd_setImageWithURL:[NSURL URLWithString:model.farmImg] placeholderImage:PlaceImage];
    
    self.nongChangLabel.text = [NSString stringWithFormat:@"%@ > %@",model.farmName,model.majorProductName];
    
    [self.chanPinImageView sd_setImageWithURL:[NSURL URLWithString:model.majorProductImg] placeholderImage:PlaceImage];
    
    self.tuDiMianJiCountLabel.text = [NSString stringWithFormat:@"动物数量 %@只",model.majorProductQuantity];
    
    self.priceLabel.text = [NSString stringWithFormat:@"交易价格 ¥%@/只",model.majorProductPrice];
    
    if (model.startDate.length < 1 ) {
        self.riqiLabel.text = @"有效日期：暂无数据";
    }else{
        self.riqiLabel.text = [NSString stringWithFormat:@"有效日期：%@ 至 %@",model.startDate,model.endDate];
    }
    
    
}

- (void)tapGuanJia{
    JZLog(@"点击了联系管家");
}

@end
