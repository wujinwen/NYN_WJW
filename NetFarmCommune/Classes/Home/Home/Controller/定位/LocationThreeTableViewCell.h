//
//  LocationThreeTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressPickerView.h"

typedef void(^citySelectClick)();

@interface LocationThreeTableViewCell : UITableViewCell

@property (nonatomic,copy) citySelectClick cityClick;
@property (weak, nonatomic) IBOutlet UIButton *citySelectBtn;//城市选择
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;//城市

@end
