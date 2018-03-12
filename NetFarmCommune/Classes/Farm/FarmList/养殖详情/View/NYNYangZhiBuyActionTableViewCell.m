//
//  NYNYangZhiBuyActionTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNYangZhiBuyActionTableViewCell.h"

@implementation NYNYangZhiBuyActionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.count = 0;
    
    self.jiaImageView.userInteractionEnabled = YES;
    self.jianImageView.userInteractionEnabled = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    if (self.selectClick) {
        self.selectClick(self.count);
    }
    
    self.countLable.text = [NSString stringWithFormat:@"%d",self.count];
    
}

- (IBAction)jiaAction:(id)sender {
    self.count++;
    
    if (self.selectClick) {
        self.selectClick(self.count);
    }
    
    self.countLable.text = [NSString stringWithFormat:@"%d",self.count];
}


-(void)setCount:(int)count{
    _count = count;
    self.countLable.text = [NSString stringWithFormat:@"%d",self.count];
}
@end
