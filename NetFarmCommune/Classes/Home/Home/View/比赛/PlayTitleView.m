//
//  PlayTitleView.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PlayTitleView.h"

@implementation PlayTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initiaInterface{
    NSArray * titleArray= [NSArray arrayWithObjects:@"报名中",@"比赛中",@"距离最近", nil];
    CGFloat w = SCREENWIDTH/3;
    CGFloat h = 40;
    for (int i = 0; i<3;i++) {
        UIButton * selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(w*i, 0, w, h);
        if (i==0) {
            [selectButton setTitleColor:Color90b659 forState:UIControlStateNormal];
        }else{
            [selectButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        [selectButton setTitle:titleArray[i] forState:UIControlStateNormal];
        selectButton.titleLabel.font=[UIFont systemFontOfSize:14];
        selectButton.tag =300+i;
        [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
    }
}

-(void)selectButtonClick:(UIButton*)sender{
    for (int i = 0; i<4; i++) {
        UIButton * btn =(UIButton*) [self viewWithTag:i+300];
        if (btn.tag == sender.tag) {
            [btn setTitleColor:Color90b659 forState:UIControlStateNormal];
        }else{
             [btn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
        }
    }
    [self.delagete playSelectButtonClick:sender.tag-300];
}

@end
