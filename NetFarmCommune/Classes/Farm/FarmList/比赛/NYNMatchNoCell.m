//
//  NYNMatchNoCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNMatchNoCell.h"

@implementation NYNMatchNoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
        self.leftLab.font = JZFont(14);
        [self.contentView addSubview:self.leftLab];
        
        self.rightLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-80, 0, SCREENWIDTH-90, 50)];
        self.rightLab.font = JZFont(14);
        self.rightLab.textAlignment = 2;
        self.rightLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.rightLab];
        
        UIView *groline = [[UIView alloc]init];
        groline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:groline];
        [groline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1);
            make.top.equalTo(self.contentView.mas_bottom).offset(-1);
            make.left.right.offset(0);
        }];
        
        [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.left.mas_equalTo(self.leftLab.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}


- (void)letfTitle:(NSString *)title rightTitle:(NSString *)rightT{
    
    self.leftLab.text = title;
    self.rightLab.text = rightT;
}

- (void)letftext:(NSString *)text{
    self.rightLab.text = text;
    self.leftLab.hidden = YES;
    self.rightLab.numberOfLines = 0;
    self.rightLab.textAlignment = 0;
    [self.rightLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
}

- (void)imgArr:(NSArray *)imgae{
    self.leftLab.hidden = YES;
    self.rightLab.hidden = YES;
    UIImageView *img = [[UIImageView alloc]init];
    [self.contentView addSubview:img];
    [img sd_setImageWithURL:[NSURL URLWithString:imgae[0]] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.height.mas_offset((SCREENWIDTH - 40)/3);
        make.left.mas_offset(10);
    }];
}

@end
