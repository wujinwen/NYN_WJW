//
//  NYNZhongZhiZhouQiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^clickBlock) (int count);
@interface NYNZhongZhiZhouQiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jianImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiaImageView;
@property (weak, nonatomic) IBOutlet UILabel *danWeiLabel;
@property (nonatomic,copy) clickBlock clickBlock;
@property (nonatomic,assign) int count;

@property (weak, nonatomic) IBOutlet UIView *xiaView;


@end
