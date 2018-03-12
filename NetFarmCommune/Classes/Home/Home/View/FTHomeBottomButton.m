//
//  FTHomeBottomButton.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTHomeBottomButton.h"

@implementation FTHomeBottomButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
//    NSString *detailStr = @"为了尽量复用代码，这个项目中的某些组件之间有比较强的依赖关系。为了方便其他开发者使用，我从中拆分出以下独立组件";
    
    if (self) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _picImageView.bottom + JZHEIGHT(7), self.width , JZHEIGHT(30))];
        _picImageView.userInteractionEnabled = NO;
        
        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = 1;
        _textLabel.font = JZFont(11);
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = RGB_COLOR(56, 57, 56);
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _textLabel.bottom + JZHEIGHT(7), self.width , JZHEIGHT(20))];
        _priceLabel.userInteractionEnabled = NO;
        _priceLabel.textAlignment = 0;
        _priceLabel.font = JZFont(11);
        _priceLabel.numberOfLines = 0;
        _priceLabel.textColor = RGB_COLOR(56, 57, 56);
        _priceLabel.attributedText = [MyControl CreateNSAttributedString:@"¥5.00/斤" thePartOneIndex:NSMakeRange(0, 5) withColor:KNaviBarTintColor withFont:[UIFont fontWithName:@"PingFangSC-Regular" size:SCREENWIDTH/375 * 15] andPartTwoIndex:NSMakeRange(5, 2) withColor:RGB_COLOR(60, 60, 60) withFont:[UIFont fontWithName:@"PingFangSC-Regular" size:SCREENWIDTH/375 * 11]];
        
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self addSubview:_picImageView];
        [self addSubview:_textLabel];
        [self addSubview:_priceLabel];
    }
    return self;
}

@end
