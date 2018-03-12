//
//  NYNMeDealAllTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeDealAllTableViewCell.h"

@interface NYNMeDealAllTableViewCell()

@property(nonatomic,strong)NSString * stateString;
@property(nonatomic,strong)NSString * orderId;

@end

@implementation NYNMeDealAllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *viewOne = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(9), JZWITH(24), JZHEIGHT(24))];
    viewOne.image = PlaceImage;
    viewOne.layer.cornerRadius = JZWITH(12);
    viewOne.layer.masksToBounds = YES;
    [self.contentView addSubview:viewOne];
    _viewOne=viewOne;
    
    
    NSString *nongName = @"拉阿拉拉农场";
    CGFloat labelWith = [MyControl getTextWith:nongName andHeight:JZHEIGHT(14) andFontSize:13];
    UILabel *nongchangLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewOne.right + JZWITH(11), JZHEIGHT(14), labelWith, JZHEIGHT(14))];
    nongchangLabel.text = nongName;
    nongchangLabel.textColor = RGB_COLOR(37, 40, 39);
    nongchangLabel.font = JZFont(13);
   
    
    [self.contentView addSubview:nongchangLabel];
     _nongchangLabel = nongchangLabel;
    
    UIImageView *jiantouV = [[UIImageView alloc]initWithFrame:CGRectMake(nongchangLabel.right + JZWITH(10), JZHEIGHT(15), JZWITH(15), JZHEIGHT(15))];
    jiantouV.image = Imaged(@"mine_icon_contact");
    [self.contentView addSubview:jiantouV];
 
    
    
    UILabel *shouhuozhuangtaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(160), JZWITH(15), JZWITH(150), JZHEIGHT(14))];
    shouhuozhuangtaiLabel.textColor = Color90b659;
    shouhuozhuangtaiLabel.font = JZFont(13);
    shouhuozhuangtaiLabel.text = @"交易成功";
    shouhuozhuangtaiLabel.textAlignment = 2;
    [self.contentView addSubview:shouhuozhuangtaiLabel];
    _shouhuozhuangtaiLabel = shouhuozhuangtaiLabel;
    
    
    
    UIView *zhongxianLine = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(40), SCREENWIDTH, 0.5)];
    zhongxianLine.backgroundColor = BackGroundColor;
    [self.contentView addSubview:zhongxianLine];
    
    UIImageView *huoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), zhongxianLine.bottom + JZHEIGHT(10), JZWITH(61), JZHEIGHT(61))];
    huoImageView.image = PlaceImage;
    [self.contentView addSubview:huoImageView];
       _jiantouV = huoImageView;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(huoImageView.right +JZWITH(14), zhongxianLine.bottom + JZHEIGHT(11), JZWITH(150), JZHEIGHT(13))];
    titleLabel.text = @"1平方土地";
    titleLabel.textColor = RGB40;
    titleLabel.font = JZFont(13);
    [self.contentView addSubview:titleLabel];
    _titleLabel =titleLabel;
    
    
    UILabel *singlePrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(150 + 10), zhongxianLine.bottom + JZHEIGHT(11), JZWITH(150), JZHEIGHT(11))];
    singlePrice.textColor = RGB136;
    singlePrice.font = JZFont(11);
    singlePrice.text = @"¥1/月";
    singlePrice.textAlignment = 2;
    [self.contentView addSubview:singlePrice];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(huoImageView.right + JZWITH(14), singlePrice.bottom + JZHEIGHT(15), JZWITH(208), JZHEIGHT(40))];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = RGB136;
    contentLabel.font = JZFont(11);
    contentLabel.text = @"当地时间2017年4月25日，德国柏林，20国集团（G20）妇女峰会（又称W20峰会）在当地举行。美国第一千金伊万卡、德国总理默克尔， 荷兰王后马克西玛等人出席。";
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    
    UILabel *numLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(111), singlePrice.bottom + JZHEIGHT(20), JZWITH(100), JZHEIGHT(10))];
    numLable.textColor = RGB136;
    numLable.font = JZFont(11);
    numLable.text = @"数量：1";
    numLable.textAlignment = 2;
    [self.contentView addSubview:numLable];
    _numLable = numLable;
    
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, zhongxianLine.bottom + JZHEIGHT(81), SCREENWIDTH, 0.5)];
    lineTwo.backgroundColor = BackGroundColor;
    [self.contentView addSubview:lineTwo];
    
    UILabel *createTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), lineTwo.bottom, JZWITH(150), JZHEIGHT(35))];
    createTimeLabel.text = @"创建时间:2017-4-20";
    createTimeLabel.textColor = RGB136;
    createTimeLabel.font = JZFont(11);
    [self.contentView addSubview:createTimeLabel];
    _timeLabel =createTimeLabel;
    
    
    UILabel *yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(210), lineTwo.bottom, JZWITH(200), JZHEIGHT(35))];
    yunfeiLabel.text = @"合计: ¥1(含运费：¥12)";
    yunfeiLabel.textColor = RGB136;
    yunfeiLabel.font = JZFont(11);
    yunfeiLabel.textAlignment = 2;
    [self.contentView addSubview:yunfeiLabel];
    _yunfeiLabel = yunfeiLabel;
    
    
    UIView *lineThree = [[UIView alloc]initWithFrame:CGRectMake(0, lineTwo.bottom + JZHEIGHT(36), SCREENWIDTH, 0.5)];
    lineThree.backgroundColor = BackGroundColor;
    [self.contentView addSubview:lineThree];
    
    UIButton *shouHouTuiHuan = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(95), JZHEIGHT(8) + lineThree.bottom, JZWITH(61), JZHEIGHT(21))];
    [shouHouTuiHuan setTitle:@"售后退换" forState:0];
    [shouHouTuiHuan setTitleColor:RGB136 forState:0];
    shouHouTuiHuan.titleLabel.font = JZFont(10);
    shouHouTuiHuan.layer.borderColor = Color888888.CGColor;
    shouHouTuiHuan.layer.borderWidth = .5;
    shouHouTuiHuan.layer.cornerRadius = 5;
    [self.contentView addSubview:shouHouTuiHuan];
    [shouHouTuiHuan addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    shouHouTuiHuan.tag = 0;
    _shouHouTuiHuan =   shouHouTuiHuan;
    
    UIButton *chakanwuliubt = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(165), JZHEIGHT(8) + lineThree.bottom, JZWITH(61), JZHEIGHT(21))];
    [chakanwuliubt setTitle:@"查看物流" forState:0];
    [chakanwuliubt setTitleColor:RGB136 forState:0];
    chakanwuliubt.titleLabel.font = JZFont(10);
    chakanwuliubt.layer.borderColor = Color888888.CGColor;
    chakanwuliubt.layer.borderWidth = .5;
    chakanwuliubt.layer.cornerRadius = 5;
    [self.contentView addSubview:chakanwuliubt];
    [chakanwuliubt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    chakanwuliubt.tag = 1;
    _chakanwuliubt=chakanwuliubt;
    
    
    UIButton *shanchubt = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(235), JZHEIGHT(8) + lineThree.bottom, JZWITH(61), JZHEIGHT(21))];
    [shanchubt setTitle:@"删除订单" forState:0];
    [shanchubt setTitleColor:RGB136 forState:0];
    shanchubt.titleLabel.font = JZFont(10);
    shanchubt.layer.borderColor = Color888888.CGColor;
    shanchubt.layer.borderWidth = .5;
    shanchubt.layer.cornerRadius = 5;
    [self.contentView addSubview:shanchubt];
    [shanchubt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    shanchubt.tag = 2;
    _shanchubt =shanchubt;
    
    
    UIButton *pingjiabt = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(305), JZHEIGHT(8) + lineThree.bottom, JZWITH(61), JZHEIGHT(21))];
    [pingjiabt setTitle:@"评价" forState:0];//Color90b659
    [pingjiabt setTitleColor:Color888888 forState:0];
    pingjiabt.titleLabel.font = JZFont(10);
    pingjiabt.layer.borderColor = Color888888.CGColor;
    pingjiabt.layer.borderWidth = .5;
    pingjiabt.layer.cornerRadius = 5;
    [self.contentView addSubview:pingjiabt];
    [pingjiabt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    pingjiabt.tag = 3;
    _pingjiabt = pingjiabt;
    

}
-(void)setGoodsDealModel:(GoodsDealModel *)goodsDealModel{
    _goodsDealModel = goodsDealModel;
   _nongchangLabel.text = goodsDealModel.farm[@"name"];
    [_viewOne sd_setImageWithURL:[NSURL URLWithString:goodsDealModel.farm[@"img"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
    

    
    if ([goodsDealModel.status isEqualToString:@"canceled"]) {
        _shouhuozhuangtaiLabel.text =@"交易取消";
        _chakanwuliubt.hidden = YES;
        _shouHouTuiHuan.hidden = YES;
        _shanchubt.hidden = YES;
        
        [_pingjiabt setTitle:@"删除订单" forState:0];
        
    }else if ([goodsDealModel.status isEqualToString:@"pendingPayment"]){
        _shouhuozhuangtaiLabel.text =@"待付款";
           [_pingjiabt setTitle:@"付款" forState:0];
            _chakanwuliubt.hidden = YES;
        _shouHouTuiHuan.hidden = YES;
        
        
    }else if ([goodsDealModel.status isEqualToString:@"pendingReview"]){
        _shouhuozhuangtaiLabel.text =@"等待审核";
    }
    else if ([goodsDealModel.status isEqualToString:@"pendingShipment"]){
        _shouhuozhuangtaiLabel.text =@"待发货";
          [_pingjiabt setTitle:@"查看物流" forState:0];
           [_shanchubt setTitle:@"申请退款" forState:0];
         _chakanwuliubt.hidden = YES;
        _shouHouTuiHuan.hidden = YES;
        
        
        
    } else if ([goodsDealModel.status isEqualToString:@"shipped"]){
        _shouhuozhuangtaiLabel.text =@"待收货";
            [_shanchubt setTitle:@"查看物流" forState:0];
              [_chakanwuliubt setTitle:@"申请退款" forState:0];
          [_pingjiabt setTitle:@"确认收货" forState:0];
          _shouHouTuiHuan.hidden = YES;
        
        
    }else if ([goodsDealModel.status isEqualToString:@"completed"]){
        _shouhuozhuangtaiLabel.text =@"交易成功";
    }else if ([goodsDealModel.status isEqualToString:@"received"]){
        _shouhuozhuangtaiLabel.text =@"已收货";
    }
    
    

    else{
         _shouhuozhuangtaiLabel.text =@"已失败";
    }
  
    
     [_jiantouV sd_setImageWithURL:[NSURL URLWithString:goodsDealModel.orderItems[0][@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _titleLabel.text=goodsDealModel.orderItems[0][@"name"];
    _contentLabel.text =goodsDealModel.orderItems[0][@"cname"];
    _numLable.text =[NSString stringWithFormat:@"数量：%@", goodsDealModel.orderItems[0][@"quantity"]];
    
    _timeLabel.text = [NSString stringWithFormat:@"创建时间%@",[MyControl timeWithTimeIntervalString:goodsDealModel.createDate]];
    _singlePrice.text = [NSString stringWithFormat:@"%@",goodsDealModel.orderItems[0][@"price"]];
    
    _yunfeiLabel.text = [NSString stringWithFormat:@"合计：¥%@（含运费¥%@）",goodsDealModel.amount,goodsDealModel.freight];
    
    _stateString =goodsDealModel.status;
    
    _orderId = goodsDealModel.ID;//订单id

}


- (void)click:(UIButton *)sender{
    NSInteger i = sender.tag;
    if (self.ccblock) {
        self.ccblock(i,_stateString,_orderId,_indexpath,_goodsDealModel);
    }
}

@end
