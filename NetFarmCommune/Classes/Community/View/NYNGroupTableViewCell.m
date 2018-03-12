//
//  NYNGroupTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGroupTableViewCell.h"

@implementation NYNGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMoedel:(GrounpModel *)moedel{
    _moedel = moedel;
    self.namelabel.text = moedel.name;
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:_moedel.avatar] placeholderImage:PlaceImage];
    // NSString  * str = [_dataArr[indexPath.row] valueForKey:@"usersCount"];
    
//    self.ageLabel.text =;
   self.ageLabel.text=  [_moedel.city valueForKey:@"city"];
    
}

@end
