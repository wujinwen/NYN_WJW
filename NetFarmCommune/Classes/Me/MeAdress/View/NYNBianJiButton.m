//
//  NYNBianJiButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNBianJiButton.h"

@implementation NYNBianJiButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.height, self.height)];
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.height, 0 , self.width - self.height , self.height)];
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
