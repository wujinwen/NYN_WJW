//
//  JNTipsView.m
//  BusinessHandGo
//
//  Created by chenhong on 16/7/5.
//  Copyright © 2016年 chenhong. All rights reserved.
//

#import "JNTipsView.h"

@interface JNTipsView()
{
   UILabel * _tipsLabel;
}
@end

@implementation JNTipsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-170)/2, self.frame.size.height*0.4, 170, 80)];
        [_tipsLabel setFont:[UIFont systemFontOfSize:16]];
        [_tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipsLabel setTextColor:[UIColor whiteColor]];
        _tipsLabel.layer.masksToBounds = YES;
        [_tipsLabel setAlpha:0.8];
        [_tipsLabel setBackgroundColor:[UIColor blackColor]];
        _tipsLabel.layer.cornerRadius = 5;
        _tipsLabel.clipsToBounds = YES;
        [self addSubview:_tipsLabel];
    }
    
    return self;
}

- (void)setTipText:(NSString*)tipText
{
    if ([tipText isKindOfClass:[NSString class]]) {
        _tipsLabel.numberOfLines = 0;
        [_tipsLabel setText:tipText];
    }
}


@end
