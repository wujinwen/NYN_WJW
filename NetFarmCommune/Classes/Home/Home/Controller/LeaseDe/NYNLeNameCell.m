//
//  NYNLeNameCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNLeNameCell.h"

@implementation NYNLeNameCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    _name = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"测试sadugf" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_name];
    _headImg = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"home_button_message2"]];
    [self.contentView addSubview:_headImg];
    
    _message = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"farm_icon_news"]];
    [self.contentView addSubview:_message];
    
    _phone = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"farm_icon_phone"]];
    [self.contentView addSubview:_phone];
    
    UIImageView *line = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];

    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    UIView *groline = [[UIView alloc]init];
    groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:groline];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.with.mas_offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_offset(10);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.headImg.mas_right).offset(10);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.width.mas_offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(20);
        make.width.mas_offset(2);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(_phone.mas_left).offset(-20);
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.width.mas_offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(line.mas_left).offset(-20);
    }];
    
    [groline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.offset(0);
    }];
}

@end
