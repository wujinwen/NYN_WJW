//
//  NYNLeMJCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNLeMJCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *rightLab;
- (void)setData:(NSArray *)arr;
@end
