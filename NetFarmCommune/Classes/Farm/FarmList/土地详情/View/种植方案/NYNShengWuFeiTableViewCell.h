//
//  NYNShengWuFeiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellClick)(NSString *s);

@interface NYNShengWuFeiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *danWeiLabel;
@property (weak, nonatomic) IBOutlet UIView *xiaView;

@property (nonatomic,copy) CellClick cellClick;
@end
