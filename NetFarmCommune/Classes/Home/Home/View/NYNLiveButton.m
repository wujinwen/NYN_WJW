//
//  NYNLiveButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLiveButton.h"

@implementation NYNLiveButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _picImageView.bottom , self.width , JZHEIGHT(30))];
        _picImageView.userInteractionEnabled = NO;
        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = 1;
        _textLabel.font = JZFont(11);
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = RGB_COLOR(56, 57, 56);
        
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self addSubview:_picImageView];
        [self addSubview:_textLabel];
        
        UIView *huangdianView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(8), JZHEIGHT(8), JZWITH(6), JZHEIGHT(6))];
        huangdianView.backgroundColor = [UIColor colorWithHexString:@"fb5f21"];
        huangdianView.layer.cornerRadius = JZWITH(3);
        huangdianView.layer.masksToBounds = YES;
        [self addSubview:huangdianView];
        
        UILabel *liveLabel = [[UILabel alloc]initWithFrame:CGRectMake(huangdianView.right + JZWITH(5), JZHEIGHT(6), JZWITH(50), JZHEIGHT(10))];
        liveLabel.font = JZFont(10);
        liveLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        liveLabel.text = @"直播中";
        [self addSubview:liveLabel];
        
        UIImageView *liveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JZWITH(35), JZHEIGHT(35))];
        liveImageView.image = Imaged(@"home_icon_play");
        [self addSubview:liveImageView];
        liveImageView.center = _picImageView.center;
        

    }
    return self;
}


@end
