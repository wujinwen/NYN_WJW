//
//  NYNMonthCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNMonthCell.h"

@implementation NYNMonthCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    _name = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"我要租赁：" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_name];
    UIImageView *groline = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:groline];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.top.mas_offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    _numbMonth = [NYNYCCommonCtrl commonTextFieldWithFrame:CGRectZero
                                               placeholder:@"0" color:nil font:[UIFont systemFontOfSize:14] secureTextEntry:NO delegate:self];
    _numbMonth.layer.borderColor = SureColor.CGColor;
    _numbMonth.layer.borderWidth = 1;
    _numbMonth.textAlignment = 1;
    _numbMonth.layer.cornerRadius = 3;
    _numbMonth.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_numbMonth];
    [_numbMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.width.mas_offset(70);
        make.centerY.mas_equalTo(_name.mas_centerY);
        make.left.equalTo(_name.mas_right).offset(10);
    }];
    
    UILabel *tmothLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"个月" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:tmothLab];
    
    [tmothLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(_name.mas_centerY);
        make.left.equalTo(_numbMonth.mas_right).offset(10);
    }];
    
    UILabel *tmoneyLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"合计金额：" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:tmoneyLab];
    [tmoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.bottom.mas_offset(-5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    _totleMoney = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"10.00元" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_totleMoney];
    [_totleMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.bottom.mas_offset(-5);
        make.left.equalTo(tmoneyLab.mas_right).offset(10);
    }];
    
    UIImageView *nextImg = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"farm_icon_more1"]];
    [self.contentView addSubview:nextImg];
    
    [nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.centerY.mas_equalTo(tmoneyLab.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];

    
    
    UILabel *tiaoli = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"同意租地条例" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:tiaoli];
    [tiaoli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(tmoneyLab.mas_centerY);
        make.right.equalTo(nextImg.mas_right).offset(-10);
    }];
    
    _chooseBtn = [NYNYCCommonCtrl commonButtonWithFrame:CGRectZero title:@"" color:nil font:nil backgroundImage:[UIImage imageNamed:@"farm_icon_selected"] target:self action:@selector(choose:)];
     [self.contentView addSubview:_chooseBtn];
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_offset(17);
        make.centerY.mas_equalTo(tmoneyLab.mas_centerY);
        make.right.equalTo(tiaoli.mas_left).offset(-10);
    }];
    
    [groline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.offset(0);
    }];
    
}

- (void)choose:(UIButton *)sender{
    
    
}


@end
