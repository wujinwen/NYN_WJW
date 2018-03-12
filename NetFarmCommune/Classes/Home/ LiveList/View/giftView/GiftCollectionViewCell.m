//
//  GiftCollectionViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "GiftCollectionViewCell.h"
#import "Masonry.h"

@interface GiftCollectionViewCell()




@end

@implementation GiftCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        
    }
    return self;
    
}

-(void)initUI{
    
    _giftImage=[[UIImageView alloc]init];
    _giftImage.image = [UIImage imageNamed:@"占位图"];
    [self.contentView addSubview:_giftImage];
    [_giftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(8);
        make.width.height.mas_offset(30);
        
    }];
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.text = @"88金豆";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_giftImage.mas_bottom).offset(10);
        make.bottom.mas_offset(6);
         make.centerX.mas_equalTo(self.contentView);
        
    }];
    
    
    
}

-(void)setGiftModel:(GiftListModel *)giftModel{
    _giftModel = giftModel;
    [_giftImage sd_setImageWithURL:[NSURL URLWithString:giftModel.giftImg]];

    _titleLabel.text = giftModel.giftName;
    

}

@end
