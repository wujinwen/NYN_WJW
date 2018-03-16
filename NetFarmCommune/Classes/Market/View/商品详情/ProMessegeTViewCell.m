//
//  ProMessegeTViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ProMessegeTViewCell.h"
#import <Masonry/Masonry.h>

@implementation ProMessegeTViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.imageview];
    [self.textView setEditable:NO];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
       make.right.mas_offset(-10);
        make.top.mas_offset(10);
        make.height.mas_offset(60);
        
    }];
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(self.textView.mas_bottom).offset(8);
        make.height.mas_offset(170);
        
    }];
    
    
    
    
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor=[UIColor blackColor];
        [_textView setEditable:NO];
        _textView.font = [UIFont systemFontOfSize:12];
        
    }
    return _textView;
    
}
-(UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
        
    }
    return _imageview;
    
}
@end
