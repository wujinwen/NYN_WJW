//
//  NYNFarmChooseButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNFarmChooseButton.h"

@implementation NYNFarmChooseButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width /4 - 5, 0, self.width /2 +10, self.height)];

        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_textLabel.right, (self.height - 10) / 2, 7, 10)];
//        _picImageView.userInteractionEnabled = NO;
//        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = 1;
        _textLabel.font = JZFont(13);
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = RGB_COLOR(56, 57, 56);
        
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self addSubview:_picImageView];
        [self addSubview:_textLabel];
        
        _isAsc = YES;
    }
    return self;
}


@end
