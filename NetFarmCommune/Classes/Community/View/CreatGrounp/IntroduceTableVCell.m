//
//  IntroduceTableVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "IntroduceTableVCell.h"




@implementation IntroduceTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 60, SCREENWIDTH-30, 100)];
    _textView.layer.cornerRadius = 5;
    _textView.clipsToBounds = YES;
    _textView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    
    
    [self.contentView addSubview:self.textView];
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
