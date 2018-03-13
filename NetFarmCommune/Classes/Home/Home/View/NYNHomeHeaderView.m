//
//  NYNHomeHeaderView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNHomeHeaderView.h"

@implementation NYNHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Title:(NSString *)titleName DetailTitle:(NSString *)detailTitle{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(12), JZHEIGHT(16), JZWITH(21), JZHEIGHT(20))];
        imageView.image = Imaged(imageName);
        [self addSubview:imageView];
        
//        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + JZWITH(5), JZHEIGHT(9), JZWITH(200), JZHEIGHT(18))];
//        titleLab.textColor = Color90b659;
//        titleLab.font = [UIFont boldSystemFontOfSize:14];
//        titleLab.text  = titleName;
//        titleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:titleLab];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 5)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        lineLabel.alpha=0.4;
        [self addSubview:lineLabel];
        
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-40, 9, 20, 30)];
//        [moreButton setTitleColor:Color90b659 forState:0];
        _moreButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_moreButton addTarget:self action:@selector(tiaoZhuan) forControlEvents:UIControlEventTouchUpInside];
//        [moreButton setTitle:@"更多" forState:0];
        [_moreButton setImage:[UIImage imageNamed:@"home_icon_more_2"] forState:UIControlStateNormal];
        
        [self addSubview:_moreButton];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+JZHEIGHT(10), JZHEIGHT(10), JZWITH(100), JZHEIGHT(30))];
        detailLabel.text = detailTitle;
        detailLabel.font = JZFont(15);
        detailLabel.textAlignment = 0;
//        detailLabel.textColor = Color888888;
        detailLabel.textColor = [UIColor blackColor];

        [self addSubview:detailLabel];
    }
    return self;
}

- (void)tiaoZhuan{
    if (self.bcc) {
        self.bcc(@"");
    }
}

@end
