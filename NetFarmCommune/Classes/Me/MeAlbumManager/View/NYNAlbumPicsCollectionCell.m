//
//  NYNAlbumPicsCollectionCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNAlbumPicsCollectionCell.h"

@implementation NYNAlbumPicsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.detelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detel)];
    [self.detelImageView addGestureRecognizer:tap];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.detelImageViewW = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - JZWITH(30), 0, JZWITH(30), JZHEIGHT(30))];
        self.detelImageViewW.userInteractionEnabled = YES;
        self.detelImageViewW.image = Imaged(@"mine_icon_delete4");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detel)];
        [self.detelImageViewW addGestureRecognizer:tap];
        
        self.picImgeViewW = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.contentView addSubview:self.picImgeViewW];
        [self.contentView addSubview:self.detelImageViewW];

    }
    return self;
}

- (void)detel{
    if (self.detelBlock) {
        self.detelBlock(self.indexPath);
    }
}

@end
