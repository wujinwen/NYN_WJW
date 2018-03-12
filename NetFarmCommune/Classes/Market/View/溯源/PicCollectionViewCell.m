//
//  PicCollectionViewCell.m
//  CBFTestWork
//
//  Created by qwe on 2018/1/21.
//  Copyright © 2018年 CBF. All rights reserved.
//

#import "PicCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation PicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.image = [UIImage imageNamed:@"icon"];
    [self.contentView addSubview:_imageView];
       _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
