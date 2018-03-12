//
//  NYNZhongZhiZhouQiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZhongZhiZhouQiTableViewCell.h"

@implementation NYNZhongZhiZhouQiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.count = 0;
    
    self.jianImageView.userInteractionEnabled = YES;
    self.jiaImageView.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)jianAction:(id)sender {
    self.count--;
    if (self.count < 1) {
        self.count = 1;
    }
    
    
    if (self.clickBlock) {
        self.clickBlock(self.count);
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
}

- (IBAction)jiaImageView:(id)sender {
    self.count++;
    
    if (self.clickBlock) {
        self.clickBlock(self.count);
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
    
}


-(void)setCount:(int)count{
    _count =count;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];

}
@end
