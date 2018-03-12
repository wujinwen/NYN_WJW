//
//  SaleTwoTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleTwoTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation SaleTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}


-(void)initiaInterface{
   _farmLabel = [[UILabel alloc]init];
    _farmLabel.text=@"花果山土地";
    _farmLabel.textColor=[UIColor blackColor];
    _farmLabel.font=[UIFont systemFontOfSize:17];
    [self.contentView addSubview:_farmLabel];
    [_farmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.height.mas_offset(30);
        make.width.mas_offset(200);
    }];
    
    
    _locationImage = [[UIImageView alloc]init];
    _locationImage.image = [UIImage imageNamed:@"farm_icon_address2"];
    [self.contentView addSubview:_locationImage];
    [_locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_farmLabel.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.width.mas_offset(15);
        make.height.mas_offset(20);
        
        
    }];
    
    
    _locationLabel= [[UILabel alloc]init];
    _locationLabel.text=@"成都市高新区天府二街蜀都中心";
    _locationLabel.font = [UIFont systemFontOfSize:15];
    _locationLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_locationImage.mas_right).offset(7);
        make.top.mas_equalTo(_farmLabel.mas_bottom).offset(10);
        make.width.mas_offset(300);
        make.height.mas_offset(30);
    }];
    
  
    
    _distanceLabel = [[UILabel alloc]init];
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.textColor=[UIColor darkGrayColor];
     _distanceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.width.mas_offset(200);
        make.bottom.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    _phoneButton = [[UIButton alloc]init];
    [_phoneButton setImage:Imaged(@"farm_icon_phone") forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneButton];
    [_phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.width.mas_offset(20);
        make.top.mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    
    lineLabel.alpha=0.5;
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(_locationLabel.mas_bottom).offset(5);
        make.height.mas_offset(2);
    }];
    
//    UILabel * lineLabel1 = [[UILabel alloc]init];
//    lineLabel1.backgroundColor = [UIColor darkGrayColor];
//    lineLabel1.alpha=0.5;
//    [self.contentView addSubview:lineLabel1];
//    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(8);
//        make.width.mas_offset(90);
//        make.top.equalTo(_locationLabel.mas_bottom).offset(5);
//        make.height.mas_offset(25);
//    }];
//
    
     
    
    
      [self.contentView addSubview:self.zerenLabel];
      [self.contentView addSubview:self.zerenNameLabel];
     [self.contentView addSubview:self.phoneLabel];
     [self.contentView addSubview:self.phoneNumberBtn];
    
    [self.zerenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.width.mas_offset(90);
        make.top.equalTo(lineLabel.mas_bottom).offset(5);
        make.height.mas_offset(25);
    }];
    
    [self.zerenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.width.mas_offset(100);
          make.top.equalTo(_locationLabel.mas_bottom).offset(5);
        make.height.mas_offset(25);
        
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.width.mas_offset(100);
        make.top.equalTo(self.zerenLabel.mas_bottom).offset(5);
        make.height.mas_offset(25);
        
        
    }];
    [self.phoneNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.width.mas_offset(100);
       make.top.equalTo(self.zerenLabel.mas_bottom).offset(5);
        make.height.mas_offset(25);
    }];
}



-(UILabel *)zerenLabel{
    if (!_zerenLabel) {
        _zerenLabel = [[UILabel alloc]init];
        _zerenLabel.text=@"责任人";
        _zerenLabel.textColor=[UIColor blackColor];
        _zerenLabel.font=[UIFont systemFontOfSize:16];
        
    }
    return _zerenLabel;
    
}


-(UIButton *)zerenNameLabel{
    if (!_zerenNameLabel) {
        _zerenNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zerenNameLabel setTitle:@"张德方" forState:UIControlStateNormal];
        [_zerenNameLabel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _zerenNameLabel.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    return _zerenNameLabel;
    
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text=@"联系电话";
        _phoneLabel.textColor=[UIColor blackColor];
        _phoneLabel.font=[UIFont systemFontOfSize:16];
    }
    return _phoneLabel;
    
}

-(UIButton *)phoneNumberBtn{
    if (!_phoneNumberBtn) {
        _phoneNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneNumberBtn setTitle:@"189898767467" forState:UIControlStateNormal];
        [_phoneNumberBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _phoneNumberBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    return _phoneNumberBtn;
    
}
@end
