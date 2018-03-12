//
//  NYNChoosePeiSongAddressTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAddressBlock)();

@interface NYNChoosePeiSongAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dizhiLabel;//地址label

@property(nonatomic,copy)SelectAddressBlock block;


@end
