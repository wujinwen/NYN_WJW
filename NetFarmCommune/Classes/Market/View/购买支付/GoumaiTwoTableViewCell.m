//
//  GoumaiTwoTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoumaiTwoTableViewCell.h"

@implementation GoumaiTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)guanliClick:(UIButton *)sender {
    
    if (self.guanliBlock) {
        //将自己的值传出去，完成传值
        self.guanliBlock(@"");
    }
}
-(void)setLictModel:(NYNMarketListModel *)lictModel{
    _lictModel = lictModel;
      _addressLabel.text = self.lictModel.defaultUserAddressTitle;
//    _phoneLabel.text = self.lictModel
    
}

@end
