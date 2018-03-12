//
//  NYNSuYuanTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNSuYuanTableViewCell.h"

@implementation NYNSuYuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.suYuanButton.layer.cornerRadius = 4;
    self.suYuanButton.layer.masksToBounds = YES;
    [self.suYuanButton addTarget:self action:@selector(suyuan) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)suyuan{
    JZLog(@"溯源");
    if (self.SuYuanBlock) {
        //将自己的值传出去，完成传值
        self.SuYuanBlock(@"");
    }
}

@end
