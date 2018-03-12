//
//  NYNMarketButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketButton.h"

@implementation NYNMarketButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _picImageView.bottom+5 , self.width , JZHEIGHT(20))];
        _picImageView.userInteractionEnabled = NO;
        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = 1;
        _textLabel.font = JZFont(13);
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = RGB_COLOR(56, 57, 56);
        
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self addSubview:_picImageView];
        [self addSubview:_textLabel];
        
        UILabel *zhongLiangLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _textLabel.bottom +5, self.width, JZHEIGHT(20))];
        zhongLiangLabel.textAlignment = 1;
        [self addSubview:zhongLiangLabel];
        self.zhongLiangLabel = zhongLiangLabel;
    }
    return self;
}
@end
