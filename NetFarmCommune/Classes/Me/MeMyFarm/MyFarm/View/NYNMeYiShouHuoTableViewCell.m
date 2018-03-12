//
//  NYNMeYiShouHuoTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeYiShouHuoTableViewCell.h"

@implementation NYNMeYiShouHuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    UIImageView *headerImageview = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), JZWITH(81), JZHEIGHT(81))];
    headerImageview.image = PlaceImage;
    [self.contentView addSubview:headerImageview];
    
    self.chanPinImageView = headerImageview;
    
    UILabel *titLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageview.right + JZWITH(10), JZHEIGHT(11), JZWITH(150), JZHEIGHT(15))];
    titLabel.font = JZFont(15);
    titLabel.text = @"自种大白菜";
    titLabel.textColor = Color252827;
    [self.contentView addSubview:titLabel];
    
    self.nongChangLabel = titLabel;
    
    UILabel *zhuangTaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(titLabel.left, titLabel.bottom + JZHEIGHT(10), JZWITH(100), JZHEIGHT(13))];
    zhuangTaiLabel.font = JZFont(13);
    zhuangTaiLabel.textColor = Color9ecc5b;
    zhuangTaiLabel.text = @"配送中";
    [self.contentView addSubview:zhuangTaiLabel];

    self.zhuangTaiLabel = zhuangTaiLabel;
    
    UILabel *shouhuoriqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(titLabel.left, zhuangTaiLabel.bottom + JZHEIGHT(25 - 14), JZWITH(200), JZHEIGHT(50))];
    shouhuoriqiLabel.text = @"收获日期：2017-06-07";
    shouhuoriqiLabel.font = JZFont(11);
    shouhuoriqiLabel.textColor = Color888888;
    [self.contentView addSubview:shouhuoriqiLabel];
    shouhuoriqiLabel.numberOfLines = 0;
    self.riqiLabel = shouhuoriqiLabel;
    
    UIButton *detelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 13), JZHEIGHT(11), JZWITH(13), JZHEIGHT(14))];
    UIImageView *detelImagview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, detelButton.width, detelButton.height)];
    detelImagview.image = Imaged(@"mine_icon_delete2_2");
    detelImagview.userInteractionEnabled = NO;
    [detelButton addSubview:detelImagview];
    [self.contentView addSubview:detelButton];
    
    UIButton *chakanjinduButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), JZHEIGHT(36), JZWITH(66), JZHEIGHT(23))];
    chakanjinduButton.backgroundColor = Color90b659;
    [chakanjinduButton setTitle:@"评价" forState:0];
    [chakanjinduButton setTitleColor:[UIColor whiteColor] forState:0];
    chakanjinduButton.titleLabel.font = JZFont(12);
    chakanjinduButton.layer.cornerRadius = 5;
    chakanjinduButton.layer.masksToBounds = YES;
    [self.contentView addSubview:chakanjinduButton];
    [chakanjinduButton addTarget:self action:@selector(pingjia) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zhongzhijihuabutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(66), chakanjinduButton.bottom + JZHEIGHT(10), JZWITH(66), JZHEIGHT(23))];
    zhongzhijihuabutton.backgroundColor = [UIColor whiteColor];
    [zhongzhijihuabutton setTitle:@"溯源" forState:0];
    [zhongzhijihuabutton setTitleColor:Color90b659 forState:0];
    zhongzhijihuabutton.titleLabel.font = JZFont(12);
    zhongzhijihuabutton.layer.borderColor = Color90b659.CGColor;
    zhongzhijihuabutton.layer.cornerRadius = 5;
    zhongzhijihuabutton.layer.masksToBounds = YES;
    zhongzhijihuabutton.layer.borderWidth = .5;
    [self.contentView addSubview:zhongzhijihuabutton];
    [zhongzhijihuabutton addTarget:self action:@selector(suyuan) forControlEvents:UIControlEventTouchUpInside];

}

- (void)pingjia{
    if (self.pingJiaBack) {
        self.pingJiaBack(self.indexPath);
    }
}

- (void)suyuan{
    if (self.suYuanBack) {
        self.suYuanBack(self.indexPath);
    }
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

    [self.chanPinImageView sd_setImageWithURL:[NSURL URLWithString:model.farmImg] placeholderImage:PlaceImage];

    if (model.startDate.length < 1 ) {
        self.riqiLabel.text = @"有效日期：暂无数据";
    }else{
        self.riqiLabel.text = [NSString stringWithFormat:@"有效日期：%@ 至 %@",[MyControl timeWithTimeIntervalString:model.startDate],[MyControl timeWithTimeIntervalString:model.endDate]];
    }
    
    self.nongChangLabel.text = [NSString stringWithFormat:@"%@",model.majorProductName];

}

@end
