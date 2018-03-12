//
//  NYNGouMaiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGouMaiTableViewCell.h"

@implementation NYNGouMaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.jianImageView.userInteractionEnabled  = YES;
    self.jiaImageView.userInteractionEnabled = YES;
    
    self.count = 0;
    self.titleLabel.text = [NSString stringWithFormat:@"%d",self.count];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)jianAction:(id)sender {
    JZLog(@"面积-");
    if (self.shichangBlock) {
        //将自己的值传出去，完成传值
        self.shichangBlock(@"-");
    }
    
    self.count--;
    if (self.count < 0) {
        self.count = 0;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%d",self.count];
    
}
- (IBAction)jiaImageView:(id)sender {
    
    JZLog(@"面积+");
    if (self.shichangBlock) {
        //将自己的值传出去，完成传值
        self.shichangBlock(@"+");
    }
    
    self.count++;
    if (self.count < 0) {
        self.count = 0;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%d",self.count];
}

@end
