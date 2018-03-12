//
//  StopSpeakTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "StopSpeakTVCell.h"




@implementation StopSpeakTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor * color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.7];
    UIGestureRecognizer * singleTap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    _headImage.userInteractionEnabled = YES;
    [_headImage addGestureRecognizer:singleTap];
    
    
    
}




//头像点击事件
-(void)singleTapAction:(UIGestureRecognizer*)tap{
    

}




//连麦按钮
- (IBAction)speakBtn:(UIButton *)sender {
    
    
}

@end
