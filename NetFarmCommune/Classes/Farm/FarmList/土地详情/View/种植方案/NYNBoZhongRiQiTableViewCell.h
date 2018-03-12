//
//  NYNBoZhongRiQiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellClickBlock)(NSString *s);

@interface NYNBoZhongRiQiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *riqiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiantouLabel;
@property (weak, nonatomic) IBOutlet UIView *xiaView;
@property (nonatomic,copy) CellClickBlock cellClick;
@end
