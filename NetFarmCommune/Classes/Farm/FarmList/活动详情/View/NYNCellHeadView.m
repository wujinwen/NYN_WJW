//
//  NYNCellHeadView.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNCellHeadView.h"

@implementation NYNCellHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.greenLine = [[UIView alloc]init];
        self.greenLine.backgroundColor = SureColor;
        [self addSubview:self.greenLine];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.font = JZFont(14);
        self.titleLab.text = @"标题";
        [self addSubview:self.titleLab];
        
        [self.greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(15);
            make.width.mas_offset(3);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(10);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(10);
            make.width.mas_offset(70);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.greenLine.mas_right).offset(10);
        }];
    }
    return  self;
}

@end
