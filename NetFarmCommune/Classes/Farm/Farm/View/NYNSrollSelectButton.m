//
//  NYNSrollSelectButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNSrollSelectButton.h"

@implementation NYNSrollSelectButton


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.height - JZHEIGHT(11)) / 2 , JZWITH(12), JZHEIGHT(11))];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(5), (self.height - JZHEIGHT(13)) / 2 , self.width - _picImageView.width - JZWITH(5) , JZHEIGHT(13))];
//        _picImageView.userInteractionEnabled = NO;
//        _picImageView.hidden=YES;
        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = 0;
        _textLabel.font = JZFont(14);
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = Color686868;
        _textLabel.backgroundColor = [UIColor whiteColor];
//        _textLabel.layer.cornerRadius = 6;
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
       // [self addSubview:_picImageView];
        [self addSubview:_textLabel];
    }
    return self;
}
@end
