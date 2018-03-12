//
//  WuLiuTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "WuLiuTableViewCell.h"

@implementation WuLiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setExpressArray:(NSMutableDictionary *)expressArray{
    _expressArray = expressArray;
    _addressLabel.text = _expressArray[@"context"];
    _timeLabel.text =[MyControl timeWithTimeIntervalString:_expressArray[@"time"]];
}

@end
