//
//  NYNMeiCiPaiZhaoTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickActionBlock) (int count);

@interface NYNMeiCiPaiZhaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jianImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiaImageView;
@property (weak, nonatomic) IBOutlet UILabel *danweiLabel;

@property (nonatomic,assign) int count;
@property (nonatomic,copy) clickActionBlock clickBlock;
@end
