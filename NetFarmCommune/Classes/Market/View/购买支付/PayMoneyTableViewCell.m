//
//  PayMoneyTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "PayMoneyTableViewCell.h"

@implementation PayMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _PayMonyBtn.layer.cornerRadius=10;
    _PayMonyBtn.clipsToBounds = YES;
    _PayMonyBtn.layer.borderWidth = 1;
    _PayMonyBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//付款
- (IBAction)payButton:(UIButton *)sender {
    
    if (self.moneyBlock) {
        //将自己的值传出去，完成传值
        self.moneyBlock(@"");
    }
}




@end
