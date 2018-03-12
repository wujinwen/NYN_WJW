//
//  NYNMarketHeaderChooseButton.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketHeaderChooseButton.h"

@implementation NYNMarketHeaderChooseButton
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sanJiaoImageView = [[UIImageView alloc]init];
        [self addSubview:_sanJiaoImageView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    self.sanJiaoImageView.frame = CGRectMake(self.width / 2 - JZWITH(3.5), self.height - JZHEIGHT(6), JZWITH(7), JZHEIGHT(6));
    self.sanJiaoImageView.image = Imaged(@"market_icon_choice");
}
@end
