//
//  NYNMaiBaiCaiView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMaiBaiCaiView.h"

@implementation NYNMaiBaiCaiView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    UILabel *shuliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (self.height - JZHEIGHT(20)) / 2 , JZWITH(30), JZHEIGHT(20))];
    shuliangLabel.text = @"数量:";
    shuliangLabel.font = JZFont(12);
    shuliangLabel.textColor = Color383938;
    [self addSubview:shuliangLabel];
    
    UIImageView *jianImageView = [[UIImageView alloc]initWithFrame:CGRectMake(shuliangLabel.right + JZWITH(15), (self.height - JZHEIGHT(26)) / 2, JZWITH(26), JZHEIGHT(26))];
    jianImageView.image = Imaged(@"farm_button_reduce");
    [self addSubview:jianImageView];
    
//    UITapGestureRecognizer *jjj = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jjj)];
//    [jianImageView addGestureRecognizer:jjj];
    
    UITapGestureRecognizer *jianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jian)];
    [jianImageView addGestureRecognizer:jianTap];
    
    
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(jianImageView.right + 1, jianImageView.top, jianImageView.width, jianImageView.height)];
    countLabel.text = @"0";
    countLabel.textAlignment = 1;
    [self addSubview:countLabel];
    self.countLabel = countLabel;
    
    UIImageView *jiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(countLabel.right + JZWITH(1), (self.height - JZHEIGHT(26)) / 2, JZWITH(26), JZHEIGHT(26))];
    jiaImageView.image = Imaged(@"farm_button_increase");
    [self addSubview:jiaImageView];
    
    UITapGestureRecognizer *jiaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jia)];
    [jiaImageView addGestureRecognizer:jiaTap];
    
    jianImageView.userInteractionEnabled = YES;
    jiaImageView.userInteractionEnabled = YES;

    NSString *str1 = @"¥ 15.00";
    NSString *str2 = @"（¥ 1.00/㎡）";
    NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    UILabel *moneyLB = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(150) - JZWITH(10), 0, JZWITH(150), JZHEIGHT(46))];
    moneyLB.textAlignment = 1;
    moneyLB.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
    moneyLB.textAlignment = 2;
    self.moneyLB = moneyLB;
    [self addSubview:moneyLB];
    
    
    self.nowCount = 0;
    
    return self;
}


- (void)jia{
    self.nowCount++;
    
    if (self.actionBlcok) {
        self.actionBlcok(self.nowCount);
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.nowCount];
}

- (void)jian{
    self.nowCount--;
    if (self.nowCount < 0) {
        self.nowCount = 0;
    }
    
    if (self.actionBlcok) {
        self.actionBlcok(self.nowCount);
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.nowCount];
}

- (void)jjj{
    JZLog(@"");
}
@end
