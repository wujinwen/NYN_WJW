//
//  NYNFriendTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNFriendTableViewCell.h"

@implementation NYNFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(FrinedModel *)model{
    _model = model;
    
    
    //friendTVCell.nameLabel.text = [_frindArr[indexPath.row] valueForKey:@"name"];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[model.friend1 valueForKey:@"avatar"]] placeholderImage:PlaceImage];
    
    self.nameLabel.text = [model.friend1 valueForKey:@"name"];
//    self.ageLabel.text = [model.friend1 valueForKey:@"age"];
    
    
    
}
@end
