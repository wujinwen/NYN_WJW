//
//  NYNDIYTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellClick)(NSString *str);

@interface NYNDIYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (nonatomic,copy) CellClick cellClick;
@end
