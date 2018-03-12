//
//  FTMeFunctionTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTMeFunctionTableViewCell.h"
#import "FTMeFunctionButton.h"

@implementation FTMeFunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSArray *imageArr = @[@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图"];
    NSArray *textArr = @[@"我的代金券",@"我的活动",@"我的众筹",@"我的收藏",@"意见反馈",@"投资"];
    
    
    CGFloat cellWith = JZWITH(60);
    CGFloat cellHeight = JZHEIGHT(50);
    
    CGFloat jiangeWith = (SCREENWIDTH - (JZWITH(80) + 3 * JZWITH(60))) / 2;
    
    for (int i = 0; i < 6 ; i++) {
        FTMeFunctionButton *bt = [[FTMeFunctionButton alloc]initWithFrame:CGRectMake(JZWITH(40) + (JZWITH(60) + jiangeWith) * (i % 3), JZHEIGHT(30) + JZHEIGHT(100) * (i / 3), cellWith, cellHeight)];
        bt.picImageView.image = Imaged(imageArr[i]);
        bt.textLabel.text = textArr[i];
        [self.contentView addSubview:bt];
        
        bt.tag = i;
        [bt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(100), SCREENWIDTH, 0.5)];
    [self.contentView addSubview:lineView];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}

@end
