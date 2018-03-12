//
//  NEinfoTableViewCell.h
//  NetworkEngineer
//
//  Created by 123 on 2017/5/16.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEinfoTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIImageView *dianImageView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@end
