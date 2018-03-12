//
//  NYNMaiWangNongOneTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMaiWangNongOneTableViewCell.h"
#import "NYNMeChongZhiTableViewCell.h"

@implementation NYNMaiWangNongOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *gouMaiShuLiang = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(14), JZWITH(100), JZHEIGHT(14))];
    gouMaiShuLiang.text = @"购买数量";
    gouMaiShuLiang.font = JZFont(14);
    gouMaiShuLiang.textColor = [UIColor blackColor];
    [self.contentView addSubview:gouMaiShuLiang];
    
    NSArray *rr = @[@"1000",@"2000",@"5000",@"10000"];
    for (int i = 0; i < 4; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(10) + JZWITH(15)*i +i*JZWITH(66), gouMaiShuLiang.bottom + JZHEIGHT(15), JZWITH(66), JZHEIGHT(26))];
        [bt setTitle:rr[i] forState:0];
        [bt setTitleColor:Color888888 forState:0];
        bt.titleLabel.font=[UIFont systemFontOfSize:14];
        bt.layer.masksToBounds=YES;
        bt.layer.borderWidth=1;
        bt.layer.borderColor =Color888888.CGColor;
        [bt addTarget:self action:@selector(chooseWangNong:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag = i + 100;
     
        if (bt.tag ==100) {
            [bt setTitleColor:Color90b659 forState:0];
            bt.layer.borderColor =Color90b659.CGColor;
            
        }
        
        [self.contentView addSubview:bt];
        [self.btArr addObject:bt];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, gouMaiShuLiang.bottom + JZHEIGHT(13 + 15 + 26), SCREENWIDTH, .5)];
    lineView.backgroundColor = Color888888;
    [self.contentView addSubview:lineView];
    
    UILabel *shuRuShuLiang = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(11), lineView.bottom + JZHEIGHT(16), JZWITH(100), JZHEIGHT(14))];
    shuRuShuLiang.text = @"输入数量";
    shuRuShuLiang.font = JZFont(14);
    shuRuShuLiang.textColor = [UIColor blackColor];
    [self.contentView addSubview:shuRuShuLiang];
    
    UIImageView *jiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(11 + 25), lineView.bottom + JZHEIGHT(10), JZWITH(25), JZHEIGHT(25))];
    jiaImageView.image = Imaged(@"farm_button_increase");
    jiaImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *jiaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jia)];
    [jiaImageView addGestureRecognizer:jiaTap];
    [self.contentView addSubview:jiaImageView];
    
  
    

    
    
    
    UIImageView *jianImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(11 + 25 + 1 + 61) , lineView.bottom + JZHEIGHT(10), JZWITH(25), JZHEIGHT(25))];
    jianImageView.image = Imaged(@"farm_button_reduce");
    jianImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *jianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jian)];
    [jianImageView addGestureRecognizer:jianTap];
    [self.contentView addSubview:jianImageView];
    
//    UITextField *contentTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jianImageView.frame)+3, jiaImageView.top, JZWITH(40), JZHEIGHT(25))];
//    contentTF.placeholder = @"";
//    contentTF.font = JZFont(13)
//    contentTF.delegate=self;
//    contentTF.textColor = Color383938;
//    contentTF.textAlignment=NSTextAlignmentCenter;
//    contentTF.text = @"0";
//     contentTF.keyboardType= UIKeyboardTypeDefault;
//    [self.contentView addSubview:contentTF];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jianImageView.frame), jiaImageView.top, JZWITH(40), JZHEIGHT(25))];
    contentLabel.text = @"1000";
    contentLabel.font = JZFont(13)
    contentLabel.textColor = Color383938;
    contentLabel.textAlignment=NSTextAlignmentCenter;
    //    contentTF.text = @"0";
    //     contentTF.keyboardType= UIKeyboardTypeDefault;
        [self.contentView addSubview:contentLabel];
    _contentLabel=contentLabel;
    
}

- (void)chooseWangNong:(UIButton *)bt{
    int i = (int)bt.tag - 100;
    _count =[bt.titleLabel.text intValue];
    
    for (UIButton *btt in self.btArr) {
        btt.layer.borderColor = Color888888.CGColor;
        [btt setTitleColor:Color888888 forState:0];
    }
    
    bt.layer.borderColor = Color90b659.CGColor;
    [bt setTitleColor:Color90b659 forState:0];
    
    if (self.click) {
        self.click(i,bt.titleLabel.text);
    }
    
    _contentLabel.text =bt.titleLabel.text;
    
}

- (void)jia{
    JZLog(@"++++");
    self.count++;
    if (self.count < 0) {
        self.count = 0;
    }
    
    self.contentLabel.text = [NSString stringWithFormat:@"%d",self.count];
    if (self.countClick) {
        self.countClick(self.count,@"+");
    }

}

- (void)jian{
    JZLog(@"----");
    self.count--;
    if (self.count < 0) {
        self.count = 0;
    }
    
    self.contentLabel.text = [NSString stringWithFormat:@"%d",self.count];
    if (self.countClick) {
        self.countClick(self.count,@"-");
    }
}
//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableArray *)btArr{
    if (!_btArr) {
        _btArr = [[NSMutableArray alloc]init];
    }
    return _btArr;
}

@end
