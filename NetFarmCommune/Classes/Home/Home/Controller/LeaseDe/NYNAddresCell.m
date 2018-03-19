//
//  NYNAddresCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNAddresCell.h"

@implementation NYNAddresCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    _name = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"土地地址" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_name];
    
    _contenLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"成都市电话费圣诞节好烦" color:[UIColor grayColor] font:[UIFont systemFontOfSize:14.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_contenLab];
    
    UIImageView *groline = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:groline];
    
    UIImageView *headImg = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"farm_icon_address2"]];
    [self.contentView addSubview:headImg];
    
    UIImageView *nextImg = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"farm_icon_more1"]];
    [self.contentView addSubview:nextImg];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.width.mas_offset(60);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.width.mas_offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(_name.mas_right).offset(10);
    }];
    
    [nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [_contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(headImg.mas_right).offset(10);
        make.right.equalTo(nextImg.mas_right).offset(-5);
    }];
    
    [groline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.offset(0);
    }];
    
}

@end
