//
//  NYNLeMJCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNLeMJCell.h"

@implementation NYNLeMJCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    _leftLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"土地面积" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_leftLab];
    
    _rightLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"20㎡" color:[UIColor grayColor] font:[UIFont systemFontOfSize:14.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_rightLab];
    
    UIImageView *groline = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:groline];
    [groline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.offset(0);
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_offset(10);
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}
- (void)setData:(NSArray *)arr{
    _leftLab.text = arr[0];
    _rightLab.text = arr[1];
}
@end
