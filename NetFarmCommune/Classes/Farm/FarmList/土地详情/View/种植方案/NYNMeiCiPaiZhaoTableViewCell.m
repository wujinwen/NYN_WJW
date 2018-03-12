//
//  NYNMeiCiPaiZhaoTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeiCiPaiZhaoTableViewCell.h"

@implementation NYNMeiCiPaiZhaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.count = 0;
    self.jiaImageView.userInteractionEnabled = YES;
    self.jianImageView.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)jianAction:(id)sender {
    self.count--;
    if (self.count < 0) {
        self.count = 0;
    }
    if (self.clickBlock) {
        self.clickBlock(self.count);
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
}

- (IBAction)jiaAction:(id)sender {
    self.count++;
    
    if (self.clickBlock) {
        self.clickBlock(self.count);
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
}


-(void)setCount:(int)count{
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%d",count];
}
@end
