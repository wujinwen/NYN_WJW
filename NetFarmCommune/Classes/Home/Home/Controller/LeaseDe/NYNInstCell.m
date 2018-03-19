//
//  NYNInstCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNInstCell.h"

@implementation NYNInstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    _name = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"土地说明" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_name];
    UIImageView *groline = [NYNYCCommonCtrl commonImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:groline];
    
    _contentLab = [NYNYCCommonCtrl commonLableWithFrame:CGRectZero text:@"贾师傅UHF䦹jk.hfg.。按开机水电费会计方法如风快乐十分了爱上了；开房记录；安抚爱是；FJK是DF你" color:[UIColor grayColor] font:[UIFont systemFontOfSize:14.0f] textAlignment:NSTextAlignmentLeft];
    _contentLab.numberOfLines = 0;
    [self.contentView addSubview:_contentLab];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.top.mas_offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.top.mas_equalTo(_name.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [groline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.offset(0);
    }];
    
}

@end
