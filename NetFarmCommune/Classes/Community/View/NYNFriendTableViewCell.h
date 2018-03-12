//
//  NYNFriendTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrinedModel.h"

@interface NYNFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property(nonatomic,strong)FrinedModel * model;

@end
