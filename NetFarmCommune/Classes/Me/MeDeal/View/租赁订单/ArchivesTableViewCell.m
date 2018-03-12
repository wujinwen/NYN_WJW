//
//  ArchivesTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/2.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ArchivesTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ArchivesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{
    [self.contentView addSubview:self.titleLabel];
     [self.contentView addSubview:self.contentLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(55);
        
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-9);
        make.top.mas_offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(55);
        
    }];
  
    
    
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
          _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return _titleLabel;
    
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor=[UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
    
}

@end
