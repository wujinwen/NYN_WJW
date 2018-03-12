//
//  NYNMeChongZhiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^goumaiBlock) (NSString *strValue);

@interface NYNMeChongZhiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@property(nonatomic,assign)BOOL Selected;
@property(nonatomic, copy) goumaiBlock goumaiBlock;



@end
