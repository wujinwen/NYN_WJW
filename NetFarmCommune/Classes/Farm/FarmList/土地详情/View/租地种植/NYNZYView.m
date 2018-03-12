//
//  NYNZYView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZYView.h"

@implementation NYNZYView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _chooseButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - JZWITH(120)) / 2, (self.height - JZHEIGHT(45)) / 2, JZWITH(120), JZHEIGHT(45))];
        [_chooseButton addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chooseButton];
    }
    return self;
}

- (void)choose{
    if (self.ChooseBlock) {
        //将自己的值传出去，完成传值
        self.ChooseBlock(@"");
    }
}
@end
