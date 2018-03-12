//
//  FTMeButton.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTMeButton.h"

@implementation FTMeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - JZWITH(20)) / 2, 0, JZWITH(20), JZHEIGHT(19))];
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(-JZWITH(15), _picImageView.bottom + JZHEIGHT(7), self.width + JZWITH(30) , JZHEIGHT(20))];
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
    }
    return self;
}


@end
