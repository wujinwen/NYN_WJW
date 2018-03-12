//
//  NYNDIYChooseHeaderView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNDIYChooseHeaderView.h"

@implementation NYNDIYChooseHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *iconLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(100), self.height)];
        iconLabel.text = @"施肥次数";
        iconLabel.font = JZFont(14);
        self.titleLabel= iconLabel;
        [self addSubview:iconLabel];
        
        UILabel *cishuLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(25 + 10), (self.height - JZWITH(25)) / 2, JZWITH(25), JZHEIGHT(25))];
        cishuLabel.text = @"次";
        cishuLabel.textColor = Color888888;
        cishuLabel.font = JZFont(11);
        [self addSubview:cishuLabel];
        
        UIImageView *jiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(cishuLabel.left - JZWITH(25) - 1, cishuLabel.top, JZWITH(25), JZHEIGHT(25))];
        jiaImageView.userInteractionEnabled = YES;
        jiaImageView.image= Imaged(@"farm_button_increase");
        [self addSubview:jiaImageView];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(jiaImageView.left - JZWITH(25) - 1, jiaImageView.top, JZWITH(25), JZHEIGHT(25))];
        countLabel.backgroundColor = Colorf0f0f0;
        countLabel.text = @"0";
        countLabel.font = JZFont(13);
        countLabel.textAlignment = 1;
        [self addSubview:countLabel];
        
        self.countLabel = countLabel;
        
        UIImageView *jianImageView = [[UIImageView alloc]initWithFrame:CGRectMake(countLabel.left - JZWITH(25) - 1, countLabel.top, JZWITH(25), JZHEIGHT(25))];
        jianImageView.userInteractionEnabled = YES;
        jianImageView.image= Imaged(@"farm_button_reduce");
        [self addSubview:jianImageView];
        
        UITapGestureRecognizer *jiaGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jia)];
        UITapGestureRecognizer *jianGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jian)];
        [jiaImageView addGestureRecognizer:jiaGes];
        [jianImageView addGestureRecognizer:jianGes];

        self.count = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)jia{
    JZLog(@"+");
    self.count++;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
    if (self.ClickAction) {
        self.ClickAction(self.count,@"+");
    }
    
}

- (void)jian{
    JZLog(@"-");
    
    self.count--;
    if (self.count < 0) {
        self.count = 0;
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
    if (self.ClickAction) {
        self.ClickAction(self.count,@"-");
    }
}

@end
