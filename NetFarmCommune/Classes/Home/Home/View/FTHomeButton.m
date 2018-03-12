//
//  FTHomeButton.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTHomeButton.h"

@implementation FTHomeButton

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
        
//        UIView *huangdianView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(8), JZHEIGHT(8), JZWITH(6), JZHEIGHT(6))];
//        huangdianView.backgroundColor = [UIColor colorWithHexString:@"fb5f21"];
//        [self addSubview:huangdianView];
        
//        UILabel *zhiboLabel = [[UILabel alloc]initWithFrame:CGRectMake(huangdianView.right + JZWITH(5), JZHEIGHT(8), SCREENWIDTH - JZWITH(5 + 5) - huangdianView.right, JZHEIGHT(10))];
        
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self addSubview:_picImageView];
        [self addSubview:_textLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
