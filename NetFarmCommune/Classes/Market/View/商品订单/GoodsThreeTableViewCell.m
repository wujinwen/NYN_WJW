//
//  GoodsThreeTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/8.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsThreeTableViewCell.h"
#import <Masonry/Masonry.h>

@interface GoodsThreeTableViewCell()

@end

@implementation GoodsThreeTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
        
    }
    return self;
    
}


-(void)initiaInterface{
    [self addSubview:self.headLabel];
    [self addSubview:self.titleLabel];
    
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(30);
        make.width.mas_offset(80);
        make.top.mas_offset(15);

        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headLabel.mas_right).offset(10);
        make.height.mas_offset(30);
        make.width.mas_offset(SCREENWIDTH-80);
        make.top.mas_offset(15);
    }];
    
    
    
    
}

-(void)setModel:(NYNMarketListModel *)model{
    _model = model;
    if ([_indexpath intValue]==0) {
        _titleLabel.text = model.name;
        
    }else if ([_indexpath intValue]==1){
         _titleLabel.text = model.fullCategoryName;
        
    }else if ([_indexpath intValue]==2){
        _titleLabel.text = model.farm[@"name"];
        
    }else{
       _titleLabel.text = model.farm[@"address"];
    }
    
    
    
}


-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]init];
        _headLabel.textColor=[UIColor blackColor];
        
        
    }
    return _headLabel;
    
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor=[UIColor blackColor];
    }
    return _titleLabel;
    
}
@end
