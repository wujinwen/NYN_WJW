//
//  NYNMeChongZhiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeChongZhiTableViewCell.h"

@implementation NYNMeChongZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.chooseButton addTarget:self action:@selector(chooseButtonclick:) forControlEvents:UIControlEventTouchUpInside];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chooseButton:(UIButton *)sender {
    _Selected = !_Selected;
    if(_Selected) {
        NSLog(@"选中");
//        [_chooseButton setImage:[UIImage imageNamed:@"farm_icon_selected4"] forState:UIControlStateNormal];
        _chooseImageView.image =[UIImage imageNamed:@"farm_icon_selected"];
   
    }else {
        NSLog(@"取消选中");
         _chooseImageView.image =[UIImage imageNamed:@"farm_icon_notselected3"];
    }
    
    
}

//farm_icon_selected4
@end
